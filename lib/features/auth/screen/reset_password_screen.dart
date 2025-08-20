import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_app/cores/shared/button_widget.dart';
import 'package:job_app/cores/shared/form_field_widget.dart';
import 'package:job_app/cores/shared/text_form_field.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/validators/validation.dart';
import 'package:job_app/features/auth/controllers/auth_controller.dart';
import 'package:job_app/features/auth/widgets/auth_panel_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AuthController.instance;

    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: AppColors.boldPrimary,
      body: AuthPanelWidget(
        paddingTop: 10,
        content: Form(
          key: controller.resetFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reset Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Please reset your password, make sure your new \npassword is not the same as your old password.',
                style: TextStyle(color: AppColors.textSecondary, height: 1.6),
              ),

              FormFieldWidget(
                textTitle: 'Password',
                formField: Obx(
                  () => TextFormFieldWidget(
                    controller: controller.passwordController,
                    validator: (value) => Validator.validatePassword(value),
                    hintText: controller.hintPasswordRx.value,
                    isPassword: true,
                    isObscure: controller.isObscure.value,
                    passwordToggleIcon:
                        controller.isObscure.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye,
                    onTap: () => controller.togglePasswordVisibility(),
                  ),
                ),
              ),

              FormFieldWidget(
                textTitle: 'Confirm Password',
                formField: Obx(
                  () => TextFormFieldWidget(
                    controller: controller.confirmPasswordController,
                    validator: (value) => Validator.validatePassword(value),
                    hintText: controller.hintPasswordRx.value,
                    isPassword: true,
                    isObscure: controller.isObscureConfirmPassword.value,
                    passwordToggleIcon:
                        controller.isObscureConfirmPassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye,
                    onTap: () => controller.toggleConfirmPasswordVisibility(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => ButtonWidget(
                  width: double.infinity,
                  onPressed: () {
                    if (!controller.isLoading.value) {
                      controller.resetPassword();
                    }
                  },
                  btnTitle: controller.isLoading.value ? 'Resetting...' : 'Reset Password',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
