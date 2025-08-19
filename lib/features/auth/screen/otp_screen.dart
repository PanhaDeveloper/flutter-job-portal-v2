import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/features/auth/controllers/auth_controller.dart';
import 'package:pinput/pinput.dart';
import 'package:job_app/cores/shared/button_widget.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/features/auth/widgets/auth_panel_widget.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.boldPrimary,
      body: AuthPanelWidget(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Confirm OTP',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Please enter your 6 digit codes that we’ve sent to \nyour email.',
              style: TextStyle(color: AppColors.textSecondary, height: 1.6),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.topCenter,
              child: Pinput(
                length: 6,
                autofocus: true,
                showCursor: true,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 83, 83, 83),
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(247, 249, 244, 244),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ButtonWidget(
              width: double.infinity,
              onPressed: () => AuthController.instance.confirmOtp(),
              btnTitle: 'Confirm OTP',
            ),
          ],
        ),
      ),
    );
  }
}
