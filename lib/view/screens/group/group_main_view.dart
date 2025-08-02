import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitxapp/view/screens/group/group_balance_view.dart';
import 'package:splitxapp/view/screens/group/group_expenses_view.dart';
import 'package:splitxapp/view/screens/group/group_payments_view.dart';
import 'package:splitxapp/view/screens/group/group_settlement_view.dart';
import 'package:splitxapp/view/screens/group/group_totals_view.dart';
import 'package:splitxapp/view/widgets/custom_bottom_navbar.dart';
import 'package:splitxapp/view/widgets/group_header.dart';
import 'package:splitxapp/utils/colors.dart';

class GroupMainView extends ConsumerStatefulWidget {
  final String groupId;
  final String groupName;
  final int initialTab;

  const GroupMainView({
    Key? key,
    required this.groupId,
    required this.groupName,
    this.initialTab = 0,
  }) : super(key: key);

  @override
  ConsumerState<GroupMainView> createState() => _GroupMainViewState();
}

class _GroupMainViewState extends ConsumerState<GroupMainView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<String> _tabTitles = [
    'Expenses',
    'Balance',
    'Payments',
    'Settlement',
    'Totals',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabTitles.length,
      vsync: this,
      initialIndex: widget.initialTab,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          GroupHeader(
            groupName: widget.groupName,
            groupId: widget.groupId,
          ),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: kPrimaryColor,
              labelColor: kPrimaryColor,
              unselectedLabelColor: kGrey,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              tabs: _tabTitles.map((title) => Tab(text: title)).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                GroupExpensesView(groupId: widget.groupId),
                GroupBalanceView(groupId: widget.groupId),
                GroupPaymentsView(groupId: widget.groupId),
                GroupSettlementView(groupId: widget.groupId),
                GroupTotalsView(groupId: widget.groupId),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavbar(),
    );
  }
}
