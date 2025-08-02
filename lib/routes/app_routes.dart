// routes/app_routes.dart
import 'package:go_router/go_router.dart';
import 'package:splitxapp/view/screens/login/login_view.dart';
import 'package:splitxapp/view/screens/main/main_screen.dart';
import 'package:splitxapp/view/screens/signup/signup_view.dart';
import 'package:splitxapp/view/screens/splash/splash_view.dart';
import 'package:splitxapp/view/screens/group/group_main_view.dart';
import 'package:splitxapp/view/screens/expense/expense_view.dart';
import 'package:splitxapp/view/screens/expense/expense_list_view.dart';
import 'package:splitxapp/view/screens/expense/expense_detail_view.dart';

enum AppRoute {
  splash,
  signup,
  login,
  home,
  groupMain,
  groupExpenses,
  groupBalance,
  groupPayments,
  groupSettlement,
  groupTotals,
  expenseList,
  expenseAdd,
  expenseEdit,
  expenseDetail,
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
  GoRoute(
    path: '/group/:groupId',
    name: AppRoute.groupMain.name,
    builder: (context, state) {
      final groupId = state.pathParameters['groupId']!;
      final groupName = state.uri.queryParameters['groupName'] ?? 'Group';
      return GroupMainView(
        groupId: groupId,
        groupName: groupName,
      );
    },
    routes: [
      GoRoute(
        path: '/expenses',
        name: AppRoute.groupExpenses.name,
        builder: (context, state) {
          final groupId = state.pathParameters['groupId']!;
          final groupName = state.uri.queryParameters['groupName'] ?? 'Group';
          return GroupMainView(
            groupId: groupId,
            groupName: groupName,
            initialTab: 0,
          );
        },
      ),
      GoRoute(
        path: '/balance',
        name: AppRoute.groupBalance.name,
        builder: (context, state) {
          final groupId = state.pathParameters['groupId']!;
          final groupName = state.uri.queryParameters['groupName'] ?? 'Group';
          return GroupMainView(
            groupId: groupId,
            groupName: groupName,
            initialTab: 1,
          );
        },
      ),
      GoRoute(
        path: '/payments',
        name: AppRoute.groupPayments.name,
        builder: (context, state) {
          final groupId = state.pathParameters['groupId']!;
          final groupName = state.uri.queryParameters['groupName'] ?? 'Group';
          return GroupMainView(
            groupId: groupId,
            groupName: groupName,
            initialTab: 2,
          );
        },
      ),
      GoRoute(
        path: '/settlement',
        name: AppRoute.groupSettlement.name,
        builder: (context, state) {
          final groupId = state.pathParameters['groupId']!;
          final groupName = state.uri.queryParameters['groupName'] ?? 'Group';
          return GroupMainView(
            groupId: groupId,
            groupName: groupName,
            initialTab: 3,
          );
        },
      ),
      GoRoute(
        path: '/totals',
        name: AppRoute.groupTotals.name,
        builder: (context, state) {
          final groupId = state.pathParameters['groupId']!;
          final groupName = state.uri.queryParameters['groupName'] ?? 'Group';
          return GroupMainView(
            groupId: groupId,
            groupName: groupName,
            initialTab: 4,
          );
        },
      ),
    ],
  ),
  
  // Expense Routes
  GoRoute(
    path: '/expenses/:groupId',
    name: AppRoute.expenseList.name,
    builder: (context, state) {
      final groupId = state.pathParameters['groupId']!;
      return ExpenseListView(groupId: groupId);
    },
    routes: [
      GoRoute(
        path: '/add',
        name: AppRoute.expenseAdd.name,
        builder: (context, state) {
          final groupId = state.pathParameters['groupId']!;
          return ExpenseView(groupId: groupId);
        },
      ),
      GoRoute(
        path: '/edit/:expenseId',
        name: AppRoute.expenseEdit.name,
        builder: (context, state) {
          final groupId = state.pathParameters['groupId']!;
          final expenseId = state.pathParameters['expenseId']!;
          return ExpenseView(
            expenseId: expenseId,
            groupId: groupId,
          );
        },
      ),
      GoRoute(
        path: '/detail/:expenseId',
        name: AppRoute.expenseDetail.name,
        builder: (context, state) {
          final groupId = state.pathParameters['groupId']!;
          final expenseId = state.pathParameters['expenseId']!;
          return ExpenseDetailView(
            expenseId: expenseId,
            groupId: groupId,
          );
        },
      ),
    ],
  ),
];