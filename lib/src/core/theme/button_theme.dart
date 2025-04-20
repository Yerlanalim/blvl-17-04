import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';

class AppButtonThemes {
  static final elevatedLight = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
    minimumSize: Size.fromHeight(AppSizes.buttonHeight),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusM),
    ),
    textStyle: const TextStyle(fontWeight: FontWeight.w600),
  );

  static final elevatedDark = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryDark,
    foregroundColor: AppColors.onPrimaryDark,
    minimumSize: Size.fromHeight(AppSizes.buttonHeight),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusM),
    ),
    textStyle: const TextStyle(fontWeight: FontWeight.w600),
  );

  static final outlinedLight = OutlinedButton.styleFrom(
    foregroundColor: AppColors.primary,
    side: const BorderSide(color: AppColors.primary),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusM),
    ),
  );

  static final outlinedDark = OutlinedButton.styleFrom(
    foregroundColor: AppColors.primaryDark,
    side: const BorderSide(color: AppColors.primaryDark),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusM),
    ),
  );

  static final textLight = TextButton.styleFrom(
    foregroundColor: AppColors.primary,
    textStyle: const TextStyle(fontWeight: FontWeight.w500),
  );

  static final textDark = TextButton.styleFrom(
    foregroundColor: AppColors.primaryDark,
    textStyle: const TextStyle(fontWeight: FontWeight.w500),
  );
}
