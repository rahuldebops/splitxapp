import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitxapp/models/user_model.dart';

final userSessionProvider = StateNotifierProvider<UserSessionNotifier, UserModel?>(
  (ref) => UserSessionNotifier(),
);

class UserSessionNotifier extends StateNotifier<UserModel?> {
  UserSessionNotifier() : super(null);

  void setUser(UserModel user) => state = user;
  void clear() => state = null;
}
