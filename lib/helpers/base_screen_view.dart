import 'package:flutter/material.dart';
import 'package:splitxapp/routes/app_routes.dart';

mixin BaseScreenView {
  void showSnackbar(String message, {Color? color});
  void navigateToScreen(AppRoute appRoute, {Map<String, String>? params});
  void navigateToScreenAsFirst(AppRoute appRoute, {Map<String, String>? params});
}
