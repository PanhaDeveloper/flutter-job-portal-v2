import 'package:flutter/material.dart';

class TabAuth extends StatelessWidget {
  final String text;
  final Color color, textColor;
  final VoidCallback onPressed;
  final BorderRadius borderRadius;
  final BoxDecoration? decoration;

  const TabAuth({
    super.key,
    required this.text,
    this.color = Colors.white,
    this.textColor = Colors.white,
    required this.onPressed,
    required this.borderRadius,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        elevation: 0,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            decoration: decoration,
            child: Text(
              text,
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
