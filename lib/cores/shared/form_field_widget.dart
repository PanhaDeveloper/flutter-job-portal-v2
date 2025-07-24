import 'package:flutter/material.dart';
import 'package:quiz_app/cores/utils/constants/colors.dart';
import 'package:quiz_app/cores/utils/constants/sizes.dart';

class FormFieldWidget extends StatelessWidget {
  final String textTitle;
  final double horizontalPadding;
  final Widget? formField;

  const FormFieldWidget({
    super.key,
    required this.textTitle,
    this.horizontalPadding = 15, 
    this.formField,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Sizes.spaceBtwInputFields),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Text(
            textTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 8),
        formField!
      ],
    );
  }
}
