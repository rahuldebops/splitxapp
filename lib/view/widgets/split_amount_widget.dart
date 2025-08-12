// view/widgets/split_amount_widget.dart
import 'package:flutter/material.dart';
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

    return Column(
      children: [
        ...members.map((member) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: kGrey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: member.color.withOpacity(0.1),
                  child: Text(
                    member.initials,
                    style: TextStyle(
                      color: member.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member.name,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (splitMode == SplitMode.equally)
                        Text(
                          'Equal share',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: kGrey,
                          ),
                        ),
                    ],
                  ),
                ),
                if (splitMode == SplitMode.unequally && onAmountChanged != null)
                  SizedBox(
                    width: 80,
                    child: TextFormField(
                      initialValue: amounts[member.id]?.toString() ?? '0',
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '₹',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                      onChanged: (value) {
                        final amount = double.tryParse(value) ?? 0;
                        onAmountChanged!(member.id, amount);
                      },
                    ),
                  )
                else
                  Text(
                    '₹${amounts[member.id]?.toStringAsFixed(2) ?? '0.00'}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                if (onRemove != null) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => onRemove!(member.id),
                    icon: const Icon(Icons.close, size: 20),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ],
            ),
          );
        }).toList(),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isBalanced 
                ? Colors.green.withOpacity(0.1) 
                : Colors.orange.withOpacity(0.1),
            border: Border.all(
              color: isBalanced ? Colors.green : Colors.orange,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Split: ₹${totalSplit.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                isBalanced ? Icons.check_circle : Icons.warning,
                color: isBalanced ? Colors.green : Colors.orange,
                size: 20,
              ),
            ],
          ),
        ),
        if (!isBalanced)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Difference: ₹${(totalAmount - totalSplit).abs().toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
