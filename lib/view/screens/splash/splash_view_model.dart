import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:splitxapp/core/constants.dart';
import 'package:splitxapp/helpers/base_screen_view.dart';
import 'package:splitxapp/helpers/base_view_model.dart';
import 'package:splitxapp/routes/app_routes.dart';
import 'package:splitxapp/services/shared_preference_service.dart';
import 'package:splitxapp/utils/jwt_utils.dart';

final splashViewModel = ChangeNotifierProvider((ref) => SplashViewModel(ref));

class SplashViewModel extends BaseViewModel<BaseScreenView> {
   final Ref _ref;

  SplashViewModel(this._ref);

  Future<void> GoToHome(BuildContext context, WidgetRef ref) async {
  final token = SharedPreferenceService.getString(AppConstants.tokenPref);

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
