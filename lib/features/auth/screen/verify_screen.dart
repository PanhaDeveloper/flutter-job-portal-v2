import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/data/repositories/authentication/authentication_repository.dart';
import 'package:job_app/cores/shared/button_widget.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/constants/image_strings.dart';
import 'package:job_app/features/auth/controllers/email_verify_controller.dart';

class VerifyEmailScreen extends StatelessWidget {
  final String? email;

  const VerifyEmailScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmailVerifyController());
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.clear,
              color: AppColors.textSecondary,
            ),
            onPressed: () => AuthenticationRepository.instance.logout(),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.06,
            vertical: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Illustration
              Image.asset(
                Images.verifyEmailImage,
                width: width * 0.45,
                height: width * 0.45,
                fit: BoxFit.contain,
              ),
              SizedBox(height: height * 0.03),

              // Title
              Text(
                'Check your email!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.065,
                  color: AppColors.boldPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.015),

              // Subtitle
              Text(
                'We’ve sent a verification link to:',
                style: TextStyle(
                  color: AppColors.textSecondary.withOpacity(0.85),
                  fontSize: width * 0.04,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.008),

              // User email
              Text(
                email ?? '',
                style: TextStyle(
                  color: AppColors.boldPrimary,
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.025),

              // Description
              Text(
                'Please check your inbox and click the link to verify your account. The link will expire in 24 hours.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: width * 0.035,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.04),

              // Continue Button
              ButtonWidget(
                width: double.infinity,
                onPressed: () => controller.manualCheckVerifyStatus(),
                btnTitle: 'I\'ve Verified My Email',
                height: height * 0.065,
              ),
              SizedBox(height: height * 0.022),

              // Resend Email Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn\'t get the email?',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: width * 0.035,
                    ),
                  ),
                  TextButton(
                    onPressed: () => controller.sendEmailVerification(),
                    child: Text(
                      'Resend',
                      style: TextStyle(
                        color: AppColors.boldPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.035,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.035),

              // Help section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(width * 0.035),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.boldPrimary,
                      size: width * 0.055,
                    ),
                    SizedBox(width: width * 0.025),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Trouble verifying?',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.boldPrimary,
                              fontSize: width * 0.04,
                            ),
                          ),
                          SizedBox(height: height * 0.008),
                          Text(
                            '• Check your spam/junk folder\n'
                            '• Make sure your email is correct\n'
                            '• Try resending the verification email',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: width * 0.032,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
