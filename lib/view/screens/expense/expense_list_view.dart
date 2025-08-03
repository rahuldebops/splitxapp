// view/screens/expense/expense_list_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:splitxapp/models/expense.dart';
import 'package:splitxapp/utils/colors.dart';
import 'package:splitxapp/view/screens/expense/expense_view.dart';
import 'package:splitxapp/view/widgets/expense_card.dart';

final expenseListProvider = StateNotifierProvider<ExpenseListNotifier, ExpenseListState>(
  (ref) => ExpenseListNotifier(),
);

class ExpenseListState {
  final List<Expense> expenses;
  final bool loading;
  final String? error;

  ExpenseListState({
    this.expenses = const [],
    this.loading = false,
    this.error,
  });

  ExpenseListState copyWith({
    List<Expense>? expenses,
    bool? loading,
    String? error,
  }) {
    return ExpenseListState(
      expenses: expenses ?? this.expenses,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}

class ExpenseListNotifier extends StateNotifier<ExpenseListState> {
  ExpenseListNotifier() : super(ExpenseListState()) {
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    state = state.copyWith(loading: true);
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data
      final expenses = <Expense>[
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
          groupId: 'group1',
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
          groupId: 'group1',
          createdByUserId: '2',
        ),
      ];
      
      state = state.copyWith(expenses: expenses, loading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), loading: false);
    }
  }

  Future<void> refreshExpenses() async {
    await loadExpenses();
  }

  void addExpense(Expense expense) {
    final updatedExpenses = [expense, ...state.expenses];
    state = state.copyWith(expenses: updatedExpenses);
  }

  void updateExpense(Expense expense) {
    final updatedExpenses = state.expenses
        .map((e) => e.id == expense.id ? expense : e)
        .toList();
    state = state.copyWith(expenses: updatedExpenses);
  }

  void removeExpense(String expenseId) {
    final updatedExpenses = state.expenses
        .where((e) => e.id != expenseId)
        .toList();
    state = state.copyWith(expenses: updatedExpenses);
  }
}

class ExpenseListView extends ConsumerStatefulWidget {
  final String groupId;

  const ExpenseListView({
    super.key,
    required this.groupId,
  });

  @override
  ConsumerState<ExpenseListView> createState() => _ExpenseListViewState();
}

class _ExpenseListViewState extends ConsumerState<ExpenseListView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(expenseListProvider);
    final notifier = ref.read(expenseListProvider.notifier);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Expenses',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _navigateToAddExpense(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: notifier.refreshExpenses,
        child: _buildBody(context, state, notifier),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddExpense(context),
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ExpenseListState state, ExpenseListNotifier notifier) {
    if (state.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading expenses',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.error!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: kGrey,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: notifier.refreshExpenses,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.expenses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: kGrey.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No Expenses Yet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start adding expenses to track group spending',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: kGrey,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _navigateToAddExpense(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Expense'),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.expenses.length,
      itemBuilder: (context, index) {
        final expense = state.expenses[index];
        return ExpenseListCard(
          expense: expense,
          onTap: () => _navigateToEditExpense(context, expense.id),
          onDelete: () => _showDeleteConfirmation(context, expense, notifier),
        );
      },
    );
  }

  void _navigateToAddExpense(BuildContext context) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ExpenseView(groupId: widget.groupId),
      ),
    );

    if (result == true) {
      // Refresh the list if an expense was added
      ref.read(expenseListProvider.notifier).refreshExpenses();
    }
  }

  void _navigateToEditExpense(BuildContext context, String expenseId) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ExpenseView(
          expenseId: expenseId,
          groupId: widget.groupId,
        ),
      ),
    );

    if (result == true) {
      // Refresh the list if an expense was updated or deleted
      ref.read(expenseListProvider.notifier).refreshExpenses();
    }
  }

  void _showDeleteConfirmation(BuildContext context, Expense expense, ExpenseListNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Expense'),
        content: Text('Are you sure you want to delete "${expense.title}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              notifier.removeExpense(expense.id);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Expense deleted successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class ExpenseListCard extends StatelessWidget {
  final Expense expense;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ExpenseListCard({
    super.key,
    required this.expense,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kGrey.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _getCategoryColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getCategoryIcon(),
                        color: _getCategoryColor(),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            expense.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            expense.description,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: kGrey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₹${expense.amount.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: _getCategoryColor(),
                          ),
                        ),
                        Text(
                          _getTimeAgo(),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: kGrey.withOpacity(0.7),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        switch (value) {
                          case 'edit':
                            onTap();
                            break;
                          case 'delete':
                            onDelete();
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, size: 18),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 18, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Delete', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'Paid by: ',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: kGrey,
                      ),
                    ),
                    Text(
                      expense.payerNames.join(', '),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${expense.splitBetween.length} people',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: kGrey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getSplitTypeColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _getSplitTypeLabel(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getSplitTypeColor(),
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (!expense.isBalanced)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Unbalanced',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon() {
    switch (expense.category.toLowerCase()) {
      case 'food':
        return Icons.restaurant;
      case 'transport':
        return Icons.directions_car;
      case 'accommodation':
        return Icons.hotel;
      case 'entertainment':
        return Icons.movie;
      case 'shopping':
        return Icons.shopping_bag;
      case 'utilities':
        return Icons.electrical_services;
      case 'healthcare':
        return Icons.medical_services;
      default:
        return Icons.receipt_long;
    }
  }

  Color _getCategoryColor() {
    switch (expense.category.toLowerCase()) {
      case 'food':
        return Colors.orange;
      case 'transport':
        return Colors.blue;
      case 'accommodation':
        return Colors.purple;
      case 'entertainment':
        return Colors.pink;
      case 'shopping':
        return Colors.green;
      case 'utilities':
        return Colors.indigo;
      case 'healthcare':
        return Colors.red;
      default:
        return kPrimaryColor;
    }
  }

  Color _getSplitTypeColor() {
    switch (expense.splitType) {
      case SplitType.equally:
        return Colors.green;
      case SplitType.unequally:
        return Colors.orange;
      case SplitType.percentage:
        return Colors.blue;
    }
  }

  String _getSplitTypeLabel() {
    switch (expense.splitType) {
      case SplitType.equally:
        return 'EQUAL';
      case SplitType.unequally:
        return 'UNEQUAL';
      case SplitType.percentage:
        return 'PERCENTAGE';
    }
  }

  String _getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(expense.createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}