// view/screens/expense/expense_view_model.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitxapp/models/expense.dart';
import 'package:splitxapp/models/group_member.dart';
import 'package:splitxapp/helpers/base_view_model.dart';
import 'package:splitxapp/helpers/base_screen_view.dart';

final expenseViewModelProvider = StateNotifierProvider.family<ExpenseViewModel, ExpenseState, String?>(
  (ref, expenseId) => ExpenseViewModel(expenseId),
);

class ExpenseState {
  final bool loading;
  final bool saving;
  final String? error;
  final Expense? expense;
  final List<GroupMember> groupMembers;
  final String title;
  final String description;
  final double amount;
  final String category;
  final List<ExpensePayer> paidBy;
  final List<ExpenseSplit> splitBetween;
  final SplitType splitType;
  final bool isEditing;

  ExpenseState({
    this.loading = false,
    this.saving = false,
    this.error,
    this.expense,
    this.groupMembers = const [],
    this.title = '',
    this.description = '',
    this.amount = 0.0,
    this.category = 'Other',
    this.paidBy = const [],
    this.splitBetween = const [],
    this.splitType = SplitType.equally,
    this.isEditing = false,
  });

  ExpenseState copyWith({
    bool? loading,
    bool? saving,
    String? error,
    Expense? expense,
    List<GroupMember>? groupMembers,
    String? title,
    String? description,
    double? amount,
    String? category,
    List<ExpensePayer>? paidBy,
    List<ExpenseSplit>? splitBetween,
    SplitType? splitType,
    bool? isEditing,
  }) {
    return ExpenseState(
      loading: loading ?? this.loading,
      saving: saving ?? this.saving,
      error: error ?? this.error,
      expense: expense ?? this.expense,
      groupMembers: groupMembers ?? this.groupMembers,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      paidBy: paidBy ?? this.paidBy,
      splitBetween: splitBetween ?? this.splitBetween,
      splitType: splitType ?? this.splitType,
      isEditing: isEditing ?? this.isEditing,
    );
  }

  bool get isValid {
    return title.isNotEmpty &&
           description.isNotEmpty &&
           amount > 0 &&
           paidBy.isNotEmpty &&
           splitBetween.isNotEmpty &&
           isBalanced;
  }

  bool get isBalanced {
    final totalPaid = paidBy.fold(0.0, (sum, payer) => sum + payer.amount);
    final totalSplit = splitBetween.fold(0.0, (sum, split) => sum + split.amount);
    return (totalPaid - totalSplit).abs() < 0.01;
  }

  double get totalPaidAmount => paidBy.fold(0.0, (sum, payer) => sum + payer.amount);
  double get totalSplitAmount => splitBetween.fold(0.0, (sum, split) => sum + split.amount);
}

class ExpenseViewModel extends StateNotifier<ExpenseState> {
  final String? expenseId;

  ExpenseViewModel(this.expenseId) : super(ExpenseState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    state = state.copyWith(loading: true);
    
    try {
      // Load group members (mock data)
      await _loadGroupMembers();
      
      if (expenseId != null) {
        // Load existing expense for editing
        await _loadExpense(expenseId!);
        state = state.copyWith(isEditing: true);
      } else {
        // Initialize for new expense
        _initializeNewExpense();
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> _loadGroupMembers() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    final members = [
      GroupMember(
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
        color: Colors.blue,
        isCurrentUser: true,
      ),
      GroupMember(
        id: '2',
        name: 'Jane Smith',
        email: 'jane@example.com',
        color: Colors.green,
      ),
      GroupMember(
        id: '3',
        name: 'Mike Johnson',
        email: 'mike@example.com',
        color: Colors.orange,
      ),
      GroupMember(
        id: '4',
        name: 'Sarah Wilson',
        email: 'sarah@example.com',
        color: Colors.purple,
      ),
    ];
    
    state = state.copyWith(groupMembers: members);
  }

  Future<void> _loadExpense(String id) async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Mock expense data
    final expense = Expense(
      id: id,
      title: 'Dinner at Restaurant',
      description: 'Italian cuisine at downtown restaurant',
      amount: 2500.0,
      paidBy: [
        ExpensePayer(userId: '1', userName: 'John Doe', amount: 2500.0),
      ],
      splitBetween: [
        ExpenseSplit(userId: '1', userName: 'John Doe', amount: 625.0),
        ExpenseSplit(userId: '2', userName: 'Jane Smith', amount: 625.0),
        ExpenseSplit(userId: '3', userName: 'Mike Johnson', amount: 625.0),
        ExpenseSplit(userId: '4', userName: 'Sarah Wilson', amount: 625.0),
      ],
      splitType: SplitType.equally,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      category: 'Food',
      groupId: 'group1',
      createdByUserId: '1',
    );
    
    state = state.copyWith(
      expense: expense,
      title: expense.title,
      description: expense.description,
      amount: expense.amount,
      category: expense.category,
      paidBy: expense.paidBy,
      splitBetween: expense.splitBetween,
      splitType: expense.splitType,
    );
  }

  void _initializeNewExpense() {
    // Set default values for new expense
    final currentUser = state.groupMembers.firstWhere(
      (member) => member.isCurrentUser,
      orElse: () => state.groupMembers.first,
    );
    
    state = state.copyWith(
      paidBy: [ExpensePayer(userId: currentUser.id, userName: currentUser.name, amount: 0.0)],
      splitBetween: state.groupMembers
          .map((member) => ExpenseSplit(userId: member.id, userName: member.name, amount: 0.0))
          .toList(),
    );
  }

  void updateTitle(String title) {
    state = state.copyWith(title: title);
  }

  void updateDescription(String description) {
    state = state.copyWith(description: description);
  }

  void updateAmount(double amount) {
    state = state.copyWith(amount: amount);
    _recalculateSplits();
  }

  void updateCategory(String category) {
    state = state.copyWith(category: category);
  }

  void updateSplitType(SplitType splitType) {
    state = state.copyWith(splitType: splitType);
    _recalculateSplits();
  }

  void updatePaidBy(List<ExpensePayer> paidBy) {
    state = state.copyWith(paidBy: paidBy);
  }

  void updateSplitBetween(List<ExpenseSplit> splitBetween) {
    state = state.copyWith(splitBetween: splitBetween);
  }

  void _recalculateSplits() {
    if (state.amount <= 0 || state.splitBetween.isEmpty) return;

    List<ExpenseSplit> updatedSplits = [];
    
    switch (state.splitType) {
      case SplitType.equally:
        final equalAmount = state.amount / state.splitBetween.length;
        updatedSplits = state.splitBetween
            .map((split) => split.copyWith(amount: equalAmount))
            .toList();
        break;
        
      case SplitType.unequally:
        // Keep current amounts for unequal split
        updatedSplits = List.from(state.splitBetween);
        break;
        
      case SplitType.percentage:
        // Calculate amounts based on percentages
        updatedSplits = state.splitBetween
            .map((split) => split.copyWith(
                amount: state.amount * (split.percentage / 100)))
            .toList();
        break;
    }
    
    state = state.copyWith(splitBetween: updatedSplits);
  }

  void toggleMemberInSplit(GroupMember member) {
    final currentSplits = List<ExpenseSplit>.from(state.splitBetween);
    final existingIndex = currentSplits.indexWhere((split) => split.userId == member.id);
    
    if (existingIndex >= 0) {
      // Remove member from split
      currentSplits.removeAt(existingIndex);
    } else {
      // Add member to split
      currentSplits.add(ExpenseSplit(
        userId: member.id,
        userName: member.name,
        amount: 0.0,
      ));
    }
    
    state = state.copyWith(splitBetween: currentSplits);
    _recalculateSplits();
  }

  void toggleMemberInPaidBy(GroupMember member) {
    final currentPayers = List<ExpensePayer>.from(state.paidBy);
    final existingIndex = currentPayers.indexWhere((payer) => payer.userId == member.id);
    
    if (existingIndex >= 0) {
      // Remove member from payers
      currentPayers.removeAt(existingIndex);
    } else {
      // Add member to payers
      currentPayers.add(ExpensePayer(
        userId: member.id,
        userName: member.name,
        amount: 0.0,
      ));
    }
    
    state = state.copyWith(paidBy: currentPayers);
  }

  void updatePayerAmount(String userId, double amount) {
    final updatedPayers = state.paidBy
        .map((payer) => payer.userId == userId 
            ? payer.copyWith(amount: amount)
            : payer)
        .toList();
    
    state = state.copyWith(paidBy: updatedPayers);
  }

  void updateSplitAmount(String userId, double amount) {
    final updatedSplits = state.splitBetween
        .map((split) => split.userId == userId 
            ? split.copyWith(amount: amount)
            : split)
        .toList();
    
    state = state.copyWith(splitBetween: updatedSplits);
  }

  void updateSplitPercentage(String userId, double percentage) {
    final updatedSplits = state.splitBetween
        .map((split) => split.userId == userId 
            ? split.copyWith(percentage: percentage)
            : split)
        .toList();
    
    state = state.copyWith(splitBetween: updatedSplits);
    _recalculateSplits();
  }

  Future<bool> saveExpense() async {
    if (!state.isValid) {
      state = state.copyWith(error: 'Please fill all required fields and ensure amounts are balanced');
      return false;
    }

    state = state.copyWith(saving: true, error: null);
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      final now = DateTime.now();
      final expense = Expense(
        id: state.expense?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: state.title,
        description: state.description,
        amount: state.amount,
        paidBy: state.paidBy,
        splitBetween: state.splitBetween,
        splitType: state.splitType,
        createdAt: state.expense?.createdAt ?? now,
        updatedAt: now,
        category: state.category,
        groupId: 'group1', // This should come from context
        createdByUserId: '1', // This should come from current user
      );
      
      state = state.copyWith(expense: expense);
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    } finally {
      state = state.copyWith(saving: false);
    }
  }

  Future<bool> deleteExpense() async {
    if (state.expense == null) return false;
    
    state = state.copyWith(saving: true, error: null);
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    } finally {
      state = state.copyWith(saving: false);
    }
  }
}