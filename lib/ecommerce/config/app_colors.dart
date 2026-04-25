import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFFF4D5E);
  static const Color primaryLight = Color(0xFFFFE5E7);
  static const Color primaryDark = Color(0xFFE63946);

  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF8F8F8);
  static const Color card = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  static const Color border = Color(0xFFEDEDED);
  static const Color divider = Color(0xFFF0F0F0);
  static const Color shadow = Color(0x14000000);

  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFFFB020);
  static const Color error = Color(0xFFEF4444);
  static const Color star = Color(0xFFFFB800);

  static const Color chipBg = Color(0xFFF5F5F5);

  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFF6B7A), Color(0xFFFF4D5E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
