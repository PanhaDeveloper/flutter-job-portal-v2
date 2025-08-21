import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/shared/auth_success_widget.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/routes/app_routes.dart';

class AuthSuccessScreen extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final VoidCallback? onPressed;
  const AuthSuccessScreen({
    super.key,
    this.title,
    this.subTitle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    print('AuthSuccessScreen: Building with title: $title, subTitle: $subTitle');
    
    return Scaffold(
      backgroundColor: AppColors.boldPrimary,
      body: AuthSuccessWidget(
        title: title ?? 'Register Successful!',
        desc:
            subTitle ??
            'You have successfully registered. Enjoy your time with us.',
        onPressed: onPressed ?? () {
          print('AuthSuccessScreen: Default onPressed, navigating to home');
          Get.offAllNamed(AppRoutes.home);
        },
      ),
    );
  }
}
