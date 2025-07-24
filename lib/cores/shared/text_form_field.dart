import 'package:flutter/material.dart';
import 'package:quiz_app/cores/utils/constants/colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isPassword;
  final bool isObscure;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final IconData? passwordToggleIcon;

  const TextFormFieldWidget({
    super.key,
    this.controller,
    required this.hintText,
    this.isPassword = false,
    this.validator,
    this.isObscure = false,
    this.onTap,
    this.passwordToggleIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
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
      ),
      obscureText: isObscure,
    );
  }
}
