// view/screens/expense/expense_form_view_model.dart
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
  });

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
    );
  }
}

class ExpenseFormViewModel extends StateNotifier<ExpenseFormState> {
  final String groupId;
  final ExpenseRepo _expenseRepo;
  final GroupRepo _groupRepo;

  ExpenseFormViewModel(this.groupId, this._expenseRepo, this._groupRepo)
      : super(ExpenseFormState());

  Future<void> initialize(ExpenseFormMode mode, String? expenseId) async {
    state = state.copyWith(loading: true);
    
    try {
      // Load group members
      await _loadGroupMembers();
      
      // If updating or viewing, load expense details
      if (mode != ExpenseFormMode.create && expenseId != null) {
        await _loadExpenseDetails(expenseId);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> _loadGroupMembers() async {
    // You'll need to add this method to GroupRepo
    final result = await _groupRepo.getGroupMembers(groupId);
    result.handle(
      onRight: (response) {
        final members = response.result.map((member) => GroupMember(
          id: member.id,
          name: member.fullName,
          email: member.email,
          color: Colors.blue, // You can assign different colors
        )).toList();
        
        state = state.copyWith(groupMembers: members);
      },
      onLeft: (error) {
        state = state.copyWith(error: error.message);
      },
    );
  }

  Future<void> _loadExpenseDetails(String expenseId) async {
    final result = await _expenseRepo.getExpenseDetails(expenseId);
    result.handle(
      onRight: (response) {
        final expense = response.result;
        
        // Map the API response to your UI state
        final payers = expense.payments.map((payment) => GroupMember(
          id: payment.paidBy.id,
          name: payment.paidBy.fullName,
          email: payment.paidBy.email,
          color: Colors.blue,
        )).toList();
        
        final splitMembers = expense.splits.map((split) => GroupMember(
          id: split.user.id,
          name: split.user.fullName,
          email: split.user.email,
          color: Colors.blue,
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
          selectedCategory: 'Other', // Default since API doesn't provide category
        );
      },
      onLeft: (error) {
        state = state.copyWith(error: error.message);
      },
    );
  }

  void selectCategory(String? category) {
    state = state.copyWith(selectedCategory: category);
  }

  void updateAmount(double amount) {
    state = state.copyWith(totalAmount: amount);
    _recalculateSplits();
  }

  void addPayer(GroupMember member) {
    final updatedPayers = [...state.selectedPayers, member];
    final updatedAmounts = Map<String, double>.from(state.payerAmounts);
    updatedAmounts[member.id] = 0.0;
    
    state = state.copyWith(
      selectedPayers: updatedPayers,
      payerAmounts: updatedAmounts,
    );
  }

  void removePayer(String memberId) {
    final updatedPayers = state.selectedPayers.where((p) => p.id != memberId).toList();
    final updatedAmounts = Map<String, double>.from(state.payerAmounts);
    updatedAmounts.remove(memberId);
    
    state = state.copyWith(
      selectedPayers: updatedPayers,
      payerAmounts: updatedAmounts,
    );
  }

  void updatePayerAmount(String memberId, double amount) {
    final updatedAmounts = Map<String, double>.from(state.payerAmounts);
    updatedAmounts[memberId] = amount;
    state = state.copyWith(payerAmounts: updatedAmounts);
  }

  void addSplitMember(GroupMember member) {
    final updatedMembers = [...state.selectedSplitMembers, member];
    state = state.copyWith(selectedSplitMembers: updatedMembers);
    _recalculateSplits();
  }

  void removeSplitMember(String memberId) {
    final updatedMembers = state.selectedSplitMembers.where((m) => m.id != memberId).toList();
    final updatedAmounts = Map<String, double>.from(state.splitAmounts);
    updatedAmounts.remove(memberId);
    
    state = state.copyWith(
      selectedSplitMembers: updatedMembers,
      splitAmounts: updatedAmounts,
    );
    _recalculateSplits();
  }

  void changeSplitMode(SplitMode mode) {
    state = state.copyWith(splitMode: mode);
    _recalculateSplits();
  }

  void updateSplitAmount(String memberId, double amount) {
    final updatedAmounts = Map<String, double>.from(state.splitAmounts);
    updatedAmounts[memberId] = amount;
    state = state.copyWith(splitAmounts: updatedAmounts);
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

  Future<void> submitExpense(
    BuildContext context,
    String description,
    ExpenseFormMode mode,
    String? expenseId,
  ) async {
    if (!_validateForm()) {
      _showError(context, 'Please fill all required fields correctly');
      return;
    }

    state = state.copyWith(loading: true);

    try {
      if (mode == ExpenseFormMode.create) {
        await _createExpense(description);
      } else if (mode == ExpenseFormMode.update && expenseId != null) {
        await _updateExpense(expenseId, description);
      }
      
      Navigator.pop(context);
      _showSuccess(context, mode == ExpenseFormMode.create 
          ? 'Expense created successfully' 
          : 'Expense updated successfully');
    } catch (e) {
      _showError(context, e.toString());
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> _createExpense(String description) async {
    final payments = state.selectedPayers.map((payer) => create_request_model.Payment(
      paidBy: payer.id,
      amount: (state.payerAmounts[payer.id] ?? 0).toInt(),
    )).toList();

    final splits = state.selectedSplitMembers.map((member) => create_request_model.Split(
      userId: member.id,
      owedAmount: (state.splitAmounts[member.id] ?? 0).toInt(),
    )).toList();

    final request = create_request_model.ExpenseCreateRequestModel(
      groupId: groupId,
      description: description,
      amount: state.totalAmount.toInt(),
      payments: payments,
      splits: splits,
    );

    final result = await _expenseRepo.createExpense(request);
    result.handle(
      onRight: (response) {
        // Success handled in submitExpense
      },
      onLeft: (error) {
        throw Exception(error.message);
      },
    );
  }

  Future<void> _updateExpense(String expenseId, String description) async {
    final payments = state.selectedPayers.map((payer) => update_request_model.Payment(
      paidBy: payer.id,
      amount: (state.payerAmounts[payer.id] ?? 0).toInt(),
    )).toList();

    final splits = state.selectedSplitMembers.map((member) => update_request_model.Split(
      userId: member.id,
      owedAmount: (state.splitAmounts[member.id] ?? 0).toInt(),
    )).toList();

    final request = update_request_model.ExpenseUpdateRequestModel(
      expenseId: expenseId,
      groupId: groupId,
      description: description,
      amount: state.totalAmount.toInt(),
      payments: payments,
      splits: splits,
    );

    final result = await _expenseRepo.updateExpense(expenseId, request);
    result.handle(
      onRight: (response) {
        // Success handled in submitExpense
      },
      onLeft: (error) {
        throw Exception(error.message);
      },
    );
  }

  bool _validateForm() {
    return state.selectedPayers.isNotEmpty &&
           state.selectedSplitMembers.length >= 2 &&
           state.totalAmount > 0 &&
           state.selectedCategory != null;
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}
