import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_app/cores/utils/constants/colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isPassword;
  final bool isObscure;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final IconData? passwordToggleIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final TextInputType keyboardType;
  final bool readOnly;

  const TextFormFieldWidget({
    super.key,
    this.controller,
    required this.hintText,
    this.isPassword = false,
    this.validator,
    this.isObscure = false,
    this.onTap,
    this.passwordToggleIcon = Iconsax.eye_slash,
    this.prefixIcon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      validator: validator,
      readOnly: readOnly,
      style: const TextStyle(color: Colors.black),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        suffixIcon:
            isPassword
                ? Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: InkWell(
                    onTap: onTap,
                    child: Icon(
                      passwordToggleIcon!,
                      color: AppColors.boldPrimary,
                    ),
                  ),
                )
                : null,
        hintStyle: TextStyle(color: Colors.grey.shade500),
      ),
      obscureText: isObscure,
    );
  }
}
