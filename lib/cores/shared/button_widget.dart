import 'package:flutter/material.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/constants/ui_constants.dart';

class ButtonWidget extends StatelessWidget {
  final double width, height;
  final VoidCallback onPressed;
  final Color btnBgColor, btnTextColor;
  final String btnTitle;
  final double borderRadius;
  final bool isIcon;
  final IconData? icon;

  const ButtonWidget({
    super.key,
    required this.width,
    required this.onPressed,
    this.btnBgColor = AppColors.boldPrimary,
    required this.btnTitle,
    this.btnTextColor = Colors.white,
    this.height = 45,
    this.borderRadius = 25,
    this.isIcon = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: btnBgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide.none,
          ),
          padding: UIConstants.paddingV12,
          elevation: 0,
          splashFactory: NoSplash.splashFactory,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isIcon) ...[
              Icon(icon, color: btnTextColor),
              UIConstants.sizedBoxWidth10,
            ],
            Text(
              btnTitle,
              style: TextStyle(
                color: btnTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
