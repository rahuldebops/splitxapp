import 'package:flutter/material.dart';
import 'package:splitxapp/utils/colors.dart';

class GroupTotalsView extends StatelessWidget {
  final String groupId;

  const GroupTotalsView({
    Key? key,
    required this.groupId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Totals',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calculate_outlined,
                    size: 64,
                    color: kGrey.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Totals feature coming soon!',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: kGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
