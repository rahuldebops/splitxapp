import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:splitxapp/routes/app_routes.dart';
import 'package:splitxapp/view/screens/account/account_view.dart';
import 'package:splitxapp/view/screens/activity/activity_view.dart';
import 'package:splitxapp/view/screens/friends/friends_view.dart';
import 'package:splitxapp/view/screens/groups/groups_view.dart';
import 'package:splitxapp/view/widgets/custom_bottom_navbar.dart';
import 'package:splitxapp/view/widgets/custom_header.dart';
import 'package:splitxapp/utils/colors.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

class MainScreen extends ConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    final screens = [
      const GroupsView(),
      const FriendsView(),
      const ActivityView(),
      const AccountView(),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          const CustomHeader(),
          Expanded(
            child: IndexedStack(index: currentIndex, children: screens),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavbar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddExpenseDialog(context),
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void showAddExpenseDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
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
              'Add New',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // Add Expense Option
                  _buildActionTile(
                    context,
                    icon: Icons.receipt_long,
                    title: 'Add Expense',
                    subtitle: 'Split an expense with group members',
                    color: Colors.orange,
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to expense screen - you'll need to pass the current group ID
                      navigateToAddExpense(context, 'current_group_id');
                    },
                  ),
                  const SizedBox(height: 12),
                  // Add Payment Option (for future implementation)
                  _buildActionTile(
                    context,
                    icon: Icons.payment,
                    title: 'Record Payment',
                    subtitle: 'Record a payment between members',
                    color: Colors.green,
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Payment feature coming soon!'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  // Create Group Option
                  _buildActionTile(
                    context,
                    icon: Icons.group_add,
                    title: 'Create Group',
                    subtitle: 'Start a new expense group',
                    color: Colors.blue,
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Create group feature coming soon!'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
  
  void navigateToAddExpense(BuildContext context, String groupId) {
  context.pushNamed(
    AppRoute.expenseAdd.name,
    pathParameters: {'groupId': groupId},
  );
}
}
