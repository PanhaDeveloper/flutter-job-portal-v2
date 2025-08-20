import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/shared/button_widget.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/constants/sizes.dart';
import 'package:job_app/features/auth/widgets/auth_panel_widget.dart';
import 'package:job_app/routes/app_routes.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String email = Get.arguments ?? '';

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      backgroundColor: AppColors.boldPrimary,
      body: AuthPanelWidget(
        paddingTop: 20,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            
            // Email icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.mark_email_read_outlined,
                size: 50,
                color: AppColors.primary,
              ),
            ),
            
            const SizedBox(height: Sizes.spaceBtwItems),
            
            const Text(
              'Check Your Email',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 15),
            
            const Text(
              'We\'ve sent a password reset link to:',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 8),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                email.isNotEmpty ? email : 'your email address',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            const SizedBox(height: 25),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blue.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.blue,
                    size: 24,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please check your email and click on the link to reset your password.',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Don\'t forget to check your spam or junk folder if you don\'t see it in your inbox.',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: Sizes.spaceBtwSections),
            
            // Back to Login button
            ButtonWidget(
              width: double.infinity,
              onPressed: () => Get.offAllNamed(AppRoutes.auth),
              btnTitle: 'Back to Login',
            ),
            
            const SizedBox(height: Sizes.sm),
            
            // Resend email button
            TextButton(
              onPressed: () {
                // Go back to forgot password screen to resend
                Get.back();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.refresh,
                    color: AppColors.primary,
                    size: 18,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Resend Email',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
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
