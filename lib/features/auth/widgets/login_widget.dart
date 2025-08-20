import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_app/cores/shared/button_widget.dart';
import 'package:job_app/cores/shared/form_field_widget.dart';
import 'package:job_app/cores/shared/social_icon.dart';
import 'package:job_app/cores/shared/text_form_field.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/constants/image_strings.dart';
import 'package:job_app/cores/utils/constants/sizes.dart';
import 'package:job_app/cores/utils/validators/validation.dart';
import 'package:job_app/features/auth/controllers/auth_controller.dart';
import 'package:job_app/routes/app_routes.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AuthController.instance;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => controller.facebookSignIn(),
              child: const SocialMediaIcon(iconPath: Images.facebookIcon),
            ),
            const SizedBox(width: Sizes.spaceBtwInputFields),
            GestureDetector(
              onTap: () => controller.googleSignIn(),
              child: const SocialMediaIcon(iconPath: Images.googleIcon),
            ),
          ],
        ),

        const SizedBox(height: Sizes.spaceBtwItems),
        const SizedBox(
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Divider(color: Colors.grey)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Or', style: TextStyle(color: Colors.grey)),
              ),
              Expanded(child: Divider(color: Colors.grey)),
            ],
          ),
        ),

        Form(
          key: controller.formKey,
          child: Column(
            children: [
              FormFieldWidget(
                textTitle: 'Email',
                formField: Obx(
                  () => TextFormFieldWidget(
                    controller: controller.emailController,
                    validator: (value) => Validator.validateEmail(value),
                    hintText: controller.hintTextRx.value,
                  ),
                ),
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

              const SizedBox(height: Sizes.spaceBtwItems),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) => controller.toggleRememberMe(),
                          activeColor: AppColors.boldPrimary,
                        ),
                      ),
                      const Text(
                        'Remember me',
                        style: TextStyle(color: AppColors.boldPrimary),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(color: AppColors.boldPrimary),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: Sizes.spaceBtwItems),

              Obx(
                () => ButtonWidget(
                  width: double.infinity,
                  onPressed: () {
                    if (!controller.isLoading.value) {
                      controller.login();
                    }
                  },
                  btnTitle:
                      controller.isLoading.value ? 'Signing In...' : 'Login',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
