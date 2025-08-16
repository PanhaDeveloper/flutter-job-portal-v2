import 'dart:async';
import 'package:get/get.dart';
import 'package:job_app/routes/app_routes.dart';

class SplashController extends GetxController {
  static SplashController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();

    onSplashScreen();
  }

  void onSplashScreen() {
    Timer(const Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.onboarding);
    });
  }
}
