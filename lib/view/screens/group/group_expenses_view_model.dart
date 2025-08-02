// view/screens/group/group_expenses_view_model.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitxapp/models/expense.dart';

final groupExpensesViewModelProvider = StateNotifierProvider.family<
    GroupExpensesViewModel, GroupExpensesState, String>(
  (ref, groupId) => GroupExpensesViewModel(groupId),
);

class GroupExpensesState {
  final List<Expense> expenses;
  final List<Expense> filteredExpenses;
  final bool loading;
  final String? selectedCategory;
  final String? selectedMember;
  final DateTimeRange? dateRange;
  final double totalExpenses;
  final double yourShare;
  final double youPaid;

  GroupExpensesState({
    this.expenses = const [],
    this.filteredExpenses = const [],
    this.loading = false,
    this.selectedCategory,
    this.selectedMember,
    this.dateRange,
    this.totalExpenses = 0.0,
    this.yourShare = 0.0,
    this.youPaid = 0.0,
  });

  bool get hasActiveFilters =>
      selectedCategory != null || selectedMember != null || dateRange != null;

  GroupExpensesState copyWith({
    List<Expense>? expenses,
    List<Expense>? filteredExpenses,
    bool? loading,
    String? selectedCategory,
    String? selectedMember,
    DateTimeRange? dateRange,
    double? totalExpenses,
    double? yourShare,
    double? youPaid,
  }) {
    return GroupExpensesState(
      expenses: expenses ?? this.expenses,
      filteredExpenses: filteredExpenses ?? this.filteredExpenses,
      loading: loading ?? this.loading,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedMember: selectedMember ?? this.selectedMember,
      dateRange: dateRange ?? this.dateRange,
      totalExpenses: totalExpenses ?? this.totalExpenses,
      yourShare: yourShare ?? this.yourShare,
      youPaid: youPaid ?? this.youPaid,
    );
  }
}

class GroupExpensesViewModel extends StateNotifier<GroupExpensesState> {
  final String groupId;

  GroupExpensesViewModel(this.groupId) : super(GroupExpensesState()) {
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    state = state.copyWith(loading: true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data using the new enhanced Expense model
      final expenses = [
        Expense(
          id: '1',
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
          groupId: groupId,
          createdByUserId: '1',
        ),
        Expense(
          id: '2',
          title: 'Uber Ride',
          description: 'Ride to the airport',
          amount: 450.0,
          paidBy: [
            ExpensePayer(userId: '2', userName: 'Jane Smith', amount: 450.0),
          ],
          splitBetween: [
            ExpenseSplit(userId: '1', userName: 'John Doe', amount: 225.0),
            ExpenseSplit(userId: '2', userName: 'Jane Smith', amount: 225.0),
          ],
          splitType: SplitType.equally,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          updatedAt: DateTime.now().subtract(const Duration(days: 1)),
          category: 'Transport',
          groupId: groupId,
          createdByUserId: '2',
        ),
        Expense(
          id: '3',
          title: 'Hotel Booking',
          description: '2 nights at Grand Hotel',
          amount: 8000.0,
          paidBy: [
            ExpensePayer(userId: '3', userName: 'Mike Johnson', amount: 8000.0),
          ],
          splitBetween: [
            ExpenseSplit(userId: '1', userName: 'John Doe', amount: 2000.0),
            ExpenseSplit(userId: '2', userName: 'Jane Smith', amount: 2000.0),
            ExpenseSplit(userId: '3', userName: 'Mike Johnson', amount: 2000.0),
            ExpenseSplit(userId: '4', userName: 'Sarah Wilson', amount: 2000.0),
          ],
          splitType: SplitType.equally,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          updatedAt: DateTime.now().subtract(const Duration(days: 2)),
          category: 'Accommodation',
          groupId: groupId,
          createdByUserId: '3',
        ),
        Expense(
          id: '4',
          title: 'Groceries',
          description: 'Weekly grocery shopping',
          amount: 1200.0,
          paidBy: [
            ExpensePayer(userId: '4', userName: 'Sarah Wilson', amount: 1200.0),
          ],
          splitBetween: [
            ExpenseSplit(userId: '1', userName: 'John Doe', amount: 300.0),
            ExpenseSplit(userId: '2', userName: 'Jane Smith', amount: 300.0),
            ExpenseSplit(userId: '3', userName: 'Mike Johnson', amount: 300.0),
            ExpenseSplit(userId: '4', userName: 'Sarah Wilson', amount: 300.0),
          ],
          splitType: SplitType.equally,
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
          updatedAt: DateTime.now().subtract(const Duration(days: 3)),
          category: 'Food',
          groupId: groupId,
          createdByUserId: '4',
        ),
        Expense(
          id: '5',
          title: 'Concert Tickets',
          description: 'Music concert downtown',
          amount: 3200.0,
          paidBy: [
            ExpensePayer(userId: '1', userName: 'John Doe', amount: 1600.0),
            ExpensePayer(userId: '2', userName: 'Jane Smith', amount: 1600.0),
          ],
          splitBetween: [
            ExpenseSplit(userId: '1', userName: 'John Doe', amount: 1000.0),
            ExpenseSplit(userId: '2', userName: 'Jane Smith', amount: 800.0),
            ExpenseSplit(userId: '3', userName: 'Mike Johnson', amount: 700.0),
            ExpenseSplit(userId: '4', userName: 'Sarah Wilson', amount: 700.0),
          ],
          splitType: SplitType.unequally,
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
          updatedAt: DateTime.now().subtract(const Duration(days: 5)),
          category: 'Entertainment',
          groupId: groupId,
          createdByUserId: '1',
        ),
        Expense(
          id: '6',
          title: 'Shared Utilities',
          description: 'Electricity and water bill',
          amount: 2400.0,
          paidBy: [
            ExpensePayer(userId: '3', userName: 'Mike Johnson', amount: 2400.0),
          ],
          splitBetween: [
            ExpenseSplit(userId: '1', userName: 'John Doe', amount: 720.0, percentage: 30.0),
            ExpenseSplit(userId: '2', userName: 'Jane Smith', amount: 720.0, percentage: 30.0),
            ExpenseSplit(userId: '3', userName: 'Mike Johnson', amount: 480.0, percentage: 20.0),
            ExpenseSplit(userId: '4', userName: 'Sarah Wilson', amount: 480.0, percentage: 20.0),
          ],
          splitType: SplitType.percentage,
          createdAt: DateTime.now().subtract(const Duration(days: 7)),
          updatedAt: DateTime.now().subtract(const Duration(days: 7)),
          category: 'Utilities',
          groupId: groupId,
          createdByUserId: '3',
        ),
      ];

      final totalExpenses = expenses.fold(0.0, (sum, expense) => sum + expense.amount);
      
      // Calculate current user's share (assuming current user ID is '1' - John Doe)
      const currentUserId = '1';
      final yourShare = expenses.fold(0.0, (sum, expense) {
        final userSplit = expense.splitBetween.firstWhere(
          (split) => split.userId == currentUserId,
          orElse: () => ExpenseSplit(userId: currentUserId, userName: 'John Doe', amount: 0.0),
        );
        return sum + userSplit.amount;
      });
      
      final youPaid = expenses.fold(0.0, (sum, expense) {
        final userPayment = expense.paidBy.firstWhere(
          (payer) => payer.userId == currentUserId,
          orElse: () => ExpensePayer(userId: currentUserId, userName: 'John Doe', amount: 0.0),
        );
        return sum + userPayment.amount;
      });

      state = state.copyWith(
        expenses: expenses,
        filteredExpenses: expenses,
        totalExpenses: totalExpenses,
        yourShare: yourShare,
        youPaid: youPaid,
        loading: false,
      );
    } catch (e) {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> refreshExpenses() async {
    await loadExpenses();
  }

  void filterByCategory(String? category) {
    state = state.copyWith(selectedCategory: category);
    _applyFilters();
  }

  void filterByMember(String? member) {
    state = state.copyWith(selectedMember: member);
    _applyFilters();
  }

  void filterByDateRange(DateTimeRange? range) {
    state = state.copyWith(dateRange: range);
    _applyFilters();
  }

  void clearFilters() {
    state = state.copyWith(
      selectedCategory: null,
      selectedMember: null,
      dateRange: null,
      filteredExpenses: state.expenses,
    );
  }

  void _applyFilters() {
    List<Expense> filtered = List.from(state.expenses);

    if (state.selectedCategory != null) {
      filtered = filtered
          .where((expense) => expense.category == state.selectedCategory)
          .toList();
    }

    if (state.selectedMember != null) {
      filtered = filtered.where((expense) {
        // Check if member is in paidBy list
        final isPayer = expense.paidBy.any((payer) => payer.userName == state.selectedMember);
        
        // Check if member is in splitBetween list
        final isInSplit = expense.splitBetween.any((split) => split.userName == state.selectedMember);
        
        return isPayer || isInSplit;
      }).toList();
    }

    if (state.dateRange != null) {
      filtered = filtered
          .where((expense) =>
              expense.createdAt.isAfter(state.dateRange!.start) &&
              expense.createdAt.isBefore(state.dateRange!.end.add(const Duration(days: 1))))
          .toList();
    }

    state = state.copyWith(filteredExpenses: filtered);
  }

  // Helper methods for easier access to expense data
  List<String> get allCategories {
    return state.expenses.map((expense) => expense.category).toSet().toList()..sort();
  }

  List<String> get allMembers {
    final Set<String> members = {};
    
    for (final expense in state.expenses) {
      // Add payers
      for (final payer in expense.paidBy) {
        members.add(payer.userName);
      }
      
      // Add split members
      for (final split in expense.splitBetween) {
        members.add(split.userName);
      }
    }
    
    return members.toList()..sort();
  }

  // Add a new expense to the list
  void addExpense(Expense expense) {
    final updatedExpenses = [expense, ...state.expenses];
    final totalExpenses = updatedExpenses.fold(0.0, (sum, exp) => sum + exp.amount);
    
    // Recalculate user shares
    const currentUserId = '1';
    final yourShare = updatedExpenses.fold(0.0, (sum, exp) {
      final userSplit = exp.splitBetween.firstWhere(
        (split) => split.userId == currentUserId,
        orElse: () => ExpenseSplit(userId: currentUserId, userName: 'John Doe', amount: 0.0),
      );
      return sum + userSplit.amount;
    });
    
    final youPaid = updatedExpenses.fold(0.0, (sum, exp) {
      final userPayment = exp.paidBy.firstWhere(
        (payer) => payer.userId == currentUserId,
        orElse: () => ExpensePayer(userId: currentUserId, userName: 'John Doe', amount: 0.0),
      );
      return sum + userPayment.amount;
    });

    state = state.copyWith(
      expenses: updatedExpenses,
      filteredExpenses: updatedExpenses,
      totalExpenses: totalExpenses,
      yourShare: yourShare,
      youPaid: youPaid,
    );
    
    // Reapply filters if any are active
    if (state.hasActiveFilters) {
      _applyFilters();
    }
  }

  // Update an existing expense
  void updateExpense(Expense updatedExpense) {
    final updatedExpenses = state.expenses
        .map((expense) => expense.id == updatedExpense.id ? updatedExpense : expense)
        .toList();
    
    final totalExpenses = updatedExpenses.fold(0.0, (sum, exp) => sum + exp.amount);
    
    // Recalculate user shares
    const currentUserId = '1';
    final yourShare = updatedExpenses.fold(0.0, (sum, exp) {
      final userSplit = exp.splitBetween.firstWhere(
        (split) => split.userId == currentUserId,
        orElse: () => ExpenseSplit(userId: currentUserId, userName: 'John Doe', amount: 0.0),
      );
      return sum + userSplit.amount;
    });
    
    final youPaid = updatedExpenses.fold(0.0, (sum, exp) {
      final userPayment = exp.paidBy.firstWhere(
        (payer) => payer.userId == currentUserId,
        orElse: () => ExpensePayer(userId: currentUserId, userName: 'John Doe', amount: 0.0),
      );
      return sum + userPayment.amount;
    });

    state = state.copyWith(
      expenses: updatedExpenses,
      totalExpenses: totalExpenses,
      yourShare: yourShare,
      youPaid: youPaid,
    );
    
    // Reapply filters if any are active
    if (state.hasActiveFilters) {
      _applyFilters();
    } else {
      state = state.copyWith(filteredExpenses: updatedExpenses);
    }
  }

  // Remove an expense
  void removeExpense(String expenseId) {
    final updatedExpenses = state.expenses.where((expense) => expense.id != expenseId).toList();
    final totalExpenses = updatedExpenses.fold(0.0, (sum, exp) => sum + exp.amount);
    
    // Recalculate user shares
    const currentUserId = '1';
    final yourShare = updatedExpenses.fold(0.0, (sum, exp) {
      final userSplit = exp.splitBetween.firstWhere(
        (split) => split.userId == currentUserId,
        orElse: () => ExpenseSplit(userId: currentUserId, userName: 'John Doe', amount: 0.0),
      );
      return sum + userSplit.amount;
    });
    
    final youPaid = updatedExpenses.fold(0.0, (sum, exp) {
      final userPayment = exp.paidBy.firstWhere(
        (payer) => payer.userId == currentUserId,
        orElse: () => ExpensePayer(userId: currentUserId, userName: 'John Doe', amount: 0.0),
      );
      return sum + userPayment.amount;
    });

    state = state.copyWith(
      expenses: updatedExpenses,
      totalExpenses: totalExpenses,
      yourShare: yourShare,
      youPaid: youPaid,
    );
    
    // Reapply filters if any are active
    if (state.hasActiveFilters) {
      _applyFilters();
    } else {
      state = state.copyWith(filteredExpenses: updatedExpenses);
    }
  }
}