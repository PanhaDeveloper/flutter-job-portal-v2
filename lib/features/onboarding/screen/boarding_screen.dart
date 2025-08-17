import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/data/data.dart';
import 'package:job_app/cores/shared/build_dot_widget.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/features/onboarding/controller/onboarding_controller.dart';
import 'package:job_app/features/onboarding/widgets/onboarding_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const onboarding = Data.onBoardingData;
    final controller = OnboardingController.instance;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => controller.skipOnBoarding(),
                  child: Obx(
                    () => Text(
                      controller.skipText.value,
                      style: const TextStyle(
                        color: AppColors.boldPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: (index) => controller.onPageChanged(index),
              itemCount: onboarding.length,
              itemBuilder: (context, index) {
                return OnboardingWidget(
                  image: onboarding[index]['image']!,
                  title: onboarding[index]['title']!,
                  description: onboarding[index]['description']!,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboarding.length,
                (index) => Obx(
                  () => BuildDotWidget(
                    index: index,
                    currentIndex: controller.currentIndex.value,
                    onTap: () => controller.dotNavigationClick(index),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
