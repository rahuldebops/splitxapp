// view/screens/group/group_expenses_view_model.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitxapp/data/expense/expense_repo.dart';
import 'package:splitxapp/domain/provider/repository_provider.dart';
import 'package:splitxapp/models/api_query.dart';
import 'package:splitxapp/models/expense.dart';
import 'package:splitxapp/utils/extensions.dart';

final groupExpensesViewModelProvider = StateNotifierProvider.family<
    GroupExpensesViewModel, GroupExpensesState, String>((ref, groupId) {
  final repo = ref.watch(expenseRepoProvider);
  return GroupExpensesViewModel(groupId, repo);
});

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
  final ExpenseRepo _expenseRepo;
  int _currentPage = 1;
  final int _pageSize = 10;
  bool _hasMore = true;
  bool _isFetchingMore = false;

  GroupExpensesViewModel(this.groupId, this._expenseRepo)
      : super(GroupExpensesState());

  Future<void> loadExpenses({bool isRefresh = false}) async {
    if (_isFetchingMore) return;
    if (isRefresh) {
      _currentPage = 1;
      _hasMore = true;
      state = state.copyWith(expenses: [], filteredExpenses: []);
    }

    if (!_hasMore) return;
    _isFetchingMore = true;
    
    // Show loading indicator only on the first page load
    if (_currentPage == 1) {
      state = state.copyWith(loading: true);
    }

    final query = ApiQuery(page: _currentPage, pageSize: _pageSize);
    final result = await _expenseRepo.getExpensesByGroup(groupId, query);

    result.handle(
      onRight: (response) {
        final apiExpenses = response.result.data;
        // Map the simple API response to the detailed Expense model used by the UI
        final newExpenses = apiExpenses.map((datum) {
          return Expense(
            id: datum.id,
            title: datum.description, // Use description for title
            description: datum.description,
            amount: datum.amount,
            createdAt: DateTime.parse(datum.createdAt),
            updatedAt: DateTime.parse(datum.createdAt),
            groupId: datum.groupId,
            category: 'Other', // API doesn't provide category
            // Placeholders for data not provided by this list API
            paidBy: [ExpensePayer(userId: '1', userName: 'API User', amount: datum.amount)],
            splitBetween: [ExpenseSplit(userId: '1', userName: 'API User', amount: datum.amount)],
            splitType: SplitType.equally,
            createdByUserId: '1',
          );
        }).toList();

        if (newExpenses.length < _pageSize) {
          _hasMore = false;
        }

        final allExpenses = isRefresh ? newExpenses : [...state.expenses, ...newExpenses];
        _currentPage++;

        state = state.copyWith(loading: false, expenses: allExpenses);
        _recalculateSummariesAndApplyFilters();
      },
      onLeft: (failure) {
        state = state.copyWith(loading: false);
      },
    );
    _isFetchingMore = false;
  }
  
  void _recalculateSummariesAndApplyFilters() {
    final totalExpenses = state.expenses.fold(0.0, (sum, expense) => sum + expense.amount);
    
    // NOTE: The list API does not provide user-specific details for "Your Share" or "You Paid".
    // Setting them to 0. A different API would be needed for accurate calculations.
    state = state.copyWith(
      totalExpenses: totalExpenses,
      yourShare: 0.0,
      youPaid: 0.0,
    );
    _applyFilters();
  }

  Future<void> refreshExpenses() async {
    await loadExpenses(isRefresh: true);
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
    );
    _applyFilters();
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
        final isPayer =
            expense.paidBy.any((payer) => payer.userName == state.selectedMember);
        final isInSplit = expense.splitBetween
            .any((split) => split.userName == state.selectedMember);
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
}
