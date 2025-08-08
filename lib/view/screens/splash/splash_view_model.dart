import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:splitxapp/helpers/base_screen_view.dart';
import 'package:splitxapp/helpers/base_view_model.dart';
import 'package:splitxapp/routes/app_routes.dart';
import 'package:splitxapp/services/token_manager.dart';
import 'package:splitxapp/utils/jwt_utils.dart';

final splashViewModel = ChangeNotifierProvider((ref) => SplashViewModel(ref));

class SplashViewModel extends BaseViewModel<BaseScreenView> {
  final Ref _ref;

  SplashViewModel(this._ref);

  Future<void> GoToHome(BuildContext context, WidgetRef ref) async {
    final tokenManager = ref.read(tokenManagerProvider);
    final token = await tokenManager.getToken();
    if (token != null && token.isNotEmpty) {
      final isValid = await decodeAndSetUserFromToken(token: token, ref: _ref);
      if (isValid) {
        context.pushReplacementNamed(AppRoute.home.name);
        return;
      }
    }
    context.pushReplacementNamed(AppRoute.login.name);
  }
}
