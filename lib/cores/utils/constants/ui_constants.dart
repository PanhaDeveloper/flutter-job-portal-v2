import 'package:flutter/material.dart';
import 'package:job_app/cores/utils/constants/colors.dart';

/// UI constants for commonly used const widgets and values
/// This helps with const optimization and reduces memory usage
class UIConstants {
  // Private constructor to prevent instantiation
  UIConstants._();

  // ========== SizedBox Constants ==========
  static const SizedBox sizedBoxHeight2 = SizedBox(height: 2);
  static const SizedBox sizedBoxHeight4 = SizedBox(height: 4);
  static const SizedBox sizedBoxHeight8 = SizedBox(height: 8);
  static const SizedBox sizedBoxHeight10 = SizedBox(height: 10);
  static const SizedBox sizedBoxHeight12 = SizedBox(height: 12);
  static const SizedBox sizedBoxHeight16 = SizedBox(height: 16);
  static const SizedBox sizedBoxHeight20 = SizedBox(height: 20);
  static const SizedBox sizedBoxHeight24 = SizedBox(height: 24);
  static const SizedBox sizedBoxHeight32 = SizedBox(height: 32);

  static const SizedBox sizedBoxWidth4 = SizedBox(width: 4);
  static const SizedBox sizedBoxWidth8 = SizedBox(width: 8);
  static const SizedBox sizedBoxWidth10 = SizedBox(width: 10);
  static const SizedBox sizedBoxWidth12 = SizedBox(width: 12);
  static const SizedBox sizedBoxWidth16 = SizedBox(width: 16);
  static const SizedBox sizedBoxWidth20 = SizedBox(width: 20);
  static const SizedBox sizedBoxWidth24 = SizedBox(width: 24);

  // ========== EdgeInsets Constants ==========
  static const EdgeInsets paddingAll4 = EdgeInsets.all(4);
  static const EdgeInsets paddingAll8 = EdgeInsets.all(8);
  static const EdgeInsets paddingAll12 = EdgeInsets.all(12);
  static const EdgeInsets paddingAll16 = EdgeInsets.all(16);
  static const EdgeInsets paddingAll20 = EdgeInsets.all(20);
  static const EdgeInsets paddingAll24 = EdgeInsets.all(24);

  static const EdgeInsets paddingH8 = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets paddingH12 = EdgeInsets.symmetric(horizontal: 12);
  static const EdgeInsets paddingH16 = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets paddingH20 = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets paddingH24 = EdgeInsets.symmetric(horizontal: 24);

  static const EdgeInsets paddingV8 = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets paddingV12 = EdgeInsets.symmetric(vertical: 12);
  static const EdgeInsets paddingV16 = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets paddingV18 = EdgeInsets.symmetric(vertical: 18);
  static const EdgeInsets paddingV20 = EdgeInsets.symmetric(vertical: 20);

  static const EdgeInsets paddingSymmetricV8H16 = EdgeInsets.symmetric(vertical: 8, horizontal: 16);
  static const EdgeInsets paddingSymmetricV12H16 = EdgeInsets.symmetric(vertical: 12, horizontal: 16);
  static const EdgeInsets paddingSymmetricV16H20 = EdgeInsets.symmetric(vertical: 16, horizontal: 20);

  // ========== BorderRadius Constants ==========
  static const BorderRadius borderRadius4 = BorderRadius.all(Radius.circular(4));
  static const BorderRadius borderRadius8 = BorderRadius.all(Radius.circular(8));
  static const BorderRadius borderRadius10 = BorderRadius.all(Radius.circular(10));
  static const BorderRadius borderRadius12 = BorderRadius.all(Radius.circular(12));
  static const BorderRadius borderRadius15 = BorderRadius.all(Radius.circular(15));
  static const BorderRadius borderRadius16 = BorderRadius.all(Radius.circular(16));
  static const BorderRadius borderRadius20 = BorderRadius.all(Radius.circular(20));
  static const BorderRadius borderRadius24 = BorderRadius.all(Radius.circular(24));
  static const BorderRadius borderRadius25 = BorderRadius.all(Radius.circular(25));
  static const BorderRadius borderRadius30 = BorderRadius.all(Radius.circular(30));
  static const BorderRadius borderRadius50 = BorderRadius.all(Radius.circular(50));

  // ========== TextStyle Constants ==========
  static const TextStyle textStyle12 = TextStyle(fontSize: 12);
  static const TextStyle textStyle14 = TextStyle(fontSize: 14);
  static const TextStyle textStyle16 = TextStyle(fontSize: 16);
  static const TextStyle textStyle18 = TextStyle(fontSize: 18);
  static const TextStyle textStyle20 = TextStyle(fontSize: 20);
  static const TextStyle textStyle24 = TextStyle(fontSize: 24);

  static const TextStyle textStyle14Secondary = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  static const TextStyle textStyle18Bold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textStyle18BoldBlack = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle textStyle18BoldWhite = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle textStyle16Bold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textStyle14Bold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  // ========== Common Decorations ==========
  static const BoxDecoration roundedDecoration8 = BoxDecoration(
    color: Colors.white,
    borderRadius: borderRadius8,
  );

  static const BoxDecoration roundedDecoration16 = BoxDecoration(
    color: Colors.white,
    borderRadius: borderRadius16,
  );

  static const BoxDecoration roundedDecorationWithShadow = BoxDecoration(
    color: Colors.white,
    borderRadius: borderRadius16,
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 2),
        blurRadius: 4,
      ),
    ],
  );

  // ========== Common Shapes ==========
  static const RoundedRectangleBorder roundedRectangleBorder8 = RoundedRectangleBorder(
    borderRadius: borderRadius8,
  );

  static const RoundedRectangleBorder roundedRectangleBorder15 = RoundedRectangleBorder(
    borderRadius: borderRadius15,
  );

  static const RoundedRectangleBorder roundedRectangleBorder16 = RoundedRectangleBorder(
    borderRadius: borderRadius16,
  );

  static const RoundedRectangleBorder roundedRectangleBorder25 = RoundedRectangleBorder(
    borderRadius: borderRadius25,
  );

  // ========== BorderSide Constants ==========
  static const BorderSide borderSideNone = BorderSide.none;
}
