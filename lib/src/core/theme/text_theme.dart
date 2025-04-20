import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppTextTheme {
  static TextTheme light = TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.onBackground,
    ),
    displayMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.onBackground,
    ),
    displaySmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.onBackground,
    ),
    headlineMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.onBackground,
    ),
    headlineSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.onBackground,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColors.onBackground,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: AppColors.onBackground),
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.onBackground),
    bodySmall: TextStyle(
      fontSize: 12,
      color: AppColors.onBackground.withOpacity(0.7),
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.primary,
    ),
  );

  static TextTheme dark = TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.onBackgroundDark,
    ),
    displayMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.onBackgroundDark,
    ),
    displaySmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.onBackgroundDark,
    ),
    headlineMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.onBackgroundDark,
    ),
    headlineSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.onBackgroundDark,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColors.onBackgroundDark,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: AppColors.onBackgroundDark),
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.onBackgroundDark),
    bodySmall: TextStyle(
      fontSize: 12,
      color: AppColors.onBackgroundDark.withOpacity(0.7),
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryDark,
    ),
  );
}
