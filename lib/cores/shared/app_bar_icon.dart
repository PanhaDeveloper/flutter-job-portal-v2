import 'package:flutter/material.dart';
import 'package:job_app/cores/utils/constants/colors.dart';

class AppBarIcon extends StatelessWidget {
  final IconData icon;
  const AppBarIcon({super.key, this.icon = Icons.arrow_back});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.boldPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}
