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

  GroupExpensesViewModel(this.groupId) : super(GroupExpensesState());

  Future<void> loadExpenses() async {
    state = state.copyWith(loading: true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data - replace with actual API call
      final expenses = [
        Expense(
          id: '1',
          title: 'Dinner at Restaurant',
          description: 'Italian cuisine at downtown restaurant',
          amount: 2500.0,
          paidBy: 'John Doe',
          splitBetween: ['John Doe', 'Jane Smith', 'Mike Johnson', 'Sarah Wilson'],
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          category: 'Food',
        ),
        Expense(
          id: '2',
          title: 'Uber Ride',
          description: 'Ride to the airport',
          amount: 450.0,
          paidBy: 'Jane Smith',
          splitBetween: ['John Doe', 'Jane Smith'],
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          category: 'Transport',
        ),
        Expense(
          id: '3',
          title: 'Hotel Booking',
          description: '2 nights at Grand Hotel',
          amount: 8000.0,
          paidBy: 'Mike Johnson',
          splitBetween: ['John Doe', 'Jane Smith', 'Mike Johnson', 'Sarah Wilson'],
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          category: 'Accommodation',
        ),
        Expense(
          id: '4',
          title: 'Groceries',
          description: 'Weekly grocery shopping',
          amount: 1200.0,
          paidBy: 'Sarah Wilson',
          splitBetween: ['John Doe', 'Jane Smith', 'Mike Johnson', 'Sarah Wilson'],
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
          category: 'Food',
        ),
      ];

      final totalExpenses = expenses.fold(0.0, (sum, expense) => sum + expense.amount);
      final yourShare = totalExpenses / 4; // Assuming 4 members
      final youPaid = expenses
          .where((expense) => expense.paidBy == 'John Doe')
          .fold(0.0, (sum, expense) => sum + expense.amount);

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
      filtered = filtered
          .where((expense) =>
              expense.paidBy == state.selectedMember ||
              expense.splitBetween.contains(state.selectedMember))
          .toList();
    }

    if (state.dateRange != null) {
      filtered = filtered
          .where((expense) =>
              expense.createdAt.isAfter(state.dateRange!.start) &&
              expense.createdAt.isBefore(state.dateRange!.end))
          .toList();
    }

    state = state.copyWith(filteredExpenses: filtered);
  }
}
