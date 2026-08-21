import 'package:flutter/material.dart';

class AppColors {
  // Modern dark theme
  static const Color background = Color(0xFF0F0F0F);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color surfaceLight = Color(0xFF2A2A2A);
  
  // Primary and accents
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color accent = Color(0xFFFB923C);
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  
  // Text colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA0A0A0);
  
  // Display
  static const Color displayBackground = Color(0xFF16213E);
  static const Color displayBorder = Color(0xFF6366F1);
}

class AppDimensions {
  static const double buttonPadding = 10.0;
  static const double containerPadding = 20.0;
  static const double borderRadius = 16.0;
  static const double displayBorderRadius = 24.0;
  static const double displayFontSize = 64.0;
  static const double operationFontSize = 18.0;
  static const double smallFontSize = 14.0;
  static const double buttonFontSize = 26.0;
  static const double buttonVerticalPadding = 28.0;
  static const double shadowBlur = 20.0;
  static const double shadowSpread = 2.0;
}

class AppStrings {
  static const String appTitle = 'Calculator';
  static const String clearButton = 'C';
  static const String equalsButton = '=';
  static const String decimalPoint = '.';
  static const String divideSymbol = '÷';
  static const String multiplySymbol = '×';
  static const String subtractSymbol = '-';
  static const String addSymbol = '+';
}
