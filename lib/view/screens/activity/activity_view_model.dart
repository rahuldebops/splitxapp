import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitxapp/models/recent_activity.dart';

final activityViewModel = ChangeNotifierProvider((ref) => ActivityViewModel());

class ActivityViewModel extends ChangeNotifier {
  List<RecentActivity> _activities = [];
  bool _loading = false;

  List<RecentActivity> get activities => _activities;
  bool get loading => _loading;

  Future<void> loadActivities() async {
    _loading = true;
    notifyListeners();
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      _activities = [
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
        RecentActivity(
          id: '3',
          type: 'expense_added',
          title: 'Grocery Shopping',
          description: 'Added by you in Apartment Rent',
          amount: '₹850',
          time: '2 days ago',
        ),
        RecentActivity(
          id: '4',
          type: 'payment_made',
          title: 'Payment Made',
          description: 'You paid Mike ₹500',
          amount: '₹500',
          time: '3 days ago',
        ),
      ];
      
    } catch (e) {
      // Handle error
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> refreshActivities() async {
    await loadActivities();
  }
}