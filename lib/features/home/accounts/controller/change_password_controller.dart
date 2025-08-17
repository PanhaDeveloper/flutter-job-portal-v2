import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/utils/helpers/network_manager.dart';
import 'package:job_app/cores/utils/popups/loaders.dart';

class ChangePasswordController extends GetxController {
  static ChangePasswordController get instance => Get.find();

  final currentPasswordField = TextEditingController();
  final newPasswordField = TextEditingController();
  final confirmNewPasswordField = TextEditingController();

  final currentPassword = false.obs;
  final newPassword = false.obs;
  final confirmNewPassword = false.obs;

  final formKey = GlobalKey<FormState>();

  void toggleCurrentPasswordVisibility() {
    currentPassword.value = !currentPassword.value;
  }

  void toggleNewPasswordVisibility() {
    newPassword.value = !newPassword.value;
  }

  void toggleConfirmNewPasswordVisibility() {
    confirmNewPassword.value = !confirmNewPassword.value;
  }

  Future<void> changePassword() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (!await NetworkManager.instance.isConnected()) {
      Loaders.errorSnackBar(
        title: 'Network Error',
        message: 'No internet connection.',
      );
      return;
    }

    if (newPasswordField.text != confirmNewPasswordField.text) {
      Loaders.errorSnackBar(title: 'Error', message: 'Passwords do not match');
      return;
    }

    try {} catch (e) {
      Loaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to change password',
      );
    }
  }
}
