import 'package:flutter/material.dart';
import 'package:splitxapp/models/recent_activity.dart';
import 'package:splitxapp/utils/colors.dart';

class RecentActivityCard extends StatelessWidget {
  final RecentActivity activity;

  const RecentActivityCard({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kGrey.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getActivityColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getActivityIcon(),
              color: _getActivityColor(),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.titleSmall?.color, // Ensures proper text color
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  activity.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: kGrey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  activity.time,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: kGrey.withOpacity(0.7),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Text(
            activity.amount,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: _getActivityColor(),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getActivityIcon() {
    switch (activity.type) {
      case 'expense_added':
        return Icons.receipt_long;
      case 'payment_made':
        return Icons.payment;
      default:
        return Icons.info;
    }
  }

  Color _getActivityColor() {
    switch (activity.type) {
      case 'expense_added':
        return Colors.orange;
      case 'payment_made':
        return Colors.green;
      default:
        return kPrimaryColor;
    }
  }
}