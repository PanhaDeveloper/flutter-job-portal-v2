import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_app/cores/shared/app_bar_widget.dart';
import 'package:job_app/cores/shared/button_widget.dart';
import 'package:job_app/cores/shared/form_field_widget.dart';
import 'package:job_app/cores/shared/text_form_field.dart';
import 'package:job_app/cores/utils/validators/validation.dart';
import 'package:job_app/features/home/accounts/controller/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ChangePasswordController.instance;

    return Scaffold(
      appBar: AppBarWidget(title: 'change_password'.tr),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Current Password Field
                    FormFieldWidget(
                      titleColor: Colors.black87,
                      textTitle: 'current_password'.tr,
                      horizontalPadding: 0,
                      formField: Obx(
                        () => TextFormFieldWidget(
                          controller: controller.currentPasswordField,
                          hintText: 'Enter your current password',
                          isPassword: true,
                          isObscure: controller.currentPassword.value,
                          onTap:
                              () =>
                                  controller.toggleCurrentPasswordVisibility(),
                          passwordToggleIcon:
                              controller.currentPassword.value
                                  ? Iconsax.eye
                                  : Iconsax.eye_slash,
                          validator:
                              (value) => Validator.validatePassword(value),
                        ),
                      ),
                    ),

                    FormFieldWidget(
                      titleColor: Colors.black87,
                      textTitle: 'new_password'.tr,
                      horizontalPadding: 0,
                      formField: Obx(
                        () => TextFormFieldWidget(
                          controller: controller.newPasswordField,
                          hintText: 'Enter your new password',
                          isPassword: true,
                          isObscure: controller.newPassword.value,
                          onTap: () => controller.toggleNewPasswordVisibility(),
                          passwordToggleIcon:
                              controller.newPassword.value
                                  ? Iconsax.eye
                                  : Iconsax.eye_slash,
                          validator:
                              (value) => Validator.validatePassword(value),
                        ),
                      ),
                    ),

                    FormFieldWidget(
                      titleColor: Colors.black87,
                      textTitle: 'confirm_new_password'.tr,
                      horizontalPadding: 0,
                      formField: Obx(
                        () => TextFormFieldWidget(
                          controller: controller.confirmNewPasswordField,
                          isObscure: controller.confirmNewPassword.value,
                          isPassword: true,
                          hintText: 'Re-enter your new password',
                          onTap:
                              () =>
                                  controller
                                      .toggleConfirmNewPasswordVisibility(),
                          passwordToggleIcon:
                              controller.confirmNewPassword.value
                                  ? Iconsax.eye
                                  : Iconsax.eye_slash,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your new password';
                            }
                            if (value != controller.newPasswordField.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Save Button
                    Obx(
                      () => ButtonWidget(
                        width: double.infinity,
                        btnTitle: 'save_changes'.tr,
                        borderRadius: 15,
                        onPressed: controller.isLoading.value 
                            ? () {} 
                            : () => controller.changePassword(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
