import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/shared/app_bar_widget.dart';
import 'package:job_app/cores/shared/button_widget.dart';
import 'package:job_app/cores/shared/form_field_widget.dart';
import 'package:job_app/cores/shared/text_form_field.dart';
import 'package:job_app/cores/utils/validators/validation.dart';
import 'package:job_app/features/home/accounts/controller/personal_profile_controller.dart';
import 'package:job_app/features/home/accounts/widgets/profile_img.dart';

class PersonalProfileScreen extends StatelessWidget {
  const PersonalProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalProfileController());

    return Scaffold(
      appBar: AppBarWidget(title: 'Personal Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              // Profile Image
              ProfileImg(controller: controller),
              // Username Field
              FormFieldWidget(
                titleColor: Colors.black87,
                textTitle: 'Username',
                horizontalPadding: 0,
                formField: TextFormFieldWidget(
                  controller: controller.username,
                  hintText: 'Enter your username',
                  validator: (value) => Validator.validateEmptyString(value),
                ),
              ),

              // Phone Field
              FormFieldWidget(
                titleColor: Colors.black87,
                textTitle: 'Phone',
                horizontalPadding: 0,
                formField: TextFormFieldWidget(
                  controller: controller.phone,
                  validator: (value) => Validator.validatePhoneNumber(value),
                  prefixIcon: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '+855',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                        Container(
                          width: 1,
                          height: 20,
                          color: Colors.grey.shade300,
                          margin: const EdgeInsets.only(left: 8),
                        ),
                      ],
                    ),
                  ),
                  hintText: 'Enter your phone number',
                ),
              ),

              // Email Field
              FormFieldWidget(
                titleColor: Colors.black87,
                textTitle: 'Email',
                horizontalPadding: 0,
                formField: TextFormFieldWidget(
                  controller: controller.email,
                  hintText: 'Enter your email',
                  validator: (value) => Validator.validateEmail(value),
                ),
              ),

              // Address Field
              FormFieldWidget(
                titleColor: Colors.black87,
                textTitle: 'Address',
                horizontalPadding: 0,
                formField: TextFormFieldWidget(
                  controller: controller.address,
                  hintText: 'Enter your address',
                  maxLines: 5,
                  validator: (value) => Validator.validateEmptyString(value),
                ),
              ),

              const SizedBox(height: 30),

              // Save Button
              ButtonWidget(
                width: double.infinity,
                height: 50,
                btnTitle: 'Save Changes',
                borderRadius: 15,
                onPressed: () => controller.saveChange(),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
