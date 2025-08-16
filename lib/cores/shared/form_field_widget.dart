import 'package:flutter/material.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/constants/sizes.dart';

class FormFieldWidget extends StatelessWidget {
  final String textTitle;
  final double horizontalPadding;
  final Widget? formField;
  final Color? titleColor;

  const FormFieldWidget({
    super.key,
    required this.textTitle,
    this.horizontalPadding = 0,
    this.titleColor = AppColors.black,
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
              color: titleColor,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 8),
        formField!,
      ],
    );
  }
}
