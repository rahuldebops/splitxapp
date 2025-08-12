import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    
    // Listen for error and success messages
    ref.listen(expenseFormViewModelProvider(widget.groupId), (previous, next) {
      if (next.error != null && next.error != previous?.error) {
        _showErrorSnackBar(next.error!);
        ref.read(expenseFormViewModelProvider(widget.groupId).notifier).clearError();
      }
      if (next.successMessage != null && next.successMessage != previous?.successMessage) {
        _showSuccessSnackBar(next.successMessage!);
        ref.read(expenseFormViewModelProvider(widget.groupId).notifier).clearSuccess();
      }
    });

    // Update text controllers when expense data is loaded (for edit/view mode)
    if (widget.mode != ExpenseFormMode.create && viewModel.totalAmount > 0) {
      if (_amountController.text.isEmpty || 
          double.tryParse(_amountController.text) != viewModel.totalAmount) {
        _amountController.text = viewModel.totalAmount.toString();
      }
    }

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: Text(
          _getAppBarTitle(),
          style: const TextStyle(
            color: kTextPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: kSurface,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: const IconThemeData(color: kTextPrimary),
        actions: widget.mode == ExpenseFormMode.view ? [
          IconButton(
            onPressed: () => _switchToEditMode(),
            icon: const Icon(Icons.edit_outlined),
            style: IconButton.styleFrom(
              foregroundColor: kPrimaryColor,
            ),
          ),
        ] : null,
      ),
      body: viewModel.loading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildExpenseBasicInfo(viewModel),
                    const SizedBox(height: 24),
                    _buildCategorySelection(viewModel),
                    const SizedBox(height: 24),
                    _buildBalanceOverview(viewModel),
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
    return Card(
      color: kCardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: kBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.receipt_long_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Expense Details',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: kTextPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              enabled: widget.mode != ExpenseFormMode.view,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Enter expense description',
                prefixIcon: const Icon(Icons.description_outlined, color: kTextSecondary),
                filled: true,
                fillColor: widget.mode == ExpenseFormMode.view ? kInputBackground : kSurface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kInputBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kInputBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kInputFocused, width: 2),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kBorder),
                ),
                labelStyle: const TextStyle(color: kTextSecondary),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a description';
                }
                if (value.trim().length < 3) {
                  return 'Description must be at least 3 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              enabled: widget.mode != ExpenseFormMode.view,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                labelText: 'Amount',
                hintText: 'Enter amount',
                prefixIcon: const Icon(Icons.currency_rupee, color: kTextSecondary),
                filled: true,
                fillColor: widget.mode == ExpenseFormMode.view ? kInputBackground : kSurface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kInputBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kInputBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kInputFocused, width: 2),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kBorder),
                ),
                labelStyle: const TextStyle(color: kTextSecondary),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                final amount = double.tryParse(value);
                if (amount == null || amount <= 0) {
                  return 'Please enter a valid amount greater than 0';
                }
                if (amount > 999999) {
                  return 'Amount cannot exceed ₹999,999';
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
        ),
      ),
    );
  }

  Widget _buildCategorySelection(ExpenseFormState viewModel) {
    final categories = [
      {'name': 'Food', 'icon': Icons.restaurant_outlined},
      {'name': 'Transport', 'icon': Icons.directions_car_outlined},
      {'name': 'Accommodation', 'icon': Icons.hotel_outlined},
      {'name': 'Entertainment', 'icon': Icons.movie_outlined},
      {'name': 'Shopping', 'icon': Icons.shopping_bag_outlined},
      {'name': 'Other', 'icon': Icons.category_outlined},
    ];

    return Card(
      color: kCardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: kBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.category_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Category',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: kTextPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: categories.map((category) {
                final isSelected = viewModel.selectedCategory == category['name'];
                return GestureDetector(
                  onTap: widget.mode != ExpenseFormMode.view
                      ? () {
                          ref.read(expenseFormViewModelProvider(widget.groupId).notifier)
                              .selectCategory(isSelected ? null : category['name'] as String);
                        }
                      : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? kPrimaryColor : kInputBackground,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? kPrimaryColor : kBorder,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          category['icon'] as IconData,
                          size: 18,
                          color: isSelected ? Colors.white : kTextSecondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          category['name'] as String,
                          style: TextStyle(
                            color: isSelected ? Colors.white : kTextPrimary,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceOverview(ExpenseFormState viewModel) {
    return Card(
      color: kCardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: kBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getBalanceColor(viewModel.balanceStatus),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getBalanceIcon(viewModel.balanceStatus),
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Balance Overview',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: kTextPrimary,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getBalanceColor(viewModel.balanceStatus).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getBalanceStatusText(viewModel.balanceStatus),
                    style: TextStyle(
                      color: _getBalanceColor(viewModel.balanceStatus),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildBalanceRow('Total Amount', viewModel.totalAmount, kTextPrimary),
            const SizedBox(height: 8),
            _buildBalanceRow(
              'Total Payments', 
              viewModel.totalPayments, 
              viewModel.isPaymentBalanced ? kSuccess : kError,
            ),
            const SizedBox(height: 8),
            _buildBalanceRow(
              'Total Splits', 
              viewModel.totalSplits, 
              viewModel.isSplitBalanced ? kSuccess : kError,
            ),
            if (!viewModel.isCompletelyBalanced) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: kError.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kError.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_outlined, color: kError, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _getBalanceMessage(viewModel),
                        style: const TextStyle(
                          color: kError,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceRow(String label, double amount, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: kTextSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '₹${amount.toStringAsFixed(2)}',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildPayersSection(ExpenseFormState viewModel) {
    return Card(
      color: kCardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: kBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: kSecondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.payment_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Who paid?',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: kTextPrimary,
                      ),
                    ),
                  ],
                ),
                if (widget.mode != ExpenseFormMode.view)
                  TextButton.icon(
                    onPressed: () => _showMemberSelection(context, true),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add Payer'),
                    style: TextButton.styleFrom(
                      foregroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
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
        ),
      ),
    );
  }

  Widget _buildSplitSection(ExpenseFormState viewModel) {
    return Card(
      color: kCardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: kBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: kInfo,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.people_outline,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Split between',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: kTextPrimary,
                      ),
                    ),
                  ],
                ),
                if (widget.mode != ExpenseFormMode.view)
                  TextButton.icon(
                    onPressed: () => _showMemberSelection(context, false),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add Members'),
                    style: TextButton.styleFrom(
                      foregroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            if (viewModel.selectedSplitMembers.isNotEmpty) ...[
              if (widget.mode != ExpenseFormMode.view)
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<SplitMode>(
                        title: const Text('Split Equally'),
                        value: SplitMode.equally,
                        groupValue: viewModel.splitMode,
                        onChanged: (value) {
                          ref.read(expenseFormViewModelProvider(widget.groupId).notifier)
                              .changeSplitMode(value!);
                        },
                        contentPadding: EdgeInsets.zero,
                        activeColor: kPrimaryColor,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<SplitMode>(
                        title: const Text('Split Unequally'),
                        value: SplitMode.unequally,
                        groupValue: viewModel.splitMode,
                        onChanged: (value) {
                          ref.read(expenseFormViewModelProvider(widget.groupId).notifier)
                              .changeSplitMode(value!);
                        },
                        contentPadding: EdgeInsets.zero,
                        activeColor: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              if (widget.mode != ExpenseFormMode.view) const SizedBox(height: 16),
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
                  color: kInputBackground,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kBorder),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: kTextMuted, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'No members selected for split',
                      style: TextStyle(color: kTextMuted),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(ExpenseFormState viewModel) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: viewModel.loading || !viewModel.isCompletelyBalanced ? null : _handleSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              disabledBackgroundColor: kTextDisabled,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: viewModel.loading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    widget.mode == ExpenseFormMode.create ? 'Create Expense' : 'Update Expense',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: kBorder),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kTextSecondary,
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
            decoration: const BoxDecoration(
              color: kCardBackground,
              borderRadius: BorderRadius.only(
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
                    color: kDivider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  isForPayers ? 'Select Payers' : 'Select Members to Split',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: kTextPrimary,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Consumer(
                    builder: (context, ref, child) {
                      final viewModel = ref.watch(expenseFormViewModelProvider(widget.groupId));
                      
                      if (viewModel.groupMembers.isEmpty) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.people_outline, size: 64, color: kTextMuted),
                              SizedBox(height: 16),
                              Text(
                                'No group members found',
                                style: TextStyle(
                                  color: kTextMuted,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.separated(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: viewModel.groupMembers.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final member = viewModel.groupMembers[index];
                          final isSelected = isForPayers
                              ? viewModel.selectedPayers.any((p) => p.id == member.id)
                              : viewModel.selectedSplitMembers.any((m) => m.id == member.id);

                          return Container(
                            decoration: BoxDecoration(
                              color: isSelected ? kPrimaryColor.withOpacity(0.1) : kInputBackground,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? kPrimaryColor : kBorder,
                              ),
                            ),
                            child: CheckboxListTile(
                              title: Text(
                                member.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: kTextPrimary,
                                ),
                              ),
                              subtitle: Text(
                                member.email,
                                style: const TextStyle(color: kTextSecondary),
                              ),
                              secondary: CircleAvatar(
                                backgroundColor: member.color,
                                child: Text(
                                  member.initials,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
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
      // Double-check balance before submission
      final viewModel = ref.read(expenseFormViewModelProvider(widget.groupId));
      if (!viewModel.isCompletelyBalanced) {
        _showErrorSnackBar('Please ensure all amounts are balanced before submitting.');
        return;
      }

      ref.read(expenseFormViewModelProvider(widget.groupId).notifier)
          .submitExpense(
        context,
        _descriptionController.text.trim(),
        widget.mode,
        widget.expenseId,
      );
    }
  }

  Color _getBalanceColor(BalanceStatus status) {
    switch (status) {
      case BalanceStatus.balanced:
        return kSuccess;
      case BalanceStatus.paymentImbalanced:
      case BalanceStatus.splitImbalanced:
        return kWarning;
      case BalanceStatus.bothImbalanced:
        return kError;
    }
  }

  IconData _getBalanceIcon(BalanceStatus status) {
    switch (status) {
      case BalanceStatus.balanced:
        return Icons.check_circle_outline;
      case BalanceStatus.paymentImbalanced:
      case BalanceStatus.splitImbalanced:
        return Icons.warning_outlined;
      case BalanceStatus.bothImbalanced:
        return Icons.error_outline;
    }
  }

  String _getBalanceStatusText(BalanceStatus status) {
    switch (status) {
      case BalanceStatus.balanced:
        return 'Balanced';
      case BalanceStatus.paymentImbalanced:
        return 'Payment Issue';
      case BalanceStatus.splitImbalanced:
        return 'Split Issue';
      case BalanceStatus.bothImbalanced:
        return 'Unbalanced';
    }
  }

  String _getBalanceMessage(ExpenseFormState viewModel) {
    if (!viewModel.isPaymentBalanced && !viewModel.isSplitBalanced) {
      return 'Both payments and splits are unbalanced. Please adjust the amounts.';
    } else if (!viewModel.isPaymentBalanced) {
      return 'Payments don\'t match total amount. Difference: ₹${viewModel.paymentDifference.abs().toStringAsFixed(2)}';
    } else {
      return 'Splits don\'t match total amount. Difference: ₹${viewModel.splitDifference.abs().toStringAsFixed(2)}';
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: kError,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: kSuccess,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}