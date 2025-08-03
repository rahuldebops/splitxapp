// view/screens/expense/expense_view.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:splitxapp/models/expense.dart';
import 'package:splitxapp/models/group_member.dart';
import 'package:splitxapp/utils/colors.dart';
import 'package:splitxapp/view/screens/expense/expense_view_model.dart';
import 'package:splitxapp/view/widgets/member_avatar.dart';

class ExpenseView extends ConsumerStatefulWidget {
  final String? expenseId;
  final String groupId;

  const ExpenseView({
    super.key,
    this.expenseId,
    required this.groupId,
  });

  @override
  ConsumerState<ExpenseView> createState() => _ExpenseViewState();
}

class _ExpenseViewState extends ConsumerState<ExpenseView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  final List<String> categories = [
    'Food',
    'Transport',
    'Accommodation',
    'Entertainment',
    'Shopping',
    'Utilities',
    'Healthcare',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = ref.read(expenseViewModelProvider(widget.expenseId));
      _titleController.text = viewModel.title;
      _descriptionController.text = viewModel.description;
      _amountController.text = viewModel.amount > 0 ? viewModel.amount.toString() : '';
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(expenseViewModelProvider(widget.expenseId));
    final viewModel = ref.read(expenseViewModelProvider(widget.expenseId).notifier);

    if (state.loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.expenseId != null ? 'Edit Expense' : 'Add Expense'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          state.isEditing ? 'Edit Expense' : 'Add Expense',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          if (state.isEditing)
            IconButton(
              onPressed: () => _showDeleteConfirmation(context, viewModel),
              icon: const Icon(Icons.delete_outline, color: Colors.red),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Basic Information
                    _buildBasicInfoSection(context, state, viewModel),
                    const SizedBox(height: 32),
                    
                    // Paid By Section
                    _buildPaidBySection(context, state, viewModel),
                    const SizedBox(height: 32),
                    
                    // Split Between Section
                    _buildSplitBetweenSection(context, state, viewModel),
                    const SizedBox(height: 32),
                    
                    // Balance Summary
                    _buildBalanceSummary(context, state),
                    const SizedBox(height: 100), // Space for floating button
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: state.saving ? null : () => _saveExpense(context, viewModel),
        backgroundColor: state.isValid ? kPrimaryColor : kGrey,
        icon: state.saving 
            ? const SizedBox(
                width: 20, 
                height: 20, 
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Icon(Icons.save, color: Colors.white),
        label: Text(
          state.saving ? 'Saving...' : 'Save Expense',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection(BuildContext context, ExpenseState state, ExpenseViewModel viewModel) {
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
              'Expense Details',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            // Title Field
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter expense title',
                prefixIcon: Icon(Icons.title),
              ),
              onChanged: viewModel.updateTitle,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Description Field
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter expense description',
                prefixIcon: Icon(Icons.description),
              ),
              onChanged: viewModel.updateDescription,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Amount Field
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                hintText: '0.00',
                prefixIcon: Icon(Icons.currency_rupee),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              onChanged: (value) {
                final amount = double.tryParse(value) ?? 0.0;
                viewModel.updateAmount(amount);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                final amount = double.tryParse(value);
                if (amount == null || amount <= 0) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Category Dropdown
            DropdownButtonFormField<String>(
              value: state.category,
              decoration: const InputDecoration(
                labelText: 'Category',
                prefixIcon: Icon(Icons.category),
              ),
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  viewModel.updateCategory(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaidBySection(BuildContext context, ExpenseState state, ExpenseViewModel viewModel) {
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
                  '₹${state.totalPaidAmount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Member Selection for Paid By
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: state.groupMembers.map((member) {
                final isPayer = state.paidBy.any((payer) => payer.userId == member.id);
                return FilterChip(
                  avatar: MemberAvatar(member: member, size: 24),
                  label: Text(member.name),
                  selected: isPayer,
                  onSelected: (selected) {
                    viewModel.toggleMemberInPaidBy(member);
                  },
                  selectedColor: member.color.withOpacity(0.2),
                  checkmarkColor: member.color,
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            
            // Amount Input for Each Payer
            ...state.paidBy.map((payer) {
              final member = state.groupMembers.firstWhere((m) => m.id == payer.userId);
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    MemberAvatar(member: member, size: 32),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        payer.userName,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: TextFormField(
                        initialValue: payer.amount > 0 ? payer.amount.toString() : '',
                        decoration: const InputDecoration(
                          hintText: '0.00',
                          prefixText: '₹',
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                        ],
                        onChanged: (value) {
                          final amount = double.tryParse(value) ?? 0.0;
                          viewModel.updatePayerAmount(payer.userId, amount);
                        },
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

  Widget _buildSplitBetweenSection(BuildContext context, ExpenseState state, ExpenseViewModel viewModel) {
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
                  'Split Between',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '₹${state.totalSplitAmount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Split Type Selection
            Row(
              children: [
                Text(
                  'Split Type:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButton<SplitType>(
                    value: state.splitType,
                    isExpanded: true,
                    underline: Container(),
                    items: SplitType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(_getSplitTypeLabel(type)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        viewModel.updateSplitType(value);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Member Selection for Split
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: state.groupMembers.map((member) {
                final isInSplit = state.splitBetween.any((split) => split.userId == member.id);
                return FilterChip(
                  avatar: MemberAvatar(member: member, size: 24),
                  label: Text(member.name),
                  selected: isInSplit,
                  onSelected: (selected) {
                    viewModel.toggleMemberInSplit(member);
                  },
                  selectedColor: member.color.withOpacity(0.2),
                  checkmarkColor: member.color,
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            
            // Split Amount/Percentage Input
            ...state.splitBetween.map((split) {
              final member = state.groupMembers.firstWhere((m) => m.id == split.userId);
              return _buildSplitInput(context, state, viewModel, split, member);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSplitInput(BuildContext context, ExpenseState state, ExpenseViewModel viewModel, ExpenseSplit split, GroupMember member) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          MemberAvatar(member: member, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              split.userName,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (state.splitType == SplitType.percentage) ...[
            SizedBox(
              width: 100,
              child: TextFormField(
                initialValue: split.percentage > 0 ? split.percentage.toString() : '',
                decoration: const InputDecoration(
                  hintText: '0',
                  suffixText: '%',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                onChanged: (value) {
                  final percentage = double.tryParse(value) ?? 0.0;
                  viewModel.updateSplitPercentage(split.userId, percentage);
                },
              ),
            ),
            const SizedBox(width: 8),
          ],
          SizedBox(
            width: 120,
            child: TextFormField(
              initialValue: split.amount > 0 ? split.amount.toString() : '',
              decoration: const InputDecoration(
                hintText: '0.00',
                prefixText: '₹',
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              readOnly: state.splitType == SplitType.equally || state.splitType == SplitType.percentage,
              onChanged: state.splitType == SplitType.unequally ? (value) {
                final amount = double.tryParse(value) ?? 0.0;
                viewModel.updateSplitAmount(split.userId, amount);
              } : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceSummary(BuildContext context, ExpenseState state) {
    final difference = state.totalPaidAmount - state.totalSplitAmount;
    final isBalanced = difference.abs() < 0.01;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isBalanced 
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isBalanced ? Colors.green : Colors.red,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                isBalanced ? Icons.check_circle : Icons.error,
                color: isBalanced ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  isBalanced ? 'Expense is balanced' : 'Expense is not balanced',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isBalanced ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
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
                      '₹${state.totalPaidAmount.toStringAsFixed(2)}',
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
                      '₹${state.totalSplitAmount.toStringAsFixed(2)}',
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
                        color: isBalanced ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!isBalanced) ...[
            const SizedBox(height: 12),
            Text(
              difference > 0 
                  ? 'Total paid amount is more than split amount'
                  : 'Total split amount is more than paid amount',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  String _getSplitTypeLabel(SplitType type) {
    switch (type) {
      case SplitType.equally:
        return 'Equally';
      case SplitType.unequally:
        return 'Unequally';
      case SplitType.percentage:
        return 'By Percentage';
    }
  }

  void _saveExpense(BuildContext context, ExpenseViewModel viewModel) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final success = await viewModel.saveExpense();
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.expenseId != null 
                ? 'Expense updated successfully!'
                : 'Expense added successfully!',
          ),
          backgroundColor: Colors.green,
        ),
      );
      context.pop(true); // Return true to indicate success
    } else if (mounted) {
      final state = ref.read(expenseViewModelProvider(widget.expenseId));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error ?? 'Failed to save expense'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showDeleteConfirmation(BuildContext context, ExpenseViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Expense'),
        content: const Text('Are you sure you want to delete this expense? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final success = await viewModel.deleteExpense();
              if (success && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Expense deleted successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
                context.pop(true);
              } else if (mounted) {
                final state = ref.read(expenseViewModelProvider(widget.expenseId));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error ?? 'Failed to delete expense'),
                    backgroundColor: Colors.red,
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