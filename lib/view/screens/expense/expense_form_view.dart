// view/screens/expense/expense_form_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitxapp/models/group_member.dart';
import 'package:splitxapp/utils/colors.dart';
import 'package:splitxapp/view/screens/expense/expense_form_view_model.dart';
import 'package:splitxapp/view/widgets/member_selection_widget.dart';
import 'package:splitxapp/view/widgets/split_amount_widget.dart';

enum ExpenseFormMode { create, update, view }

enum SplitMode { equally, unequally }

class ExpenseFormView extends ConsumerStatefulWidget {
  final String groupId;
  final ExpenseFormMode mode;
  final String? expenseId;

  const ExpenseFormView({
    super.key,
    required this.groupId,
    required this.mode,
    this.expenseId,
  });

  @override
  ConsumerState<ExpenseFormView> createState() => _ExpenseFormViewState();
}

class _ExpenseFormViewState extends ConsumerState<ExpenseFormView> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(expenseFormViewModelProvider(widget.groupId).notifier)
          .initialize(widget.mode, widget.expenseId);
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(expenseFormViewModelProvider(widget.groupId));
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: widget.mode == ExpenseFormMode.view
            ? [
                IconButton(
                  onPressed: () => _switchToEditMode(),
                  icon: const Icon(Icons.edit),
                ),
              ]
            : null,
      ),
      body: viewModel.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildExpenseBasicInfo(viewModel),
                    const SizedBox(height: 24),
                    _buildCategorySelection(viewModel),
                    const SizedBox(height: 24),
                    _buildPayersSection(viewModel),
                    const SizedBox(height: 24),
                    _buildSplitSection(viewModel),
                    const SizedBox(height: 32),
                    if (widget.mode != ExpenseFormMode.view)
                      _buildActionButtons(viewModel),
                  ],
                ),
              ),
            ),
    );
  }

  String _getAppBarTitle() {
    switch (widget.mode) {
      case ExpenseFormMode.create:
        return 'Add Expense';
      case ExpenseFormMode.update:
        return 'Edit Expense';
      case ExpenseFormMode.view:
        return 'Expense Details';
    }
  }

  Widget _buildExpenseBasicInfo(ExpenseFormState viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Expense Details',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _descriptionController,
          enabled: widget.mode != ExpenseFormMode.view,
          decoration: const InputDecoration(
            labelText: 'Description',
            hintText: 'Enter expense description',
            prefixIcon: Icon(Icons.description_outlined),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a description';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _amountController,
          enabled: widget.mode != ExpenseFormMode.view,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Amount',
            hintText: 'Enter amount',
            prefixIcon: Icon(Icons.currency_rupee),
          ),
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
          onChanged: (value) {
            final amount = double.tryParse(value) ?? 0;
            ref.read(expenseFormViewModelProvider(widget.groupId).notifier)
                .updateAmount(amount);
          },
        ),
      ],
    );
  }

  Widget _buildCategorySelection(ExpenseFormState viewModel) {
    final categories = [
      'Food', 'Transport', 'Accommodation', 
      'Entertainment', 'Shopping', 'Other'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categories.map((category) {
            final isSelected = viewModel.selectedCategory == category;
            return FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: widget.mode != ExpenseFormMode.view 
                  ? (selected) {
                      ref.read(expenseFormViewModelProvider(widget.groupId).notifier)
                          .selectCategory(selected ? category : null);
                    }
                  : null,
              selectedColor: kPrimaryColor.withOpacity(0.2),
              checkmarkColor: kPrimaryColor,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPayersSection(ExpenseFormState viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Who paid?',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (widget.mode != ExpenseFormMode.view)
              TextButton(
                onPressed: () => _showMemberSelection(context, true),
                child: Text(
                  'Select',
                  style: TextStyle(color: kPrimaryColor),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (viewModel.selectedPayers.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: kGrey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'No payers selected',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: kGrey,
              ),
            ),
          )
        else
          MemberSelectionWidget(
            members: viewModel.selectedPayers,
            amounts: viewModel.payerAmounts,
            onAmountChanged: widget.mode != ExpenseFormMode.view
                ? (memberId, amount) {
                    ref.read(expenseFormViewModelProvider(widget.groupId).notifier)
                        .updatePayerAmount(memberId, amount);
                  }
                : null,
            onRemove: widget.mode != ExpenseFormMode.view
                ? (memberId) {
                    ref.read(expenseFormViewModelProvider(widget.groupId).notifier)
                        .removePayer(memberId);
                  }
                : null,
          ),
      ],
    );
  }

  Widget _buildSplitSection(ExpenseFormState viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Split between',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (widget.mode != ExpenseFormMode.view)
              TextButton(
                onPressed: () => _showMemberSelection(context, false),
                child: Text(
                  'Select',
                  style: TextStyle(color: kPrimaryColor),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (viewModel.selectedSplitMembers.isNotEmpty) ...[
          Row(
            children: [
              Expanded(
                child: RadioListTile<SplitMode>(
                  title: const Text('Split Equally'),
                  value: SplitMode.equally,
                  groupValue: viewModel.splitMode,
                  onChanged: widget.mode != ExpenseFormMode.view
                      ? (value) {
                          ref.read(expenseFormViewModelProvider(widget.groupId).notifier)
                              .changeSplitMode(value!);
                        }
                      : null,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              Expanded(
                child: RadioListTile<SplitMode>(
                  title: const Text('Split Unequally'),
                  value: SplitMode.unequally,
                  groupValue: viewModel.splitMode,
                  onChanged: widget.mode != ExpenseFormMode.view
                      ? (value) {
                          ref.read(expenseFormViewModelProvider(widget.groupId).notifier)
                              .changeSplitMode(value!);
                        }
                      : null,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SplitAmountWidget(
            members: viewModel.selectedSplitMembers,
            amounts: viewModel.splitAmounts,
            splitMode: viewModel.splitMode,
            totalAmount: viewModel.totalAmount,
            onAmountChanged: widget.mode != ExpenseFormMode.view
                ? (memberId, amount) {
                    ref.read(expenseFormViewModelProvider(widget.groupId).notifier)
                        .updateSplitAmount(memberId, amount);
                  }
                : null,
            onRemove: widget.mode != ExpenseFormMode.view
                ? (memberId) {
                    ref.read(expenseFormViewModelProvider(widget.groupId).notifier)
                        .removeSplitMember(memberId);
                  }
                : null,
          ),
        ] else
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: kGrey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'No members selected for split',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: kGrey,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildActionButtons(ExpenseFormState viewModel) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: viewModel.loading ? null : _handleSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: viewModel.loading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(
                    widget.mode == ExpenseFormMode.create 
                        ? 'Create Expense' 
                        : 'Update Expense',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: kGrey.withOpacity(0.3)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showMemberSelection(BuildContext context, bool isForPayers) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          return Container(
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
                Text(
                  isForPayers ? 'Select Payers' : 'Select Members to Split',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Consumer(
                    builder: (context, ref, child) {
                      final viewModel = ref.watch(
                          expenseFormViewModelProvider(widget.groupId));
                      
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: viewModel.groupMembers.length,
                        itemBuilder: (context, index) {
                          final member = viewModel.groupMembers[index];
                          final isSelected = isForPayers 
                              ? viewModel.selectedPayers.contains(member)
                              : viewModel.selectedSplitMembers.contains(member);
                          
                          return CheckboxListTile(
                            title: Text(member.name),
                            subtitle: Text(member.email),
                            value: isSelected,
                            onChanged: (selected) {
                              if (isForPayers) {
                                if (selected == true) {
                                  ref.read(expenseFormViewModelProvider(widget.groupId).notifier)
                                      .addPayer(member);
                                } else {
                                  ref.read(expenseFormViewModelProvider(widget.groupId).notifier)
                                      .removePayer(member.id);
                                }
                              } else {
                                if (selected == true) {
                                  ref.read(expenseFormViewModelProvider(widget.groupId).notifier)
                                      .addSplitMember(member);
                                } else {
                                  ref.read(expenseFormViewModelProvider(widget.groupId).notifier)
                                      .removeSplitMember(member.id);
                                }
                              }
                            },
                            activeColor: kPrimaryColor,
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _switchToEditMode() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseFormView(
          groupId: widget.groupId,
          mode: ExpenseFormMode.update,
          expenseId: widget.expenseId,
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      ref.read(expenseFormViewModelProvider(widget.groupId).notifier)
          .submitExpense(
            context,
            _descriptionController.text,
            widget.mode,
            widget.expenseId,
          );
    }
  }
}
