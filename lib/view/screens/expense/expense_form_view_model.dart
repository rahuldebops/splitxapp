import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitxapp/data/expense/expense_repo.dart';
import 'package:splitxapp/data/expense/models/expense_create_request_model.dart' as create_request_model;
import 'package:splitxapp/data/expense/models/expense_update_request_model.dart' as update_request_model;
import 'package:splitxapp/data/groups/group_repo.dart';
import 'package:splitxapp/domain/provider/repository_provider.dart';
import 'package:splitxapp/models/group_member.dart';
import 'package:splitxapp/view/screens/expense/expense_form_view.dart';
import 'package:splitxapp/utils/extensions.dart';

final expenseFormViewModelProvider = StateNotifierProvider.family<ExpenseFormViewModel, ExpenseFormState, String>((ref, groupId) {
  final expenseRepo = ref.watch(expenseRepoProvider);
  final groupRepoo = ref.watch(groupRepo);
  return ExpenseFormViewModel(groupId, expenseRepo, groupRepoo);
});

enum BalanceStatus {
  balanced,
  paymentImbalanced,
  splitImbalanced,
  bothImbalanced,
}

class ExpenseFormState {
  final bool loading;
  final List<GroupMember> groupMembers;
  final List<GroupMember> selectedPayers;
  final List<GroupMember> selectedSplitMembers;
  final Map<String, double> payerAmounts;
  final Map<String, double> splitAmounts;
  final String? selectedCategory;
  final SplitMode splitMode;
  final double totalAmount;
  final String? error;
  final String? successMessage;
  final BalanceStatus balanceStatus;

  ExpenseFormState({
    this.loading = false,
    this.groupMembers = const [],
    this.selectedPayers = const [],
    this.selectedSplitMembers = const [],
    this.payerAmounts = const {},
    this.splitAmounts = const {},
    this.selectedCategory,
    this.splitMode = SplitMode.equally,
    this.totalAmount = 0.0,
    this.error,
    this.successMessage,
    this.balanceStatus = BalanceStatus.balanced,
  });

  // Balance calculations
  double get totalPayments => payerAmounts.values.fold(0.0, (sum, amount) => sum + amount);
  double get totalSplits => splitAmounts.values.fold(0.0, (sum, amount) => sum + amount);
  double get paymentDifference => totalAmount - totalPayments;
  double get splitDifference => totalAmount - totalSplits;
  
  bool get isPaymentBalanced => paymentDifference.abs() < 0.01;
  bool get isSplitBalanced => splitDifference.abs() < 0.01;
  bool get isCompletelyBalanced => isPaymentBalanced && isSplitBalanced;

  ExpenseFormState copyWith({
    bool? loading,
    List<GroupMember>? groupMembers,
    List<GroupMember>? selectedPayers,
    List<GroupMember>? selectedSplitMembers,
    Map<String, double>? payerAmounts,
    Map<String, double>? splitAmounts,
    String? selectedCategory,
    SplitMode? splitMode,
    double? totalAmount,
    String? error,
    String? successMessage,
    BalanceStatus? balanceStatus,
  }) {
    return ExpenseFormState(
      loading: loading ?? this.loading,
      groupMembers: groupMembers ?? this.groupMembers,
      selectedPayers: selectedPayers ?? this.selectedPayers,
      selectedSplitMembers: selectedSplitMembers ?? this.selectedSplitMembers,
      payerAmounts: payerAmounts ?? this.payerAmounts,
      splitAmounts: splitAmounts ?? this.splitAmounts,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      splitMode: splitMode ?? this.splitMode,
      totalAmount: totalAmount ?? this.totalAmount,
      error: error ?? this.error,
      successMessage: successMessage ?? this.successMessage,
      balanceStatus: balanceStatus ?? this.balanceStatus,
    );
  }
}

class ExpenseFormViewModel extends StateNotifier<ExpenseFormState> {
  final String groupId;
  final ExpenseRepo _expenseRepo;
  final GroupRepo _groupRepo;

  ExpenseFormViewModel(this.groupId, this._expenseRepo, this._groupRepo) : super(ExpenseFormState());

  Future<void> initialize(ExpenseFormMode mode, String? expenseId) async {
    try {
      state = state.copyWith(loading: true, error: null);
      
      await _loadGroupMembers();
      
      if (mode != ExpenseFormMode.create && expenseId != null) {
        await _loadExpenseDetails(expenseId);
      }
    } catch (e) {
      state = state.copyWith(
        error: _getErrorMessage(e),
        loading: false,
      );
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> _loadGroupMembers() async {
    try {
      final result = await _groupRepo.getGroupMembers(groupId);
      result.handle(
        onRight: (response) {
          final members = response.result.map((member) => GroupMember(
            id: member.id,
            name: member.fullName,
            email: member.email,
            color: _getRandomColor(),
          )).toList();
          
          if (members.isEmpty) {
            throw Exception('No group members found');
          }
          
          state = state.copyWith(groupMembers: members);
        },
        onLeft: (error) {
          throw Exception(error.message ?? 'Failed to load group members');
        },
      );
    } catch (e) {
      throw Exception('Error loading group members: ${e.toString()}');
    }
  }

  Future<void> _loadExpenseDetails(String expenseId) async {
    try {
      final result = await _expenseRepo.getExpenseDetails(expenseId);
      result.handle(
        onRight: (response) {
          final expense = response.result;
          
          final payers = expense.payments.map((payment) => GroupMember(
            id: payment.paidBy.id,
            name: payment.paidBy.fullName,
            email: payment.paidBy.email,
            color: _getRandomColor(),
          )).toList();

          final splitMembers = expense.splits.map((split) => GroupMember(
            id: split.user.id,
            name: split.user.fullName,
            email: split.user.email,
            color: _getRandomColor(),
          )).toList();

          final payerAmounts = <String, double>{};
          for (final payment in expense.payments) {
            payerAmounts[payment.paidBy.id] = payment.amount;
          }

          final splitAmounts = <String, double>{};
          for (final split in expense.splits) {
            splitAmounts[split.user.id] = split.owedAmount;
          }

          state = state.copyWith(
            selectedPayers: payers,
            selectedSplitMembers: splitMembers,
            payerAmounts: payerAmounts,
            splitAmounts: splitAmounts,
            totalAmount: expense.amount,
            selectedCategory: 'Other',
          );
          
          _updateBalanceStatus();
        },
        onLeft: (error) {
          throw Exception(error.message ?? 'Failed to load expense details');
        },
      );
    } catch (e) {
      throw Exception('Error loading expense details: ${e.toString()}');
    }
  }

  void selectCategory(String? category) {
    state = state.copyWith(selectedCategory: category, error: null);
  }

  void updateAmount(double amount) {
    if (amount < 0) return;
    
    state = state.copyWith(totalAmount: amount, error: null);
    _recalculateSplits();
    _updateBalanceStatus();
  }

  void addPayer(GroupMember member) {
    if (state.selectedPayers.any((p) => p.id == member.id)) return;
    
    final updatedPayers = [...state.selectedPayers, member];
    final updatedAmounts = Map<String, double>.from(state.payerAmounts);
    updatedAmounts[member.id] = 0.0;
    
    state = state.copyWith(
      selectedPayers: updatedPayers,
      payerAmounts: updatedAmounts,
      error: null,
    );
    _updateBalanceStatus();
  }

  void removePayer(String memberId) {
    final updatedPayers = state.selectedPayers.where((p) => p.id != memberId).toList();
    final updatedAmounts = Map<String, double>.from(state.payerAmounts);
    updatedAmounts.remove(memberId);
    
    state = state.copyWith(
      selectedPayers: updatedPayers,
      payerAmounts: updatedAmounts,
      error: null,
    );
    _updateBalanceStatus();
  }

  void updatePayerAmount(String memberId, double amount) {
    if (amount < 0) return;
    
    final updatedAmounts = Map<String, double>.from(state.payerAmounts);
    updatedAmounts[memberId] = amount;
    
    state = state.copyWith(payerAmounts: updatedAmounts, error: null);
    _updateBalanceStatus();
  }

  void addSplitMember(GroupMember member) {
    if (state.selectedSplitMembers.any((m) => m.id == member.id)) return;
    
    final updatedMembers = [...state.selectedSplitMembers, member];
    state = state.copyWith(selectedSplitMembers: updatedMembers, error: null);
    _recalculateSplits();
    _updateBalanceStatus();
  }

  void removeSplitMember(String memberId) {
    final updatedMembers = state.selectedSplitMembers.where((m) => m.id != memberId).toList();
    final updatedAmounts = Map<String, double>.from(state.splitAmounts);
    updatedAmounts.remove(memberId);
    
    state = state.copyWith(
      selectedSplitMembers: updatedMembers,
      splitAmounts: updatedAmounts,
      error: null,
    );
    _recalculateSplits();
    _updateBalanceStatus();
  }

  void changeSplitMode(SplitMode mode) {
    state = state.copyWith(splitMode: mode, error: null);
    _recalculateSplits();
    _updateBalanceStatus();
  }

  void updateSplitAmount(String memberId, double amount) {
    if (amount < 0) return;
    
    final updatedAmounts = Map<String, double>.from(state.splitAmounts);
    updatedAmounts[memberId] = amount;
    
    state = state.copyWith(splitAmounts: updatedAmounts, error: null);
    _updateBalanceStatus();
  }

  void _recalculateSplits() {
    if (state.splitMode == SplitMode.equally && state.selectedSplitMembers.isNotEmpty) {
      final amountPerPerson = state.totalAmount / state.selectedSplitMembers.length;
      final updatedAmounts = <String, double>{};
      
      for (final member in state.selectedSplitMembers) {
        updatedAmounts[member.id] = amountPerPerson;
      }
      
      state = state.copyWith(splitAmounts: updatedAmounts);
    }
  }

  void _updateBalanceStatus() {
    final isPaymentBalanced = state.isPaymentBalanced;
    final isSplitBalanced = state.isSplitBalanced;
    
    BalanceStatus status;
    if (isPaymentBalanced && isSplitBalanced) {
      status = BalanceStatus.balanced;
    } else if (!isPaymentBalanced && !isSplitBalanced) {
      status = BalanceStatus.bothImbalanced;
    } else if (!isPaymentBalanced) {
      status = BalanceStatus.paymentImbalanced;
    } else {
      status = BalanceStatus.splitImbalanced;
    }
    
    state = state.copyWith(balanceStatus: status);
  }

  Future<void> submitExpense(
    BuildContext context,
    String description,
    ExpenseFormMode mode,
    String? expenseId,
  ) async {
    try {
      // Clear previous messages
      state = state.copyWith(error: null, successMessage: null);
      
      // Validate form
      final validationError = _validateForm();
      if (validationError != null) {
        state = state.copyWith(error: validationError);
        return;
      }

      state = state.copyWith(loading: true);

      if (mode == ExpenseFormMode.create) {
        await _createExpense(description);
        state = state.copyWith(successMessage: 'Expense created successfully');
      } else if (mode == ExpenseFormMode.update && expenseId != null) {
        await _updateExpense(expenseId, description);
        state = state.copyWith(successMessage: 'Expense updated successfully');
      }

      Navigator.pop(context);
    } catch (e) {
      state = state.copyWith(error: _getErrorMessage(e));
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> _createExpense(String description) async {
    try {
      final payments = state.selectedPayers.map((payer) => create_request_model.Payment(
        paidBy: payer.id,
        amount: (state.payerAmounts[payer.id] ?? 0).round(),
      )).toList();

      final splits = state.selectedSplitMembers.map((member) => create_request_model.Split(
        userId: member.id,
        owedAmount: (state.splitAmounts[member.id] ?? 0).round(),
      )).toList();

      final request = create_request_model.ExpenseCreateRequestModel(
        groupId: groupId,
        description: description,
        amount: state.totalAmount.round(),
        payments: payments,
        splits: splits,
      );

      final result = await _expenseRepo.createExpense(request);
      result.handle(
        onRight: (response) {
          if (!response.result) {
            throw Exception(response.message ?? 'Failed to create expense');
          }
        },
        onLeft: (error) {
          throw Exception(error.message ?? 'Failed to create expense');
        },
      );
    } catch (e) {
      throw Exception('Create expense error: ${e.toString()}');
    }
  }

  Future<void> _updateExpense(String expenseId, String description) async {
    try {
      final payments = state.selectedPayers.map((payer) => update_request_model.Payment(
        paidBy: payer.id,
        amount: (state.payerAmounts[payer.id] ?? 0).round(),
      )).toList();

      final splits = state.selectedSplitMembers.map((member) => update_request_model.Split(
        userId: member.id,
        owedAmount: (state.splitAmounts[member.id] ?? 0).round(),
      )).toList();

      final request = update_request_model.ExpenseUpdateRequestModel(
        expenseId: expenseId,
        groupId: groupId,
        description: description,
        amount: state.totalAmount.round(),
        payments: payments,
        splits: splits,
      );

      final result = await _expenseRepo.updateExpense(expenseId, request);
      result.handle(
        onRight: (response) {
          if (!response.result) {
            throw Exception(response.message ?? 'Failed to update expense');
          }
        },
        onLeft: (error) {
          throw Exception(error.message ?? 'Failed to update expense');
        },
      );
    } catch (e) {
      throw Exception('Update expense error: ${e.toString()}');
    }
  }

  String? _validateForm() {
    if (state.selectedPayers.isEmpty) {
      return 'Please select at least one payer';
    }
    
    if (state.selectedSplitMembers.length < 2) {
      return 'Please select at least 2 members to split the expense';
    }
    
    if (state.totalAmount <= 0) {
      return 'Please enter a valid amount greater than 0';
    }
    
    if (state.selectedCategory == null) {
      return 'Please select a category';
    }
    
    if (!state.isCompletelyBalanced) {
      if (!state.isPaymentBalanced) {
        return 'Payment amounts must equal the total amount (₹${state.paymentDifference.abs().toStringAsFixed(2)} difference)';
      }
      if (!state.isSplitBalanced) {
        return 'Split amounts must equal the total amount (₹${state.splitDifference.abs().toStringAsFixed(2)} difference)';
      }
    }
    
    return null;
  }

  String _getErrorMessage(dynamic error) {
    if (error is Exception) {
      return error.toString().replaceFirst('Exception: ', '');
    }
    return error.toString();
  }

  Color _getRandomColor() {
    const colors = [
      Color(0xFF2563EB), Color(0xFF10B981), Color(0xFFF59E0B),
      Color(0xFFEF4444), Color(0xFF8B5CF6), Color(0xFF06B6D4),
      Color(0xFFEC4899), Color(0xFF84CC16), Color(0xFFF97316),
    ];
    return colors[DateTime.now().microsecond % colors.length];
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearSuccess() {
    state = state.copyWith(successMessage: null);
  }
}