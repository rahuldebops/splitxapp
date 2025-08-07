// view/screens/expense/expense_detail_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:splitxapp/models/expense.dart';
import 'package:splitxapp/models/group_member.dart';
import 'package:splitxapp/utils/colors.dart';
import 'package:splitxapp/view/screens/expense/expense_view.dart';
import 'package:splitxapp/view/widgets/member_avatar.dart';

class ExpenseDetailView extends ConsumerStatefulWidget {
  final String expenseId;
  final String groupId;

  const ExpenseDetailView({
    super.key,
    required this.expenseId,
    required this.groupId,
  });

  @override
  ConsumerState<ExpenseDetailView> createState() => _ExpenseDetailViewState();
}

class _ExpenseDetailViewState extends ConsumerState<ExpenseDetailView> {
  late Expense expense;
  late List<GroupMember> groupMembers;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadExpenseDetails();
  }

  Future<void> _loadExpenseDetails() async {
    setState(() => loading = true);
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Mock data - replace with actual API call
      expense = Expense(
        id: widget.expenseId,
        title: 'Dinner at Restaurant',
        description: 'Italian cuisine at downtown restaurant with amazing pasta and wine',
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
        groupId: widget.groupId,
        createdByUserId: '1',
      );
      
      groupMembers = [
        GroupMember(
          id: '1',
          name: 'John Doe4',
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
    } catch (e) {
      // Handle error
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Expense Details'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Expense Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _navigateToEdit(context),
            icon: const Icon(Icons.edit),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'duplicate':
                  _duplicateExpense();
                  break;
                case 'delete':
                  _showDeleteConfirmation();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'duplicate',
                child: Row(
                  children: [
                    Icon(Icons.copy, size: 18),
                    SizedBox(width: 8),
                    Text('Duplicate'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            _buildHeaderCard(),
            const SizedBox(height: 24),
            
            // Paid By Section
            _buildPaidBySection(),
            const SizedBox(height: 24),
            
            // Split Details Section
            _buildSplitDetailsSection(),
            const SizedBox(height: 24),
            
            // Balance Summary
            _buildBalanceSummary(),
            const SizedBox(height: 24),
            
            // Additional Info
            _buildAdditionalInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_getCategoryColor(), _getCategoryColor().withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _getCategoryColor().withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getCategoryIcon(),
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  expense.category,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            expense.title,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            expense.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '₹${expense.amount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Total Amount',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaidBySection() {
    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: kGrey.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Paid By',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '₹${expense.totalPaidAmount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...expense.paidBy.map((payer) {
              final member = groupMembers.firstWhere((m) => m.id == payer.userId);
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    MemberAvatar(member: member, size: 40),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            payer.userName,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            member.email,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: kGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '₹${payer.amount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: member.color,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSplitDetailsSection() {
    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: kGrey.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Split Details',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
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
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...expense.splitBetween.map((split) {
              final member = groupMembers.firstWhere((m) => m.id == split.userId);
              final percentage = expense.amount > 0 ? (split.amount / expense.amount) * 100 : 0.0;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    MemberAvatar(member: member, size: 40),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            split.userName,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${percentage.toStringAsFixed(1)}% of total',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: kGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '₹${split.amount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: member.color,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceSummary() {
    final isBalanced = expense.isBalanced;
    final difference = expense.totalPaidAmount - expense.totalSplitAmount;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isBalanced 
            ? Colors.green.withOpacity(0.1)
            : Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isBalanced ? Colors.green : Colors.orange,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                isBalanced ? Icons.check_circle : Icons.info,
                color: isBalanced ? Colors.green : Colors.orange,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  isBalanced ? 'Expense is balanced' : 'Expense has imbalance',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isBalanced ? Colors.green : Colors.orange,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Paid',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: kGrey,
                      ),
                    ),
                    Text(
                      '₹${expense.totalPaidAmount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Split',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: kGrey,
                      ),
                    ),
                    Text(
                      '₹${expense.totalSplitAmount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Difference',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: kGrey,
                      ),
                    ),
                    Text(
                      '₹${difference.abs().toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isBalanced ? Colors.green : Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfo() {
    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: kGrey.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Additional Information',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Created', _formatDateTime(expense.createdAt)),
            const SizedBox(height: 8),
            _buildInfoRow('Last Updated', _formatDateTime(expense.updatedAt)),
            const SizedBox(height: 8),
            _buildInfoRow('Created By', 
              groupMembers.firstWhere((m) => m.id == expense.createdByUserId).name),
            const SizedBox(height: 8),
            _buildInfoRow('Expense ID', expense.id),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: kGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
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
        return 'EQUALLY';
      case SplitType.unequally:
        return 'UNEQUALLY';
      case SplitType.percentage:
        return 'BY PERCENTAGE';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 7) {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }

  void _navigateToEdit(BuildContext context) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ExpenseView(
          expenseId: expense.id,
          groupId: widget.groupId,
        ),
      ),
    );

    if (result == true) {
      // Refresh the expense details
      _loadExpenseDetails();
    }
  }

  void _duplicateExpense() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ExpenseView(
          groupId: widget.groupId,
        ),
      ),
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Expense duplicated. You can now modify the details.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showDeleteConfirmation() {
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
            onPressed: () async {
              Navigator.of(context).pop();
              
              // Show loading
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
              
              // Simulate delete operation
              await Future.delayed(const Duration(seconds: 1));
              
              if (mounted) {
                Navigator.of(context).pop(); // Close loading dialog
                Navigator.of(context).pop(true); // Return to previous screen
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Expense deleted successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}