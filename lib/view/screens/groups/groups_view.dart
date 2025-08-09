import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitxapp/helpers/base_screen_view.dart';
import 'package:splitxapp/routes/app_routes.dart';
import 'package:splitxapp/utils/colors.dart';
import 'package:splitxapp/view/screens/groups/groups_view_model.dart';
import 'package:splitxapp/view/widgets/group_card.dart';

class GroupsView extends ConsumerStatefulWidget {
  const GroupsView({super.key});

  @override
  ConsumerState<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends ConsumerState<GroupsView> with BaseScreenView {
  late final GroupsViewModel _viewModel;
  late final ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(groupsViewModel);
    _viewModel.attachView(this);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _viewModel.fetchMoreGroups();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _viewModel.loadData();
      _viewModel.loadInitialData();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final viewModel = ref.watch(groupsViewModel);

        return RefreshIndicator(
          onRefresh: () => _viewModel.refreshData(),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Greeting Section
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getGreeting(),
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: kGrey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        viewModel.userName,
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                      ),
                    ],
                  ),
                ),
              ),

              // Overall Balance Card
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [kPrimaryColor, kPrimaryColor.withOpacity(0.8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryColor.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overall Balance',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        viewModel.overallBalance,
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'You owe',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                ),
                                Text(
                                  viewModel.youOwe,
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'You are owed',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                ),
                                Text(
                                  viewModel.youAreOwed,
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Quick Actions
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildQuickActionButton(
                          icon: Icons.group_add,
                          label: 'Create Group',
                          onTap: () => _viewModel.createGroup(context),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildQuickActionButton(
                          icon: Icons.people_alt,
                          label: 'Invite Friends',
                          onTap: () => _viewModel.inviteFriends(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Groups Section Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Groups',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (viewModel.groups.isNotEmpty)
                        TextButton(
                          onPressed: () => _viewModel.viewAllGroups(context),
                          child: Text(
                            'View All',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Groups List
              if (viewModel.loading)
                const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              else if (viewModel.groups.isEmpty)
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.all(24),
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: kGrey.withOpacity(0.2)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.group_outlined,
                          size: 48,
                          color: kGrey.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No Groups Yet',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Create your first group to start splitting expenses with friends',
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: kGrey),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => _viewModel.createGroup(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                          ),
                          child: const Text(
                            'Create Group',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final group = viewModel.groups[index];
                    return GroupCard(
                      group: group,
                      onTap: () => _viewModel.openGroup(context, group),
                    );
                  }, childCount: viewModel.groups.length),
                ),

              // Bottom padding for FAB
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kGrey.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: kPrimaryColor, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  @override
  void showSnackbar(String message, {Color? color}) {
    final snackBar = SnackBar(
      backgroundColor: color ?? Theme.of(context).snackBarTheme.backgroundColor,
      content: Text(message),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          ScaffoldMessenger.of(context).clearSnackBars();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void navigateToScreen(AppRoute appRoute, {Map<String, String>? params}) {
    // TODO: implement navigateToScreen
  }

  @override
  void navigateToScreenAsFirst(
    AppRoute appRoute, {
    Map<String, String>? params,
  }) {
    // TODO: implement navigateToScreenAsFirst
  }
}
