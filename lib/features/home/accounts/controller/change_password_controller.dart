import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/data/repositories/authentication/authentication_repository.dart';
import 'package:job_app/cores/utils/helpers/network_manager.dart';
import 'package:job_app/cores/utils/popups/full_screen_loader.dart';
import 'package:job_app/cores/utils/popups/loaders.dart';
import 'package:job_app/cores/utils/constants/image_strings.dart';

class ChangePasswordController extends GetxController {
  static ChangePasswordController get instance => Get.find();

  final currentPasswordField = TextEditingController();
  final newPasswordField = TextEditingController();
  final confirmNewPasswordField = TextEditingController();

  final currentPassword = true.obs;
  final newPassword = true.obs;
  final confirmNewPassword = true.obs;
  final isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  // Repository
  final authRepository = Get.put(AuthenticationRepository());

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
    try {
      // Start Loading
      isLoading.value = true;
      FullScreenLoader.openLoadingDialog(
          'Updating your password...', Images.authloadingAnimation);

      // Check Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        isLoading.value = false;
        Loaders.errorSnackBar(
          title: 'No Internet',
          message: 'Please check your internet connection and try again.',
        );
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        isLoading.value = false;
        return;
      }

      // Check if new passwords match
      if (newPasswordField.text.trim() != confirmNewPasswordField.text.trim()) {
        FullScreenLoader.stopLoading();
        isLoading.value = false;
        Loaders.errorSnackBar(
          title: 'Password Mismatch',
          message: 'New password and confirm password do not match.',
        );
        return;
      }

      // Check if new password is different from current password
      if (currentPasswordField.text.trim() == newPasswordField.text.trim()) {
        FullScreenLoader.stopLoading();
        isLoading.value = false;
        Loaders.errorSnackBar(
          title: 'Same Password',
          message: 'New password must be different from current password.',
        );
        return;
      }

      // Get current user email for re-authentication
      final user = authRepository.authUser;
      if (user == null || user.email == null) {
        FullScreenLoader.stopLoading();
        isLoading.value = false;
        Loaders.errorSnackBar(
          title: 'Error',
          message: 'Unable to get current user information.',
        );
        return;
      }

      // Re-authenticate user with current password
      await authRepository.reAuthenticateWithEmailAndPassword(
        user.email!,
        currentPasswordField.text.trim(),
      );

      // Update password
      await authRepository.updatePassword(newPasswordField.text.trim());

      // Stop Loading
      FullScreenLoader.stopLoading();
      isLoading.value = false;

      // Show Success Message
      Loaders.successSnackBar(
        title: 'Success',
        message: 'Your password has been updated successfully.',
      );

      // Clear the form
      currentPasswordField.clear();
      newPasswordField.clear();
      confirmNewPasswordField.clear();

      // Navigate back
      Get.back();

    } catch (e) {
      // Stop Loading
      FullScreenLoader.stopLoading();
      isLoading.value = false;
      
      // Show Error Message
      Loaders.errorSnackBar(
        title: 'Error',
        message: e.toString(),
      );
    }
  }

  @override
  void onClose() {
    currentPasswordField.dispose();
    newPasswordField.dispose();
    confirmNewPasswordField.dispose();
    super.onClose();
  }
}
