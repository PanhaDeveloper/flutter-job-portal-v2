import 'package:flutter/material.dart';
import 'package:job_app/cores/utils/constants/colors.dart';

class CustomNavigate extends StatelessWidget {
  final IconData iconPath;
  final String label;
  final int index;
  final bool isSelected;
  final VoidCallback onTab;

  const CustomNavigate({
    super.key,
    required this.iconPath,
    required this.label,
    required this.index,
    required this.isSelected,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: isSelected ? 15 : 0,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.buttonPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(iconPath, color: isSelected ? Colors.white : Colors.grey),
            if (isSelected) ...[
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
