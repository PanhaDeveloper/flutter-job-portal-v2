import 'package:flutter/material.dart';
import 'package:job_app/cores/shared/bullet_text.dart';
import 'package:job_app/cores/utils/constants/colors.dart';

class TextBoxContainer extends StatelessWidget {
  final String textTitle;
  final List<String> bulletPoints;
  final bool isBullet;
  const TextBoxContainer({
    super.key,
    required this.textTitle,
    required this.bulletPoints,
    this.isBullet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFF7F7F7),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 12),
            if (isBullet)
              ...bulletPoints.map(
                (bullet) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [BulletText(bullet), const SizedBox(height: 8)],
                ),
              )
            else
              ...bulletPoints.map(
                (text) => Text(
                  text,
                  style: const TextStyle(fontSize: 14, height: 1.4),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
