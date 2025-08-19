import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/features/auth/controllers/auth_controller.dart';
import 'package:job_app/cores/shared/button_widget.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/features/auth/widgets/auth_panel_widget.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AuthController.instance;
    
    return Scaffold(
      backgroundColor: AppColors.boldPrimary,
      body: AuthPanelWidget(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Email Verification',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'We have sent a verification email to your email address. \nPlease check your email and click the verification link.',
              style: TextStyle(color: AppColors.textSecondary, height: 1.6),
            ),
            const SizedBox(height: 30),
            
            // Email verification message
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: 48,
                    color: Colors.blue.shade600,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Verification Email Sent',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please check your inbox and spam folder for the verification email.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Resend verification button
            Obx(
              () => ButtonWidget(
                width: double.infinity,
                onPressed: () {
                  if (!controller.isLoading.value) {
                    controller.resendEmailVerification();
                  }
                },
                btnTitle: controller.isLoading.value ? 'Sending...' : 'Resend Verification Email',
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Continue button
            ButtonWidget(
              width: double.infinity,
              onPressed: () => controller.confirmOtp(),
              btnTitle: 'Continue to Login',
            ),
          ],
        ),
      ),
    );
  }
}
