import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/cores/shared/button_widget.dart';
import 'package:quiz_app/cores/shared/form_field_widget.dart';
import 'package:quiz_app/cores/shared/text_form_field.dart';
import 'package:quiz_app/cores/utils/constants/colors.dart';
import 'package:quiz_app/cores/utils/constants/sizes.dart';
import 'package:quiz_app/cores/utils/validators/validation.dart';
import 'package:quiz_app/features/auth/controllers/auth_controller.dart';
import 'package:quiz_app/features/auth/widgets/auth_panel_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AuthController.instance;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.white),
      ),
      backgroundColor: AppColors.boldPrimary,
      body: AuthPanelWidget(
        paddingTop: 10,
        content: Form(
          key: controller.forgotFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Please enter your email for us to send \nconfirmation regarding your password change.",
                style: TextStyle(color: AppColors.textSecondary, height: 1.6),
              ),

              const SizedBox(height: Sizes.sm),
              FormFieldWidget(
                textTitle: "Email",
                formField: Obx(
                  () => TextFormFieldWidget(
                    hintText: controller.hintTextRx.value,
                    controller: controller.emailController,
                    validator: (value) => Validator.validateEmail(value),
                  ),
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwItems),
              ButtonWidget(
                width: double.infinity,
                onPressed: () => controller.forgotPassword(),
                btnTitle: "Send",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
