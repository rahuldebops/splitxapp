// models/group_member.dart
import 'package:flutter/material.dart';

class GroupMember {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final Color color;
  final bool isCurrentUser;

  GroupMember({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    required this.color,
    this.isCurrentUser = false,
  });

  GroupMember copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    Color? color,
    bool? isCurrentUser,
  }) {
    return GroupMember(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      color: color ?? this.color,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'color': color.value,
      'isCurrentUser': isCurrentUser,
    };
  }

  factory GroupMember.fromJson(Map<String, dynamic> json) {
    return GroupMember(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      color: Color(json['color']),
      isCurrentUser: json['isCurrentUser'] ?? false,
    );
  }

  String get initials {
    final names = name.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    } else if (names.isNotEmpty) {
      return names[0].substring(0, names[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return 'U';
  }
}