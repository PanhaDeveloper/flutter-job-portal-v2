import 'package:flutter/material.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/helpers/helper_functions.dart';

class OnboardingWidget extends StatelessWidget {
  final String image, title, description;
  const OnboardingWidget({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, width: 300),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppColors.boldPrimary,
            decoration: TextDecoration.none,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white : Colors.black,
              decoration: TextDecoration.none,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
