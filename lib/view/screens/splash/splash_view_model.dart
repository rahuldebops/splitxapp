import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:splitxapp/helpers/base_screen_view.dart';
import 'package:splitxapp/helpers/base_view_model.dart';
import 'package:splitxapp/routes/app_routes.dart';

final splashViewModel = ChangeNotifierProvider((ref) => SplashViewModel());

class SplashViewModel extends BaseViewModel<BaseScreenView> {

  void showSnackbar(String message) {
    view?.showSnackbar("wohooo!!!!");
  }

  Future<void> GoToHome(BuildContext context) async {
    context.pushReplacementNamed(AppRoute.signup.name);
  }
}
