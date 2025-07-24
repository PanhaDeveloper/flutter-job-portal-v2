import 'dart:ui';

// import 'package:quiz_app/cores/shared/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/cores/utils/constants/colors.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String? buttonText;
  final VoidCallback? onPressed;
  const CustomAlertDialog({
    super.key,
    required this.title,
    this.subTitle,
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Blurred background
        AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),
        ),
        // Centered Animated AlertDialog
        Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.8, end: 1.0),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOutCubic,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.scale(scale: value, child: child),
              );
            },
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: AppColors.white,
              shadowColor: const Color.fromRGBO(149, 157, 165, 0.2),
              elevation: 5,
              actionsPadding: const EdgeInsets.all(25),
              actionsAlignment: MainAxisAlignment.center,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/images/animations/success.json',
                    width: 200,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subTitle!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              actions: [
                // AuthButton(buttonText: buttonText!, onPressed: onPressed!)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
