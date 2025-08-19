import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/data/repositories/authentication/authentication_repository.dart';
import 'package:job_app/cores/utils/popups/loaders.dart';
import 'package:job_app/features/auth/screen/auth_success_screen.dart';

class EmailVerifyController extends GetxController {
  static EmailVerifyController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    autoCheckVerifyStatus();
    super.onInit();
  }

  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();

      Loaders.successSnackBar(
        title: 'Verification Email Sent',
        message: 'Please check your email to verify your account.',
      );
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  // auth check by machine
  autoCheckVerifyStatus() async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && user.emailVerified) {
        timer.cancel();
        Loaders.successSnackBar(
          title: 'Email Verified',
          message: 'Your email has been successfully verified.',
        );
        Get.off(
          () => AuthSuccessScreen(
            title: 'Email Verified',
            subTitle: 'Your email is verified. You can now log in.',
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ),
        );
      }
    });
  }

  // check by user manually
  manualCheckVerifyStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      Loaders.successSnackBar(
        title: 'Email Verified',
        message: 'Your email is already verified.',
      );
      Get.off(
        () => AuthSuccessScreen(
          title: 'Email Verified',
          subTitle: 'Your email is verified. You can now log in.',
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    } else {
      Loaders.errorSnackBar(
        title: 'Email Not Verified',
        message: 'Please verify your email to continue.',
      );
    }
  }
}
