import 'package:flutter/material.dart';
import 'package:quiz_app/cores/shared/custom_text_field.dart';
import 'package:quiz_app/cores/utils/constants/colors.dart';
import 'package:quiz_app/cores/utils/constants/image_strings.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: CustomTextField()),
        const SizedBox(width: 10),
        SizedBox(
          width: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(vertical: 18),
              elevation: 0,
            ),
            onPressed: () {},
            child: Image.asset(Images.searchIcon, width: 24, height: 24),
          ),
        ),
      ],
    );
  }
}
