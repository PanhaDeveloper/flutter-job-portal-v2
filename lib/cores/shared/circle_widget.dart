import 'package:flutter/material.dart';
import 'package:quiz_app/cores/utils/constants/colors.dart';

class CircleWidget extends StatelessWidget {
  final double size;
  final Color circleColor;

  const CircleWidget({
    super.key,
    required this.size,
    this.circleColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
    );
  }
}
