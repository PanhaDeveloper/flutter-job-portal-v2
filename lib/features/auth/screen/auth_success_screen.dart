import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:job_app/cores/shared/auth_success_widget.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/routes/app_routes.dart';

class AuthSuccessScreen extends StatelessWidget {
  const AuthSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.boldPrimary,
      body: AuthSuccessWidget(
        title: 'Register Successful!',
        desc: 'You have successfully registered. Enjoy your time with us.',
        onPressed: () {
          Get.offAllNamed(AppRoutes.home);
        },
      ),
    );
  }
}
