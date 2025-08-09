// signup_view_model.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:splitxapp/core/exception.dart';
import 'package:splitxapp/data/auth/auth_repo.dart';
import 'package:splitxapp/data/auth/models/register/register_request_model.dart';
import 'package:splitxapp/data/auth/models/register/register_response_model.dart';
import 'package:splitxapp/domain/provider/repository_provider.dart';
import 'package:splitxapp/helpers/base_screen_view.dart';
import 'package:splitxapp/helpers/base_view_model.dart';
import 'package:splitxapp/routes/app_routes.dart';
import 'package:splitxapp/services/token_manager.dart';
import 'package:splitxapp/utils/extensions.dart';

final signupViewModel = ChangeNotifierProvider(
  (ref) => SignupViewModel(ref.read(authRepo), ref),
);

class SignupViewModel extends BaseViewModel<BaseScreenView> {
  final AuthRepo _authRepo;
  final Ref _ref;

  SignupViewModel(this._authRepo, this._ref);

  Future<void> signup(BuildContext context, RegisterRequestModel req) async {
    try {
      toggleLoading();

      await Future.delayed(const Duration(seconds: 2));

      await _authRepo
          .register(req)
          .handle(
            onRight: (RegisterResponseModel right) async {
              final tokenManager = _ref.read(tokenManagerProvider);
              await tokenManager.saveTokens(right.result.accessToken, right.result.refreshToken);
              notifyListeners();
              
              view?.showSnackbar(right.message, color: Colors.green);
              context.pushReplacementNamed(AppRoute.home.name);
            },
            onLeft: (ApiException left) {
              view?.showSnackbar(left.message, color: Colors.red);
            },
          );

      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      // Handle signup error
      errorMessage = "Failed to create account. Please try again.";
      view?.showSnackbar(errorMessage!, color: Colors.red);
    } finally {
      toggleLoading();
    }
  }

  void navigateToLogin(BuildContext context) {
    context.pushReplacementNamed(AppRoute.login.name);
  }

  void showTermsOfService() {
    // TODO: Navigate to terms of service screen
  }

  void showPrivacyPolicy() {
    // TODO: Navigate to privacy policy screen
  }
}
