import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:job_app/cores/shared/button_widget.dart';
import 'package:job_app/cores/shared/circle_widget.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/constants/image_strings.dart';
import 'package:job_app/cores/utils/constants/sizes.dart';
import 'package:job_app/features/network/controller/no_internet_controller.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NoInternetController());

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Background decorative elements
            Positioned(
              top: -80,
              left: -50,
              child: Image.asset(Images.circleLogo, width: 150),
            ),
            const Positioned(
              top: 100,
              right: -50,
              child: CircleWidget(size: 120),
            ),
            const Positioned(
              bottom: -80,
              left: -60,
              child: CircleWidget(size: 180),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // No internet animation
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Lottie.asset(
                      Images.errorAlert,
                      fit: BoxFit.contain,
                      repeat: true,
                    ),
                  ),

                  const SizedBox(height: Sizes.xl),

                  // Title
                  const Text(
                    'No Internet Connection',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: Sizes.md),

                  // Description
                  const Text(
                    'Please check your internet connection and try again. Make sure you have a stable connection to continue.',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: Sizes.xl * 2),

                  // Retry button
                  Obx(
                    () => ButtonWidget(
                      width: double.infinity,
                      height: 50,
                      onPressed:
                          controller.isRetrying.value
                              ? () {}
                              : controller.retryConnection,
                      btnTitle:
                          controller.isRetrying.value
                              ? 'Checking...'
                              : 'Try Again',
                      btnBgColor: AppColors.boldPrimary,
                      btnTextColor: AppColors.white,
                      borderRadius: 12,
                      isIcon: !controller.isRetrying.value,
                      icon: Icons.refresh_rounded,
                    ),
                  ),

                  const SizedBox(height: Sizes.md),

                  // Go back button
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.borderPrimary,
                        width: 1,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: controller.goBack,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.textPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Go Back',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: Sizes.xl),

                  // Help text
                  const Text(
                    'If the problem persists, please check your network settings or contact your internet service provider.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.darkGrey,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
