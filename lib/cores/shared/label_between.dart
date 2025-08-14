import 'package:flutter/material.dart';
import 'package:quiz_app/cores/utils/constants/colors.dart';

class LabelBetween extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onPressed;

  const LabelBetween({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
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
            ),
          ),
        ),
      ],
    );
  }
}
