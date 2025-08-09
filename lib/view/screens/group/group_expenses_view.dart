// view/screens/group/group_expenses_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitxapp/models/expense.dart'; // Import the full Expense model
import 'package:splitxapp/view/screens/group/group_expenses_view_model.dart';
import 'package:splitxapp/view/widgets/expense_card.dart';
import 'package:splitxapp/view/widgets/expense_filter_widget.dart';
import 'package:splitxapp/utils/colors.dart';

class GroupExpensesView extends ConsumerStatefulWidget {
  final String groupId;
  const GroupExpensesView({super.key, required this.groupId});

  @override
  ConsumerState<GroupExpensesView> createState() => _GroupExpensesViewState();
}

class _GroupExpensesViewState extends ConsumerState<GroupExpensesView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(groupExpensesViewModelProvider(widget.groupId).notifier)
          .loadExpenses();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Load more when user is near the end of the list
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref
          .read(groupExpensesViewModelProvider(widget.groupId).notifier)
          .loadExpenses();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(groupExpensesViewModelProvider(widget.groupId));
    return RefreshIndicator(
      onRefresh: () => ref
          .read(groupExpensesViewModelProvider(widget.groupId).notifier)
          .refreshExpenses(),
      child: CustomScrollView(
        controller: _scrollController, // Attach the scroll controller
        slivers: [
          // FilterSection
          SliverToBoxAdapter(
            child: ExpenseFilterWidget(
              selectedCategory: viewModel.selectedCategory,
              selectedMember: viewModel.selectedMember,
              dateRange: viewModel.dateRange,
              onCategoryChanged: (category) => ref
                  .read(groupExpensesViewModelProvider(widget.groupId).notifier)
                  .filterByCategory(category),
              onMemberChanged: (member) => ref
                  .read(groupExpensesViewModelProvider(widget.groupId).notifier)
                  .filterByMember(member),
              onDateRangeChanged: (range) => ref
                  .read(groupExpensesViewModelProvider(widget.groupId).notifier)
                  .filterByDateRange(range),
              onClearFilters: () => ref
                  .read(groupExpensesViewModelProvider(widget.groupId).notifier)
                  .clearFilters(),
            ),
          ),
          // SummaryCard
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kPrimaryColor, kPrimaryColor.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: kPrimaryColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Group Expenses',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white.withOpacity(0.9))),
                  const SizedBox(height: 8),
                  Text('₹${viewModel.totalExpenses.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Your Share',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Colors.white.withOpacity(0.8))),
                            Text('₹${viewModel.yourShare.toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('You Paid',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Colors.white.withOpacity(0.8))),
                            Text('₹${viewModel.youPaid.toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // ExpensesList
          if (viewModel.loading && viewModel.filteredExpenses.isEmpty)
            const SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          else if (viewModel.filteredExpenses.isEmpty)
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kGrey.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.receipt_long_outlined,
                        size: 48, color: kGrey.withOpacity(0.5)),
                    const SizedBox(height: 16),
                    Text('No Expenses Found',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text(
                        viewModel.hasActiveFilters
                            ? 'Try adjusting your filters to see more expenses'
                            : 'Start adding expenses to track group spending',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: kGrey)),
                  ],
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final expense = viewModel.filteredExpenses[index];
                  return ExpenseCard(
                    expense: expense,
                    onTap: () => _showExpenseDetails(context, expense),
                  );
                },
                childCount: viewModel.filteredExpenses.length,
              ),
            ),
          
          // Pagination loading indicator
          SliverToBoxAdapter(
            child: viewModel.loading && viewModel.filteredExpenses.isNotEmpty
                ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox.shrink(),
          ),

          // Bottom padding
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  void _showExpenseDetails(BuildContext context, Expense expense) {
    // Your existing bottom sheet implementation
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text('Expense Details',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Expanded(
              child: Center(
                child: Text('Expense details will be implemented here'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
