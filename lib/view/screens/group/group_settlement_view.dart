import 'package:flutter/material.dart';
import 'package:splitxapp/utils/colors.dart';

class GroupSettlementView extends StatelessWidget {
  final String groupId;

  const GroupSettlementView({
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
            'Settlement',
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
                    Icons.handshake_outlined,
                    size: 64,
                    color: kGrey.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Settlement feature coming soon!',
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
