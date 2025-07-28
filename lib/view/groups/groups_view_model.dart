import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitxapp/helpers/base_screen_view.dart';
import 'package:splitxapp/helpers/base_view_model.dart';
import 'package:splitxapp/models/group.dart';

final groupsViewModel = ChangeNotifierProvider((ref) => GroupsViewModel());

class GroupsViewModel extends BaseViewModel<BaseScreenView> {
  String _userName = '';
  String _overallBalance = '₹0';
  String _youOwe = '₹0';
  String _youAreOwed = '₹0';
  List<Group> _groups = [];

  String get userName => _userName;
  String get overallBalance => _overallBalance;
  String get youOwe => _youOwe;
  String get youAreOwed => _youAreOwed;
  List<Group> get groups => _groups;

  Future<void> loadData() async {
    try {
      toggleLoading();
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data
      _userName = 'John Doe';
      _overallBalance = '₹1,250';
      _youOwe = '₹800';
      _youAreOwed = '₹2,050';
      
      _groups = [
        Group(
          id: '1',
          name: 'Trip to Goa',
          memberCount: 4,
          totalExpense: '₹15,000',
          yourShare: '₹3,750',
          color: Colors.blue,
        ),
        Group(
          id: '2',
          name: 'Office Lunch',
          memberCount: 6,
          totalExpense: '₹2,500',
          yourShare: '₹417',
          color: Colors.green,
        ),
        Group(
          id: '3',
          name: 'Apartment Rent',
          memberCount: 3,
          totalExpense: '₹45,000',
          yourShare: '₹15,000',
          color: Colors.orange,
        ),
      ];
      
    } catch (e) {
      errorMessage = 'Failed to load data';
      view?.showSnackbar(errorMessage!, color: Colors.red);
    } finally {
      toggleLoading();
    }
  }

  Future<void> refreshData() async {
    await loadData();
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
    view?.showSnackbar('Opening ${group.name}...');
  }
}
