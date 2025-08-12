import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splitxapp/models/group_member.dart';
import 'package:splitxapp/view/screens/expense/expense_form_view.dart';
import 'package:splitxapp/utils/colors.dart';

class SplitAmountWidget extends StatelessWidget {
  final List<GroupMember> members;
  final Map<String, double> amounts;
  final SplitMode splitMode;
  final double totalAmount;
  final Function(String, double)? onAmountChanged;
  final Function(String)? onRemove;

  const SplitAmountWidget({
    super.key,
    required this.members,
    required this.amounts,
    required this.splitMode,
    required this.totalAmount,
    this.onAmountChanged,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final totalSplit = amounts.values.fold(0.0, (sum, amount) => sum + amount);
    final isBalanced = (totalAmount - totalSplit).abs() < 0.01;
    final difference = totalAmount - totalSplit;

    return Column(
      children: [
        // Member List
        ...members.map((member) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kInputBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kBorder),
            ),
            child: Row(
              children: [
                // Member Avatar
                CircleAvatar(
                  radius: 24,
                  backgroundColor: member.color,
                  child: Text(
                    member.initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Member Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: kTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      if (splitMode == SplitMode.equally)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: kSuccess.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Equal share',
                            style: TextStyle(
                              color: kSuccess,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      else
                        Text(
                          'Custom amount',
                          style: const TextStyle(
                            color: kTextSecondary,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // Amount Input/Display
                if (splitMode == SplitMode.unequally && onAmountChanged != null)
                  Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: kCardBackground,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: kInputBorder),
                    ),
                    child: TextFormField(
                      initialValue: amounts[member.id]?.toString() ?? '0',
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                      ],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kTextPrimary,
                      ),
                      decoration: const InputDecoration(
                        prefixText: '₹',
                        prefixStyle: TextStyle(
                          color: kTextSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      ),
                      onChanged: (value) {
                        final amount = double.tryParse(value) ?? 0;
                        onAmountChanged!(member.id, amount);
                      },
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: kInfo.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '₹${amounts[member.id]?.toStringAsFixed(2) ?? '0.00'}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kInfo,
                        fontSize: 14,
                      ),
                    ),
                  ),
                
                // Remove Button
                if (onRemove != null) ...[
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => onRemove!(member.id),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: kError.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: kError,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        }).toList(),
        
        const SizedBox(height: 16),
        
        // Balance Summary Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _getBalanceCardColor(isBalanced),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _getBalanceBorderColor(isBalanced)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getBalanceIcon(isBalanced),
                        color: _getBalanceIconColor(isBalanced),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Split Summary',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: _getBalanceTextColor(isBalanced),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getBalanceIconColor(isBalanced).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      isBalanced ? 'Balanced' : 'Unbalanced',
                      style: TextStyle(
                        color: _getBalanceIconColor(isBalanced),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Amount Breakdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          color: kTextSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '₹${totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: kTextPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total Split',
                        style: TextStyle(
                          color: kTextSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '₹${totalSplit.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: _getBalanceIconColor(isBalanced),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Difference',
                        style: TextStyle(
                          color: kTextSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '₹${difference.abs().toStringAsFixed(2)}',
                        style: TextStyle(
                          color: isBalanced ? kSuccess : kError,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              if (!isBalanced) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kError.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: kError, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          difference > 0 
                              ? 'Need to allocate ₹${difference.toStringAsFixed(2)} more'
                              : 'Over-allocated by ₹${difference.abs().toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: kError,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
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
      ],
    );
  }

  Color _getBalanceCardColor(bool isBalanced) {
    return isBalanced ? kSuccess.withOpacity(0.05) : kError.withOpacity(0.05);
  }

  Color _getBalanceBorderColor(bool isBalanced) {
    return isBalanced ? kSuccess.withOpacity(0.2) : kError.withOpacity(0.2);
  }

  Color _getBalanceIconColor(bool isBalanced) {
    return isBalanced ? kSuccess : kError;
  }

  Color _getBalanceTextColor(bool isBalanced) {
    return isBalanced ? kSuccess : kError;
  }

  IconData _getBalanceIcon(bool isBalanced) {
    return isBalanced ? Icons.check_circle_outline : Icons.warning_outlined;
  }
}