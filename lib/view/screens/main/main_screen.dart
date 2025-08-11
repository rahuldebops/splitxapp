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
  const MainScreen({super.key});

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
      bottomNavigationBar: const CustomBottomNavbar()
    );
  }
}
