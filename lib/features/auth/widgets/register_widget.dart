import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quiz_app/cores/shared/button_widget.dart';
import 'package:quiz_app/cores/shared/form_field_widget.dart';
import 'package:quiz_app/cores/shared/text_form_field.dart';
import 'package:quiz_app/cores/utils/constants/colors.dart';
import 'package:quiz_app/cores/utils/constants/sizes.dart';
import 'package:quiz_app/cores/utils/validators/validation.dart';
import 'package:quiz_app/features/auth/controllers/auth_controller.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AuthController.instance;

    return Form(
      key: controller.registerFormKey,
      child: Column(
        children: [
          FormFieldWidget(
            textTitle: "Email",
            formField: Obx(
              () => TextFormFieldWidget(
                controller: controller.emailController,
                validator: (value) => Validator.validateEmail(value),
                hintText: controller.hintTextRx.value,
              ),
            ),
          ),

          FormFieldWidget(
            textTitle: "Password",
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
            textTitle: "Confirm Password",
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

          const SizedBox(height: Sizes.spaceBtwItems),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => controller.changeTab(AuthTab.login),
              child: Text(
                "Already have an account?",
                style: TextStyle(color: AppColors.boldPrimary, fontSize: 12),
              ),
            ),
          ),

          const SizedBox(height: Sizes.spaceBtwItems),

          ButtonWidget(
            width: double.infinity,
            onPressed: () => controller.register(),
            btnTitle: "Register",
          ),
        ],
      ),
    );
  }
}
