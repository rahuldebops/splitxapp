import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    if (members.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kInputBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kBorder),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: kTextMuted, size: 20),
            const SizedBox(width: 8),
            Text(
              'No members selected',
              style: TextStyle(color: kTextMuted),
            ),
          ],
        ),
      );
    }

    return Column(
      children: members.asMap().entries.map((entry) {
        final member = entry.value;
        final currentAmount = amounts[member.id] ?? 0.0;
        
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
                    Text(
                      member.email,
                      style: const TextStyle(
                        color: kTextSecondary,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Amount Input/Display
              if (onAmountChanged != null)
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: kCardBackground,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: kInputBorder),
                  ),
                  child: TextFormField(
                    key: ValueKey('payer_${member.id}'),
                    initialValue: currentAmount.toString(),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kTextPrimary,
                      fontSize: 14,
                    ),
                    decoration: const InputDecoration(
                      prefixText: '₹',
                      prefixStyle: TextStyle(
                        color: kTextSecondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    ),
                    onChanged: (value) {
                      final amount = double.tryParse(value) ?? 0;
                      if (amount >= 0) {
                        onAmountChanged!(member.id, amount);
                      }
                    },
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '₹${currentAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
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
    );
  }
}