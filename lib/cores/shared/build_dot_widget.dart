import 'package:flutter/material.dart';

class BuildDotWidget extends StatelessWidget {
  final int index;
  final int currentIndex;
  final VoidCallback? onTap;
  final double dotSize;
  final double borderRadius;
  const BuildDotWidget({
    super.key,
    required this.index,
    required this.currentIndex,
    this.onTap,
    this.dotSize = 20.0,
    this.borderRadius = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: currentIndex == index ? 30 : dotSize,
        height: 4,
        decoration: BoxDecoration(
          color: currentIndex == index ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
