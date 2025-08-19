import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_app/routes/app_routes.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  final RxInt currentIndex = 0.obs;
  final RxString skipText = 'Skip'.obs;

  final PageController pageController = PageController();
  final deviceStorage = GetStorage();

  void onPageChanged(int index) {
    currentIndex.value = index;
    skipText.value = index == 2 ? 'Finish' : 'Skip';
  }

  void dotNavigationClick(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void skipOnBoarding() {
    if (skipText.value == 'Finish') {
      deviceStorage.write('isFirstTime', false);
      Get.offNamed(AppRoutes.auth);
    } else {
      currentIndex.value = 2;
      pageController.animateToPage(
        2,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  // Clean up the controller when it's no longer needed
  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
