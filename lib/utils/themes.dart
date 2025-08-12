// ignore_for_file: unused_field, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:splitxapp/utils/colors.dart';

class AppThemes {
  AppThemes._();

  static String font1 = "Inter";
  static String font2 = "Inter";

  // Light Theme Colors
  static const Color _lightPrimaryColor = kPrimaryColor;
  static const Color _lightBackgroundColor = kBackground;
  static const Color _lightBackgroundAppBarColor = kSurface;
  static const Color _lightBackgroundSecondaryColor = kSurface;
  static const Color _lightBackgroundAlertColor = kTextPrimary;
  static const Color _lightBackgroundActionTextColor = kWhite;
  static const Color _lightBackgroundErrorColor = kError;
  static const Color _lightBackgroundSuccessColor = kSuccess;

  // Light Text Colors
  static const Color _lightTextColor = kTextPrimary;
  static const Color _lightAlertTextColor = kTextPrimary;
  static const Color _lightTextSecondaryColor = kTextSecondary;

  // Light Border and Icon Colors
  static const Color _lightBorderColor = kBorder;
  static const Color _lightIconColor = kTextSecondary;

  // Light Form Input Colors
  static const Color _lightInputFillColor = kInputBackground;
  static const Color _lightBorderActiveColor = kInputFocused;
  static const Color _lightBorderErrorColor = kError;

  // Dark Theme Colors
  static const Color _darkPrimaryColor = kPrimaryColor;
  static const Color _darkBackgroundColor = Color(0xFF0F172A); // Slate-900
  static const Color _darkBackgroundAppBarColor = Color(
    0xFF1E293B,
  ); // Slate-800
  static const Color _darkBackgroundSecondaryColor = Color(
    0xFF334155,
  ); // Slate-700
  static const Color _darkBackgroundAlertColor = Color(0xFF1E293B);
  static const Color _darkBackgroundActionTextColor = kWhite;
  static const Color _darkBackgroundErrorColor = kError;
  static const Color _darkBackgroundSuccessColor = kSuccess;

  // Dark Text Colors
  static const Color _darkTextColor = Color(0xFFF8FAFC); // Slate-50
  static const Color _darkAlertTextColor = Color(0xFFF8FAFC);
  static const Color _darkTextSecondaryColor = Color(0xFFCBD5E1); // Slate-300

  // Dark Border and Icon Colors
  static const Color _darkBorderColor = Color(0xFF475569); // Slate-600
  static const Color _darkIconColor = Color(0xFF94A3B8); // Slate-400

  // Dark Form Input Colors
  static const Color _darkInputFillColor = Color(0xFF334155); // Slate-700
  static const Color _darkBorderActiveColor = kInputFocused;
  static const Color _darkBorderErrorColor = kError;

  // Light Text Theme
  static const TextTheme _lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 20.0,
      color: _lightTextColor,
      fontFamily: "Inter",
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.0,
      color: _lightTextColor,
      fontFamily: "Inter",
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      color: kTextSecondary,
      fontFamily: "Inter",
    ),
    displaySmall: TextStyle(
      fontSize: 16,
      color: _lightTextColor,
      fontFamily: "Inter",
    ),
    labelLarge: TextStyle(
      fontSize: 15.0,
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontFamily: "Inter",
    ),
    titleLarge: TextStyle(
      fontSize: 16.0,
      color: _lightTextColor,
      fontFamily: "Inter",
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      fontSize: 16.0,
      color: _lightTextColor,
      fontFamily: "Inter",
    ),
    bodySmall: TextStyle(
      fontSize: 12.0,
      color: kTextMuted,
      fontFamily: "Inter",
    ),
  );

  // Dark Text Theme
  static const TextTheme _darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 20.0,
      color: _darkTextColor,
      fontFamily: "Inter",
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.0,
      color: _darkTextColor,
      fontFamily: "Inter",
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      color: _darkTextSecondaryColor,
      fontFamily: "Inter",
    ),
    displaySmall: TextStyle(
      fontSize: 16,
      color: _darkTextColor,
      fontFamily: "Inter",
    ),
    labelLarge: TextStyle(
      fontSize: 15.0,
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontFamily: "Inter",
    ),
    titleLarge: TextStyle(
      fontSize: 16.0,
      color: _darkTextColor,
      fontFamily: "Inter",
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      fontSize: 16.0,
      color: _darkTextColor,
      fontFamily: "Inter",
    ),
    bodySmall: TextStyle(
      fontSize: 12.0,
      color: _darkIconColor,
      fontFamily: "Inter",
    ),
  );

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    canvasColor: kSurface,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    fontFamily: "Inter",
    scaffoldBackgroundColor: _lightBackgroundColor,

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _lightPrimaryColor,
      foregroundColor: kWhite,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: _lightBackgroundAppBarColor,
      foregroundColor: _lightTextColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: _lightTextColor),
      toolbarTextStyle: _lightTextTheme.bodyMedium,
      titleTextStyle: _lightTextTheme.titleLarge,
    ),

    colorScheme: const ColorScheme.light(
      primary: _lightPrimaryColor,
      primaryContainer: kPrimaryLight,
      secondary: kSecondary,
      secondaryContainer: kSecondaryDark,
      surface: kSurface,
      background: _lightBackgroundColor,
      error: kError,
      onPrimary: kWhite,
      onSecondary: kWhite,
      onSurface: _lightTextColor,
      onBackground: _lightTextColor,
      onError: kWhite,
      outline: _lightBorderColor,
      outlineVariant: kDivider,
    ),

    snackBarTheme: const SnackBarThemeData(
      backgroundColor: _lightBackgroundAlertColor,
      contentTextStyle: TextStyle(color: kWhite),
      actionTextColor: _lightBackgroundActionTextColor,
    ),

    iconTheme: const IconThemeData(color: _lightIconColor),

    cardTheme: const CardThemeData(
      // Changed from CardTheme to CardThemeData
      color: kCardBackground,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),

    dividerTheme: const DividerThemeData(color: kDivider, thickness: 1),

    textTheme: _lightTextTheme,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _lightPrimaryColor,
        foregroundColor: kWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _lightPrimaryColor,
        side: const BorderSide(color: _lightBorderColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: _lightInputFillColor,
      labelStyle: TextStyle(color: kTextSecondary),
      hintStyle: TextStyle(color: kTextMuted),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: kInputBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kInputBorder),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBorderActiveColor, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBorderErrorColor, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    ),

    bottomAppBarTheme: const BottomAppBarTheme(color: kSurface, elevation: 8),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    canvasColor: _darkBackgroundColor,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    fontFamily: "Inter",
    scaffoldBackgroundColor: _darkBackgroundColor,

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _darkPrimaryColor,
      foregroundColor: kWhite,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: _darkBackgroundAppBarColor,
      foregroundColor: _darkTextColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: _darkTextColor),
      toolbarTextStyle: _darkTextTheme.bodyMedium,
      titleTextStyle: _darkTextTheme.titleLarge,
    ),

    colorScheme: const ColorScheme.dark(
      primary: _darkPrimaryColor,
      primaryContainer: kPrimaryDark,
      secondary: kSecondary,
      secondaryContainer: kSecondaryDark,
      surface: _darkBackgroundAppBarColor,
      background: _darkBackgroundColor,
      error: kError,
      onPrimary: kWhite,
      onSecondary: kWhite,
      onSurface: _darkTextColor,
      onBackground: _darkTextColor,
      onError: kWhite,
      outline: _darkBorderColor,
      outlineVariant: Color(0xFF64748B), // Slate-500
    ),

    snackBarTheme: const SnackBarThemeData(
      backgroundColor: _darkBackgroundAlertColor,
      contentTextStyle: TextStyle(color: _darkTextColor),
      actionTextColor: _darkBackgroundActionTextColor,
    ),

    iconTheme: const IconThemeData(color: _darkIconColor),

    cardTheme: const CardThemeData(
      // Changed from CardTheme to CardThemeData
      color: _darkBackgroundAppBarColor,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),

    dividerTheme: const DividerThemeData(color: _darkBorderColor, thickness: 1),

    textTheme: _darkTextTheme,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _darkPrimaryColor,
        foregroundColor: kWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _darkPrimaryColor,
        side: const BorderSide(color: _darkBorderColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: _darkInputFillColor,
      labelStyle: TextStyle(color: _darkTextSecondaryColor),
      hintStyle: TextStyle(color: _darkIconColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: _darkBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderActiveColor, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderErrorColor, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    ),

    bottomAppBarTheme: const BottomAppBarTheme(
      color: _darkBackgroundAppBarColor,
      elevation: 8,
    ),
  );
}
