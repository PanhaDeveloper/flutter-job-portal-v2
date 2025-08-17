import 'package:flutter/material.dart';
import 'package:job_app/cores/utils/constants/sizes.dart';
import '../../constants/colors.dart';

class CustomAppBarThemes {
  CustomAppBarThemes._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: AppColors.black, size: Sizes.iconMd),
    actionsIconTheme: IconThemeData(color: AppColors.black, size: Sizes.iconMd),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
      fontFamily: 'Poppins',
      fontFamilyFallback: ['KhmerOS'],
    ),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: AppColors.black, size: Sizes.iconMd),
    actionsIconTheme: IconThemeData(color: AppColors.white, size: Sizes.iconMd),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
      fontFamily: 'Poppins',
      fontFamilyFallback: ['KhmerOS'],
    ),
  );
}
