import 'package:flutter/material.dart';
import 'package:quiz_app/cores/utils/theme/widget_themes/appbar_theme.dart';
import 'package:quiz_app/cores/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:quiz_app/cores/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:quiz_app/cores/utils/theme/widget_themes/chip_theme.dart';
import 'package:quiz_app/cores/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:quiz_app/cores/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:quiz_app/cores/utils/theme/widget_themes/text_field_theme.dart';
import 'package:quiz_app/cores/utils/theme/widget_themes/text_theme.dart';

import '../constants/colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    disabledColor: AppColors.grey,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    textTheme: CustomTextTheme.lightTextTheme,
    chipTheme: CustomChipTheme.lightChipTheme,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: CustomAppBarThemes.lightAppBarTheme,
    checkboxTheme: CustomCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: CustomBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: CustomTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    disabledColor: AppColors.grey,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    textTheme: CustomTextTheme.darkTextTheme,
    chipTheme: CustomChipTheme.darkChipTheme,
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: CustomAppBarThemes.darkAppBarTheme,
    checkboxTheme: CustomCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: CustomBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: CustomTextFormFieldTheme.darkInputDecorationTheme,
  );
}
