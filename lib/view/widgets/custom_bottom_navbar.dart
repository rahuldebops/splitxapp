import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitxapp/utils/colors.dart';
import 'package:splitxapp/view/screens/main/main_screen.dart';

class CustomBottomNavbar extends ConsumerWidget {
  const CustomBottomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: Theme.of(context).bottomAppBarTheme.color,
      elevation: 8,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              context,
              ref,
              icon: Icons.group_outlined,
              activeIcon: Icons.group,
              label: 'Groups',
              index: 0,
              isActive: currentIndex == 0,
            ),
            _buildNavItem(
              context,
              ref,
              icon: Icons.people_outline,
              activeIcon: Icons.people,
              label: 'Friends',
              index: 1,
              isActive: currentIndex == 1,
            ),
            const SizedBox(width: 40), // Space for FAB
            _buildNavItem(
              context,
              ref,
              icon: Icons.history_outlined,
              activeIcon: Icons.history,
              label: 'Activity',
              index: 2,
              isActive: currentIndex == 2,
            ),
            _buildNavItem(
              context,
              ref,
              icon: Icons.account_circle_outlined,
              activeIcon: Icons.account_circle,
              label: 'Account',
              index: 3,
              isActive: currentIndex == 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    WidgetRef ref, {
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () => ref.read(currentIndexProvider.notifier).state = index,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? activeIcon : icon,
            color: isActive ? kPrimaryColor : kGrey,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isActive ? kPrimaryColor : kGrey,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}