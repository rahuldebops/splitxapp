import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitxapp/core/constants.dart';
import 'package:splitxapp/data/auth/auth_repo.dart';
import 'package:splitxapp/data/auth/models/login/login_request_model.dart';
import 'package:splitxapp/domain/provider/user_session_provider.dart';
import 'package:splitxapp/domain/provider/repository_provider.dart';
import 'package:splitxapp/helpers/base_screen_view.dart';
import 'package:splitxapp/helpers/base_view_model.dart';
import 'package:splitxapp/routes/app_routes.dart';
import 'package:splitxapp/utils/jwt_utils.dart';

final loginViewModel = ChangeNotifierProvider(
  (ref) => LoginViewModel(ref.read(authRepo), ref),
);

class LoginViewModel extends BaseViewModel<BaseScreenView> {
  final AuthRepo _authRepo;
  final Ref _ref;

  LoginViewModel(this._authRepo, this._ref);
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> login(BuildContext context, LoginRequestModel req) async {
    try {
      toggleLoading();
      await Future.delayed(const Duration(seconds: 2));

      await _authRepo
          .login(req)
          .then(
            (onValue) => onValue.fold(
              (left) async {
                view?.showSnackbar(left.message, color: Colors.red);
              },
              (right) async {
                final SharedPreferences prefs = await _prefs;
                String token = right.result.accessToken;

                prefs.setString(AppConstants.tokenPref, token);
                if (token.isNotEmpty) {
                  final isValid = await decodeAndSetUserFromToken(
                    token: token,
                    ref: _ref,
                  );
                  if (isValid) {
                    notifyListeners();
                    view?.showSnackbar(right.message, color: Colors.green);
                    context.pushReplacementNamed(AppRoute.home.name);
                  }
                }
              },
            ),
          );
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      // Handle login error
      errorMessage = "Invalid email or password. Please try again.";
      view?.showSnackbar(errorMessage!, color: Colors.red);
    } finally {
      toggleLoading();
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      toggleLoading();

      // Simulate Google login delay
    } catch (e) {
      errorMessage = "Google sign-in failed. Please try again.";
      view?.showSnackbar(errorMessage!, color: Colors.red);
    } finally {
      toggleLoading();
    }
  }

  Future<void> loginWithApple(BuildContext context) async {
    try {
      toggleLoading();

      // Simulate Apple login delay
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Implement Apple login logic
      // Example: await authService.loginWithApple();

      view?.showSnackbar("Signed in with Apple!", color: Colors.green);

      await Future.delayed(const Duration(milliseconds: 500));
      // context.pushReplacementNamed(AppRoute.home.name);
    } catch (e) {
      errorMessage = "Apple sign-in failed. Please try again.";
      view?.showSnackbar(errorMessage!, color: Colors.red);
    } finally {
      toggleLoading();
    }
  }

  void navigateToSignup(BuildContext context) {
    context.pushNamed(AppRoute.signup.name);
  }

  void navigateToForgotPassword(BuildContext context) {
    // TODO: Navigate to forgot password screen
    // context.pushNamed(AppRoute.forgotPassword.name);
    view?.showSnackbar("Forgot password feature coming soon!");
  }

  Future<void> logout(BuildContext context) async {
    try {
      // 1. Clear token from local storage
      final SharedPreferences prefs = await _prefs;
      await prefs.remove(AppConstants.tokenPref);
      AppConstants.token = "";

      // 2. Clear in-memory user session
      _ref.read(userSessionProvider.notifier).clear();

      // 3. Navigate to login screen
      context.goNamed(AppRoute.login.name);

      // 4. Optional: Show snackbar
      view?.showSnackbar("Logged out successfully.", color: Colors.green);
    } catch (e) {
      view?.showSnackbar("Logout failed. Please try again.", color: Colors.red);
    }
  }
}
