import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:splitxapp/data/groups/group_repo.dart';
import 'package:splitxapp/domain/provider/repository_provider.dart';
import 'package:splitxapp/helpers/base_screen_view.dart';
import 'package:splitxapp/helpers/base_view_model.dart';
import 'package:splitxapp/models/api_query.dart';
import 'package:splitxapp/models/group.dart';
import 'package:splitxapp/routes/app_routes.dart';
import 'package:splitxapp/utils/extensions.dart';

final groupsViewModel = ChangeNotifierProvider((ref) => GroupsViewModel(ref, ref.read(groupRepo)));

class GroupsViewModel extends BaseViewModel<BaseScreenView> {
  final Ref _ref;
  final GroupRepo _groupRepo;
  
  int _currentPage = 1;
  final int _pageSize = 2;
  bool _hasMore = true;
  bool _isFetching = false;

  String _userName = '';
  String _overallBalance = '₹0';
  String _youOwe = '₹0';
  String _youAreOwed = '₹0';
  List<Group> _groups = [];

  
  GroupsViewModel( this._ref, this._groupRepo);

  String get userName => _userName;
  String get overallBalance => _overallBalance;
  String get youOwe => _youOwe;
  String get youAreOwed => _youAreOwed;
  List<Group> get groups => _groups;

  /* Future<void> loadData() async {
    try {
      toggleLoading();
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      final user = _ref.read(userSessionProvider);
      _userName = user?.name ?? '';
      _overallBalance = '₹1,250';
      _youOwe = '₹800';
      _youAreOwed = '₹2,050';

      final result = await _groupRepo.getGroups();
      result.handle(
        onRight: (response) {
          _groups = response.result.data
              .map(
                (g) => Group(
                  id: g.groupId,
                  name: g.name,
                  memberCount: 0,
                  totalExpense: "₹0",
                  yourShare: "₹0",  
                  color: Colors.blue,
                ),
              )
              .toList();
        },
        onLeft: (failure) {
          errorMessage = "Failed to fetch groups";
          view?.showSnackbar(errorMessage!, color: Colors.red);
          _groups = [];
        }
      );  
      
    } catch (e) {
      errorMessage = 'Failed to load data';
      view?.showSnackbar(errorMessage!, color: Colors.red);
    } finally {
      toggleLoading();
    }
  } */

  Future<void> loadInitialData() async {
    _currentPage = 1;
    _groups.clear();
    _hasMore = true;
    await fetchMoreGroups();
  }

  Future<void> fetchMoreGroups() async {
    if (!_hasMore || _isFetching) return;
    _isFetching = true;

    try {
      final query = ApiQuery(page: _currentPage, pageSize: _pageSize);
      final result = await _groupRepo.getGroups(query);

      result.handle(
        onRight: (response) {
          final fetched = response.result.data
              .map((g) => Group(
                    id: g.groupId,
                    name: g.name,
                    memberCount: 0,
                    totalExpense: "₹0",
                    yourShare: "₹0",
                    color: Colors.blue,
                  ))
              .toList();

          if (fetched.length < _pageSize) {
            _hasMore = false;
          }

          _groups.addAll(fetched);
          _currentPage++;
          notifyListeners();
        },
        onLeft: (failure) {
          errorMessage = "Failed to fetch groups";
          view?.showSnackbar(errorMessage!, color: Colors.red);
        },
      );
    } finally {
      _isFetching = false;
    }
  }

  Future<void> refreshData() async {
    // await loadData();
    await loadInitialData();
    view?.showSnackbar('Data refreshed!');
  }

  void createGroup(BuildContext context) {
    view?.showSnackbar('Create group feature coming soon!');
  }

  void inviteFriends(BuildContext context) {
    view?.showSnackbar('Invite friends feature coming soon!');
  }

  void viewAllGroups(BuildContext context) {
    view?.showSnackbar('View all groups feature coming soon!');
  }

  void openGroup(BuildContext context, Group group) {
  context.pushNamed(
    AppRoute.groupMain.name,
    pathParameters: {'groupId': group.id},
    queryParameters: {'groupName': group.name},
  );
}
}
