import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/utils/helpers/network_manager.dart';
import 'package:job_app/cores/utils/popups/loaders.dart';

enum AuthTab { login, register }

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final rememberMe = false.obs;
  final isObscure = true.obs;
  final isObscureConfirmPassword = true.obs;

  final hintTextRx = "user@gmail.com".obs;
  final hintPasswordRx = "••••••••".obs;

  final selectedTab = AuthTab.login.obs;

  final formKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  final forgotFormKey = GlobalKey<FormState>();
  final resetFormKey = GlobalKey<FormState>();

  bool get isLogin => selectedTab.value == AuthTab.login;

  void togglePasswordVisibility() => isObscure.toggle();
  void toggleConfirmPasswordVisibility() => isObscureConfirmPassword.toggle();
  void toggleRememberMe() => rememberMe.toggle();
  void changeTab(AuthTab tab) => selectedTab.value = tab;

  Future<void> login() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (!await NetworkManager.instance.isConnected()) {
      Loaders.errorSnackBar(
        title: "Network Error",
        message: "No internet connection.",
      );
      return;
    }
  }

  Future<void> register() async {
    if (!(registerFormKey.currentState?.validate() ?? false)) return;

    if (!await NetworkManager.instance.isConnected()) {
      Loaders.errorSnackBar(
        title: "Network Error",
        message: "No internet connection.",
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Loaders.errorSnackBar(title: "Error", message: "Passwords do not match.");
      return;
    }

    try {
      Loaders.successSnackBar(
        title: "Success",
        message: "Registration successful!",
      );
    } catch (e) {
      Loaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  Future<void> forgotPassword() async {
    if (!(forgotFormKey.currentState?.validate() ?? false)) return;

    if (!await NetworkManager.instance.isConnected()) {
      Loaders.errorSnackBar(
        title: "Network Error",
        message: "No internet connection.",
      );
      return;
    }
  }

  Future<void> resetPassword() async {
    if (!(resetFormKey.currentState?.validate() ?? false)) return;

    if (!await NetworkManager.instance.isConnected()) {
      Loaders.errorSnackBar(
        title: "Network Error",
        message: "No internet connection.",
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Loaders.errorSnackBar(title: "Error", message: "Passwords do not match.");
      return;
    }

    try {
      Loaders.successSnackBar(
        title: "Success",
        message: "Password reset successful!",
      );
    } catch (e) {
      Loaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }
}
