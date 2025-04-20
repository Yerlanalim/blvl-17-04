import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'text_theme.dart';
import 'button_theme.dart';
import 'input_theme.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      background: AppColors.background,
      onBackground: AppColors.onBackground,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      error: AppColors.error,
      onError: AppColors.onError,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: AppTextTheme.light,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppButtonThemes.elevatedLight,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: AppButtonThemes.outlinedLight,
    ),
    textButtonTheme: TextButtonThemeData(style: AppButtonThemes.textLight),
    inputDecorationTheme: AppInputThemes.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.onSurface,
      elevation: 0,
      centerTitle: true,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark,
      onPrimary: AppColors.onPrimaryDark,
      secondary: AppColors.secondaryDark,
      onSecondary: AppColors.onSecondaryDark,
      background: AppColors.backgroundDark,
      onBackground: AppColors.onBackgroundDark,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.onSurfaceDark,
      error: AppColors.errorDark,
      onError: AppColors.onErrorDark,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    textTheme: AppTextTheme.dark,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppButtonThemes.elevatedDark,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: AppButtonThemes.outlinedDark,
    ),
    textButtonTheme: TextButtonThemeData(style: AppButtonThemes.textDark),
    inputDecorationTheme: AppInputThemes.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surfaceDark,
      foregroundColor: AppColors.onSurfaceDark,
      elevation: 0,
      centerTitle: true,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
