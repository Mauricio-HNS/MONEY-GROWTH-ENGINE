import 'package:flutter/material.dart';

abstract final class AppColors {
  static const white = Color(0xFFF9F9F9);
  static const red = Color(0xFFE50914);
  static const redDark = Color(0xFF7A0510);
  static const black = Color(0xFF1A0508);
  static const surface = Color(0xFF241012);
  static const surfaceSoft = Color(0xFF32161A);
  static const text = white;
  static const textMuted = Color(0xFFB9AEB0);
  static const border = Color(0xFF4A292D);
  static const accent = red;
  static const success = Color(0xFF65D98B);
}

abstract final class AppStyle {
  static ThemeData theme() {
    final scheme = ColorScheme.fromSeed(seedColor: AppColors.red, brightness: Brightness.dark).copyWith(
      primary: AppColors.red,
      secondary: AppColors.white,
      surface: AppColors.surface,
      onSurface: AppColors.white,
    );
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.black,
      colorScheme: scheme,
      fontFamily: 'Inter',
      splashFactory: InkSparkle.splashFactory,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: AppColors.white, letterSpacing: -1.5),
        headlineMedium: TextStyle(fontSize: 27, fontWeight: FontWeight.w900, color: AppColors.white, letterSpacing: -1),
        titleLarge: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: AppColors.white, letterSpacing: -.3),
        titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.white),
        bodyLarge: TextStyle(fontSize: 15, color: AppColors.textMuted, height: 1.5),
        bodyMedium: TextStyle(fontSize: 13, color: AppColors.textMuted, height: 1.45),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.white, letterSpacing: -.5),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        labelStyle: const TextStyle(color: AppColors.textMuted),
        hintStyle: const TextStyle(color: AppColors.textMuted),
        prefixIconColor: AppColors.textMuted,
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide(color: AppColors.border)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide(color: AppColors.border)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide(color: AppColors.red, width: 1.5)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.red,
          foregroundColor: AppColors.white,
          minimumSize: const Size(0, 54),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: .2),
        ),
      ),
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: AppColors.white, textStyle: const TextStyle(fontWeight: FontWeight.w800))),
      sliderTheme: const SliderThemeData(activeTrackColor: AppColors.red, thumbColor: AppColors.white, inactiveTrackColor: AppColors.border),
      dividerTheme: const DividerThemeData(color: AppColors.border),
      snackBarTheme: SnackBarThemeData(backgroundColor: AppColors.surfaceSoft, contentTextStyle: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w700), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), behavior: SnackBarBehavior.floating),
    );
  }
}
