import 'package:flutter/material.dart';
import 'package:job_app/cores/shared/app_bar_widget.dart';
import 'package:job_app/cores/shared/button_widget.dart';
import 'package:job_app/cores/shared/form_field_widget.dart';
import 'package:job_app/cores/shared/text_form_field.dart';
import 'package:job_app/cores/utils/validators/validation.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Change Password'),
      body: SingleChildScrollView(
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
                    textTitle: 'Current Password',
                    horizontalPadding: 0,
                    formField: TextFormFieldWidget(
                      hintText: 'Enter your current password',
                      isPassword: true,
                      isObscure: true,
                      validator: (value) => Validator.validatePassword(value),
                    ),
                  ),

                  FormFieldWidget(
                    titleColor: Colors.black87,
                    textTitle: 'New Password',
                    horizontalPadding: 0,
                    formField: TextFormFieldWidget(
                      hintText: 'Enter your new password',
                      isPassword: true,
                      isObscure: true,
                      validator: (value) => Validator.validatePassword(value),
                    ),
                  ),

                  FormFieldWidget(
                    titleColor: Colors.black87,
                    textTitle: 'Confirm New Password',
                    horizontalPadding: 0,
                    formField: TextFormFieldWidget(
                      isObscure: true,
                      isPassword: true,
                      hintText: 'Re-enter your new password',
                      validator: (value) => Validator.validatePassword(value),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Save Button
                  ButtonWidget(
                    width: double.infinity,
                    height: 50,
                    btnTitle: 'Save Changes',
                    borderRadius: 15,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
