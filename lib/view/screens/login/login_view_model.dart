import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:splitxapp/core/exception.dart';
import 'package:splitxapp/data/auth/auth_repo.dart';
import 'package:splitxapp/data/auth/models/login/login_request_model.dart';
import 'package:splitxapp/data/auth/models/login/login_response_model.dart';
import 'package:splitxapp/utils/extensions.dart';
import 'package:splitxapp/domain/provider/repository_provider.dart';
import 'package:splitxapp/helpers/base_screen_view.dart';
import 'package:splitxapp/helpers/base_view_model.dart';
import 'package:splitxapp/routes/app_routes.dart';

final loginViewModel = ChangeNotifierProvider(
  (ref) => LoginViewModel(ref.read(authRepo)),
);

class LoginViewModel extends BaseViewModel<BaseScreenView> {
  final AuthRepo _authRepo;

  LoginViewModel(this._authRepo);

  Future<void> login(BuildContext context, LoginRequestModel req) async {
    try {
      toggleLoading();
      await Future.delayed(const Duration(seconds: 2));

      await _authRepo.login(req).then(
         (onValue) => onValue.fold( (left) async{
            view?.showSnackbar(left.message, color: Colors.red);            
         }, (right) async {
            view?.showSnackbar(right.message, color: Colors.green);
            context.pushReplacementNamed(AppRoute.home.name);
         }));

     /*  await _authRepo
          .login(req)
          .handle(
            onRight: (LoginResponseModel right) {
              view?.showSnackbar(right.message, color: Colors.green);
              context.pushReplacementNamed(AppRoute.home.name);
            },
            onLeft: (ApiException left) {
              view?.showSnackbar(left.message, color: Colors.red);
            },
          ); */

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
}
