import 'package:flutter/material.dart';
import 'package:job_app/cores/shared/custom_text_field.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/constants/image_strings.dart';
import 'package:job_app/cores/utils/constants/ui_constants.dart';

class SearchBox extends StatelessWidget {
  final VoidCallback? onPressed;
  const SearchBox({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: CustomTextField()),
        UIConstants.sizedBoxWidth10,
        SizedBox(
          width: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: UIConstants.paddingV18,
              elevation: 0,
            ),
            onPressed: onPressed ?? () {},
            child: Image.asset(Images.searchIcon, width: 24, height: 24),
          ),
        ),
      ],
    );
  }
}
