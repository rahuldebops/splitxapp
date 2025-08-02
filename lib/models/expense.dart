// models/expense.dart
import 'package:flutter/material.dart';

enum SplitType {
  equally,
  unequally,
  percentage,
}

class ExpensePayer {
  final String userId;
  final String userName;
  final double amount;

  ExpensePayer({
    required this.userId,
    required this.userName,
    required this.amount,
  });

  ExpensePayer copyWith({
    String? userId,
    String? userName,
    double? amount,
  }) {
    return ExpensePayer(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'amount': amount,
    };
  }

  factory ExpensePayer.fromJson(Map<String, dynamic> json) {
    return ExpensePayer(
      userId: json['userId'],
      userName: json['userName'],
      amount: json['amount'].toDouble(),
    );
  }
}

class ExpenseSplit {
  final String userId;
  final String userName;
  final double amount;
  final double percentage;

  ExpenseSplit({
    required this.userId,
    required this.userName,
    required this.amount,
    this.percentage = 0.0,
  });

  ExpenseSplit copyWith({
    String? userId,
    String? userName,
    double? amount,
    double? percentage,
  }) {
    return ExpenseSplit(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      amount: amount ?? this.amount,
      percentage: percentage ?? this.percentage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'amount': amount,
      'percentage': percentage,
    };
  }

  factory ExpenseSplit.fromJson(Map<String, dynamic> json) {
    return ExpenseSplit(
      userId: json['userId'],
      userName: json['userName'],
      amount: json['amount'].toDouble(),
      percentage: json['percentage']?.toDouble() ?? 0.0,
    );
  }
}

class Expense {
  final String id;
  final String title;
  final String description;
  final double amount;
  final List<ExpensePayer> paidBy;
  final List<ExpenseSplit> splitBetween;
  final SplitType splitType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String category;
  final String? receipt;
  final String groupId;
  final String createdByUserId;

  Expense({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.paidBy,
    required this.splitBetween,
    required this.splitType,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    this.receipt,
    required this.groupId,
    required this.createdByUserId,
  });

  Expense copyWith({
    String? id,
    String? title,
    String? description,
    double? amount,
    List<ExpensePayer>? paidBy,
    List<ExpenseSplit>? splitBetween,
    SplitType? splitType,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? category,
    String? receipt,
    String? groupId,
    String? createdByUserId,
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      paidBy: paidBy ?? this.paidBy,
      splitBetween: splitBetween ?? this.splitBetween,
      splitType: splitType ?? this.splitType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
      receipt: receipt ?? this.receipt,
      groupId: groupId ?? this.groupId,
      createdByUserId: createdByUserId ?? this.createdByUserId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'paidBy': paidBy.map((x) => x.toJson()).toList(),
      'splitBetween': splitBetween.map((x) => x.toJson()).toList(),
      'splitType': splitType.toString(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'category': category,
      'receipt': receipt,
      'groupId': groupId,
      'createdByUserId': createdByUserId,
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      amount: json['amount'].toDouble(),
      paidBy: (json['paidBy'] as List)
          .map((x) => ExpensePayer.fromJson(x))
          .toList(),
      splitBetween: (json['splitBetween'] as List)
          .map((x) => ExpenseSplit.fromJson(x))
          .toList(),
      splitType: SplitType.values.firstWhere(
        (e) => e.toString() == json['splitType'],
        orElse: () => SplitType.equally,
      ),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      category: json['category'],
      receipt: json['receipt'],
      groupId: json['groupId'],
      createdByUserId: json['createdByUserId'],
    );
  }

  // Helper methods
  double get totalPaidAmount => paidBy.fold(0.0, (sum, payer) => sum + payer.amount);
  double get totalSplitAmount => splitBetween.fold(0.0, (sum, split) => sum + split.amount);
  
  bool get isBalanced => (totalPaidAmount - totalSplitAmount).abs() < 0.01;
  
  List<String> get payerNames => paidBy.map((p) => p.userName).toList();
  List<String> get splitMemberNames => splitBetween.map((s) => s.userName).toList();
}