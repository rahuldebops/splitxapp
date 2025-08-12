// view/widgets/member_selection_widget.dart
import 'package:flutter/material.dart';
import 'package:splitxapp/models/group_member.dart';
import 'package:splitxapp/utils/colors.dart';

class MemberSelectionWidget extends StatelessWidget {
  final List<GroupMember> members;
  final Map<String, double> amounts;
  final Function(String, double)? onAmountChanged;
  final Function(String)? onRemove;

  const MemberSelectionWidget({
    super.key,
    required this.members,
    required this.amounts,
    this.onAmountChanged,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: members.map((member) {
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
                    Text(
                      member.email,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: kGrey,
                      ),
                    ),
                  ],
                ),
              ),
              if (onAmountChanged != null)
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
    );
  }
}
