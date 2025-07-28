import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitxapp/models/group.dart';
import 'package:splitxapp/models/recent_activity.dart';
import 'package:splitxapp/helpers/base_screen_view.dart';
import 'package:splitxapp/helpers/base_view_model.dart';

final homeViewModel = ChangeNotifierProvider((ref) => HomeViewModel());

class HomeViewModel extends BaseViewModel<BaseScreenView> {
  String _userName = '';
  String _overallBalance = '₹0';
  String _youOwe = '₹0';
  String _youAreOwed = '₹0';
  bool _hasUnreadNotifications = false;
  List<Group> _groups = [];
  List<RecentActivity> _recentActivities = [];

  String get userName => _userName;
  String get overallBalance => _overallBalance;
  String get youOwe => _youOwe;
  String get youAreOwed => _youAreOwed;
  bool get hasUnreadNotifications => _hasUnreadNotifications;
  List<Group> get groups => _groups;
  List<RecentActivity> get recentActivities => _recentActivities;

  Future<void> loadUserData() async {
    try {
      toggleLoading();
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data
      _userName = 'John Doe';
      _overallBalance = '₹1,250';
      _youOwe = '₹800';
      _youAreOwed = '₹2,050';
      _hasUnreadNotifications = true;
      
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
      
      _recentActivities = [
        RecentActivity(
          id: '1',
          type: 'expense_added',
          title: 'Dinner at Restaurant',
          description: 'Added by Alex in Trip to Goa',
          amount: '₹2,500',
          time: '2 hours ago',
        ),
        RecentActivity(
          id: '2',
          type: 'payment_made',
          title: 'Payment Received',
          description: 'Sarah paid you ₹1,200',
          amount: '₹1,200',
          time: '1 day ago',
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
    await loadUserData();
    view?.showSnackbar('Data refreshed!');
  }

  void addExpense(BuildContext context) {
    view?.showSnackbar('Add expense feature coming soon!');
  }

  void createGroup(BuildContext context) {
    view?.showSnackbar('Create group feature coming soon!');
  }

  void viewAllGroups(BuildContext context) {
    view?.showSnackbar('View all groups feature coming soon!');
  }

  void openGroup(BuildContext context, Group group) {
    view?.showSnackbar('Opening ${group.name}...');
  }

  void showNotifications(BuildContext context) {
    view?.showSnackbar('Notifications feature coming soon!');
  }
}
