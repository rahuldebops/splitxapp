import 'package:go_router/go_router.dart';
import 'package:splitxapp/view/screens/groups/groups_view.dart';
import 'package:splitxapp/view/screens/login/login_view.dart';
import 'package:splitxapp/view/screens/main/main_screen.dart';
import 'package:splitxapp/view/screens/signup/signup_view.dart';
import 'package:splitxapp/view/screens/splash/splash_view.dart';

enum AppRoute {
  splash,
  signup,
  login,
  home,
}

// flutter packages pub run build_runner build --delete-conflicting-outputs
final routers = [
  GoRoute(
    path: '/',
    name: AppRoute.splash.name,
    builder: (context, state) => const SplashView(),
  ),
  GoRoute(
    path: '/signup',
    name: AppRoute.signup.name,
    builder: (context, state) => const SignupView(),
  ),
  GoRoute(
    path: '/login',
    name: AppRoute.login.name,
    builder: (context, state) => const LoginView(),
  ),
  GoRoute(
    path: '/home',
    name: AppRoute.home.name,
    builder: (context, state) => const MainScreen(),
  ),
];
