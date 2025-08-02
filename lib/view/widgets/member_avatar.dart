// view/widgets/member_avatar.dart
import 'package:flutter/material.dart';
import 'package:splitxapp/models/group_member.dart';

class MemberAvatar extends StatelessWidget {
  final GroupMember member;
  final double size;
  final bool showBorder;

  const MemberAvatar({
    Key? key,
    required this.member,
    this.size = 40,
    this.showBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: member.color.withOpacity(0.1),
        border: showBorder
            ? Border.all(color: member.color, width: 2)
            : null,
      ),
      child: member.avatar != null
          ? ClipOval(
              child: Image.network(
                member.avatar!,
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildInitialsAvatar();
                },
              ),
            )
          : _buildInitialsAvatar(),
    );
  }

  Widget _buildInitialsAvatar() {
    return Center(
      child: Text(
        member.initials,
        style: TextStyle(
          color: member.color,
          fontSize: size * 0.4,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}