import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Icon? prefixIcon;
  const CustomTextField({super.key, this.hintText, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(247, 249, 244, 244),
        prefixIcon:
            prefixIcon ??
            const Icon(Iconsax.search_normal, color: AppColors.primary),
        hintText: hintText ?? 'search'.tr,
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
