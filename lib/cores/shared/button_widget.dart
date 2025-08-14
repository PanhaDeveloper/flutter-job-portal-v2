import 'package:flutter/material.dart';
import 'package:quiz_app/cores/utils/constants/colors.dart';

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
    this.isIcon = false, this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: btnBgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide.none,
          ),
          padding: EdgeInsets.symmetric(vertical: 18),
          elevation: 0,
          splashFactory: NoSplash.splashFactory,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isIcon) ...[
              Icon(icon, color: btnTextColor),
              const SizedBox(width: 10),
            ],
            Text(
              btnTitle,
              style: TextStyle(
                color: btnTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
