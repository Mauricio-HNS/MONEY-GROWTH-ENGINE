import 'package:flutter/material.dart';

abstract final class AppColors {
  static const white = Color(0xFFF9FAFB);
  static const coldBlue = Color(0xFF7DE2DF);
  static const laguna = Color(0xFF35ACBE);
  static const darkKnight = Color(0xFF1A1D2E);

  static const background = darkKnight;
  static const surface = Color(0xFF22263A);
  static const surfaceSoft = Color(0xFF292E45);
  static const text = white;
  static const textMuted = Color(0xFFA8B0C3);
  static const border = Color(0xFF343A54);
}

abstract final class AppStyle {
  static ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.laguna,
        brightness: Brightness.dark,
        primary: AppColors.coldBlue,
        secondary: AppColors.laguna,
        surface: AppColors.surface,
      ),
      fontFamily: 'Inter',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: AppColors.white),
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.white),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.white),
        bodyLarge: TextStyle(fontSize: 15, color: AppColors.textMuted),
        bodyMedium: TextStyle(fontSize: 13, color: AppColors.textMuted),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: AppColors.coldBlue, width: 1.5),
        ),
      ),
    );
  }
}
