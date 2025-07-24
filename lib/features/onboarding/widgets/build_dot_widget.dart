import 'package:flutter/material.dart';
import 'package:quiz_app/features/onboarding/controller/onboarding_controller.dart';

class BuildDotWidget extends StatelessWidget {
  final int index;
  final int currentIndex;
  const BuildDotWidget({
    super.key,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => OnboardingController.instance.dotNavigationClick(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: currentIndex == index ? 30 : 20,
        height: 4,
        decoration: BoxDecoration(
          color: currentIndex == index ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
