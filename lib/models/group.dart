import 'package:flutter/material.dart';

class Group {
  final String id;
  final String name;
  final int memberCount;
  final String totalExpense;
  final String yourShare;
  final Color color;

  Group({
    required this.id,
    required this.name,
    required this.memberCount,
    required this.totalExpense,
    required this.yourShare,
    required this.color,
  });
}