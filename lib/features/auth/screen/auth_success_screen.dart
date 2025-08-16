import 'package:flutter/material.dart';
import 'package:job_app/cores/shared/auth_success_widget.dart';
import 'package:job_app/cores/utils/constants/colors.dart';

class AuthSuccessScreen extends StatelessWidget {
  const AuthSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.boldPrimary,
      body: AuthSuccessWidget(
        title: "Login Successful!",
        desc:
            "Welcome back, User! You have successfully logged in. Enjoy your time with us.",
        onPressed: () {},
      ),
    );
  }
}
