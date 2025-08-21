import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:job_app/cores/shared/button_widget.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/constants/image_strings.dart';

class AuthSuccessWidget extends StatelessWidget {
  final String title;
  final String desc;
  final VoidCallback onPressed;
  final String lottiePath;

  const AuthSuccessWidget({
    super.key,
    required this.title,
    required this.desc,
    required this.onPressed,
    this.lottiePath = Images.successLottie,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: Lottie.asset(lottiePath),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    desc,
                    style: const TextStyle(
                      color: Color(0xECECECEC),
                      fontSize: 16,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          ButtonWidget(
            width: 180,
            onPressed: () {
              print('AuthSuccessWidget: Close button pressed, calling onPressed callback');
              onPressed();
            },
            btnTitle: 'Close',
            btnBgColor: AppColors.white,
            btnTextColor: AppColors.boldPrimary,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
