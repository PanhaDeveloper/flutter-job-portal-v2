import 'package:flutter/material.dart';
import 'package:quiz_app/cores/utils/constants/colors.dart';

class JobCategoryTitle extends StatelessWidget {
  final Color btnColor;
  final String title;
  final Color textColor;
  final VoidCallback onPressed;
  final Color borderColor;

  const JobCategoryTitle({
    super.key,
    this.btnColor = AppColors.buttonPrimary,
    required this.title,
    this.textColor = AppColors.textPrimary,
    required this.onPressed,
    this.borderColor = AppColors.buttonPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        shadowColor: Colors.transparent,
        backgroundColor: btnColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 0,
        side: BorderSide(color: borderColor),
        splashFactory: NoSplash.splashFactory,
      ),
      child: Text(
        title,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}