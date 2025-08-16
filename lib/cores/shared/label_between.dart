import 'package:flutter/material.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/helpers/app_resposive.dart';

class LabelBetween extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback? onPressed;

  const LabelBetween({
    super.key,
    required this.title,
    required this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = AppResponsive(context);

    double titleFontSize =
        responsive.isSmallDevice
            ? 14
            : responsive.isMediumDevice
            ? 16
            : 18;

    double buttonFontSize =
        responsive.isSmallDevice
            ? 12
            : responsive.isMediumDevice
            ? 14
            : 16;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColors.buttonPrimary,
              fontSize: buttonFontSize,
            ),
          ),
        ),
      ],
    );
  }
}
