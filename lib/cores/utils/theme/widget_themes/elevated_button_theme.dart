import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Elevated Button Themes -- */
class CustomElevatedButtonTheme {
  CustomElevatedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.light,
      backgroundColor: AppColors.primary,
      disabledForegroundColor: AppColors.darkGrey,
      disabledBackgroundColor: AppColors.buttonDisabled,
      padding: const EdgeInsets.symmetric(vertical: Sizes.buttonHeight),
      textStyle: const TextStyle(
        fontSize: 16,
        color: AppColors.textWhite,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
        fontFamilyFallback: ['KhmerOS'],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.buttonRadius),
      ),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.light,
      // backgroundColor: AppColors.primary,
      disabledForegroundColor: AppColors.darkGrey,
      disabledBackgroundColor: AppColors.darkerGrey,
      padding: const EdgeInsets.symmetric(vertical: Sizes.buttonHeight),
      textStyle: const TextStyle(
        fontSize: 16,
        color: AppColors.textWhite,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
        fontFamilyFallback: ['KhmerOS'],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.buttonRadius),
      ),
    ),
  );
}
