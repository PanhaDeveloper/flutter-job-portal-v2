import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/data/repositories/authentication/authentication_repository.dart';
import 'package:job_app/cores/utils/popups/loaders.dart';
import 'package:job_app/features/auth/screen/auth_success_screen.dart';
import 'package:job_app/routes/app_routes.dart';

class EmailVerifyController extends GetxController {
  static EmailVerifyController get instance => Get.find();
  
  Timer? _timer;

  @override
  void onInit() {
    sendEmailVerification();
    autoCheckVerifyStatus();
    super.onInit();
  }

  @override
  void onClose() {
    // Cancel timer when controller is disposed
    _timer?.cancel();
    super.onClose();
  }

  sendEmailVerification() async {
    try {
      print('EmailVerifyController: Sending email verification');
      await AuthenticationRepository.instance.sendEmailVerification();

      Loaders.successSnackBar(
        title: 'Verification Email Sent',
        message: 'Please check your email to verify your account.',
      );
    } catch (e) {
      print('EmailVerifyController: Error sending verification email: $e');
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  // auth check by machine
  autoCheckVerifyStatus() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      try {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user != null && user.emailVerified) {
          timer.cancel();
          _timer = null;
          
          print('EmailVerifyController: Email verified, navigating to AuthSuccessScreen');
          
          Loaders.successSnackBar(
            title: 'Email Verified',
            message: 'Your email has been successfully verified.',
          );
          
          // Navigate to success screen
          Get.off(
            () => AuthSuccessScreen(
              title: 'Email Verified',
              subTitle: 'Your email is verified. Welcome to the app!',
              onPressed: () {
                print('AuthSuccessScreen: Close button pressed, navigating to home');
                // Navigate to home and clear all previous routes
                Get.offAllNamed(AppRoutes.home);
              },
            ),
          );
        }
      } catch (e) {
        // Handle any errors silently
        print('Error checking verification status: $e');
      }
    });
  }

  // check by user manually
  manualCheckVerifyStatus() async {
    try {
      // Reload user to get latest verification status
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      
      if (user != null && user.emailVerified) {
        // Cancel auto-check timer if running
        _timer?.cancel();
        _timer = null;
        
        print('EmailVerifyController: Manual check - Email verified, navigating to AuthSuccessScreen');
        
        Loaders.successSnackBar(
          title: 'Email Verified',
          message: 'Your email is already verified.',
        );
        
        Get.off(
          () => AuthSuccessScreen(
            title: 'Email Verified',
            subTitle: 'Your email is verified. Welcome to the app!',
            onPressed: () {
              print('AuthSuccessScreen: Close button pressed (manual check), navigating to home');
              // Navigate to home and clear all previous routes
              Get.offAllNamed(AppRoutes.home);
            },
          ),
        );
      } else {
        Loaders.errorSnackBar(
          title: 'Email Not Verified',
          message: 'Please verify your email to continue.',
        );
      }
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to check verification status: ${e.toString()}',
      );
    }
  }
}
