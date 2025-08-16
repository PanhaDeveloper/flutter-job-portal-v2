import 'package:flutter/material.dart';
import 'package:job_app/cores/shared/circle_widget.dart';
import 'package:job_app/cores/utils/constants/image_strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -80,
            left: -50,
            child: Image.asset(Images.circleLogo, width: 150),
          ),
          Positioned(top: 250, right: -50, child: CircleWidget(size: 120)),
          Positioned(bottom: -80, left: -60, child: CircleWidget(size: 180)),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(Images.appLogo, width: 200),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
