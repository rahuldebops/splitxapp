import 'package:flutter/material.dart';

//constants color range for theme - Updated with no opacity
const Color kPrimaryColor = Color(0xFF2563EB); // Blue-600
const Color kPrimaryDark = Color(0xFF1D4ED8); // Blue-700
const Color kPrimaryLight = Color(0xFF3B82F6); // Blue-500
const Color kSecondary = Color(0xFF10B981); // Emerald-500
const Color kSecondaryDark = Color(0xFF059669); // Emerald-600
const Color kAccent = Color(0xFFF59E0B); // Amber-500
const Color kAccentLight = Color(0xFFFBBF24); // Amber-400

const Color kSuccess = Color(0xFF10B981); // Emerald-500
const Color kWarning = Color(0xFFF59E0B); // Amber-500
const Color kError = Color(0xFFEF4444); // Red-500
const Color kInfo = Color(0xFF3B82F6); // Blue-500

const Color kSurface = Color(0xFFFFFFFF); // White
const Color kBackground = Color(0xFFF8FAFC); // Slate-50
const Color kCardBackground = Color(0xFFFFFFFF); // White
const Color kBorder = Color(0xFFE2E8F0); // Slate-200
const Color kDivider = Color(0xFFCBD5E1); // Slate-300

const Color kTextPrimary = Color(0xFF0F172A); // Slate-900
const Color kTextSecondary = Color(0xFF475569); // Slate-600
const Color kTextMuted = Color(0xFF94A3B8); // Slate-400
const Color kTextDisabled = Color(0xFFCBD5E1); // Slate-300

const Color kInputBackground = Color(0xFFF8FAFC); // Slate-50
const Color kInputBorder = Color(0xFFD1D5DB); // Gray-300
const Color kInputFocused = Color(0xFF2563EB); // Blue-600

// Legacy colors for compatibility
const Color kButtonColor = kPrimaryColor;
const Color kbuttonTextColor = Colors.white;
const Color formBgColor = kInputBackground;
const Color kWhite = Colors.white;
const Color kBlack = Colors.black;
const Color kGrey = Color(0xFF6B7280); // Gray-500

// Gradient colors
LinearGradient get primaryGradient => const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [kPrimaryColor, kPrimaryDark],
);

LinearGradient get successGradient => const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [kSuccess, kSecondaryDark],
);

LinearGradient get warningGradient => const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [kWarning, kAccent],
);

// Status colors for balance validation
const Color kBalanced = Color(0xFF10B981); // Emerald-500
const Color kImbalanced = Color(0xFFEF4444); // Red-500
const Color kPending = Color(0xFFF59E0B); // Amber-500