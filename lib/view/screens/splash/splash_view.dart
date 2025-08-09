// view/screens/splash/splash_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:splitxapp/routes/app_routes.dart';
import 'package:splitxapp/services/token_service.dart';
import 'package:splitxapp/services/token_manager.dart';
import 'package:splitxapp/utils/colors.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final tokenManager = ref.read(tokenManagerProvider);

    await Future.delayed(const Duration(milliseconds: 800));

    final accessToken = await tokenManager.getToken();
    final refreshToken = await TokenService.getRefreshToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      context.goNamed(AppRoute.home.name);
    } else if (refreshToken != null && refreshToken.isNotEmpty) {
      final refreshed = await tokenManager.refreshToken();
      if (refreshed) {
        context.goNamed(AppRoute.home.name);
      } else {
        context.goNamed(AppRoute.login.name);
      }
    } else {
      context.goNamed(AppRoute.login.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite, // match your theme
      body: Center(
        child: Image.asset(
          'assets/images/splash.gif', // put your splash logo here
          width: 180,
        ),
      ),
    );
  }
}
