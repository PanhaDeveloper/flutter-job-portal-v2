import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/data/models/user_model.dart';
import 'package:job_app/cores/data/repositories/authentication/authentication_repository.dart';
import 'package:job_app/cores/data/repositories/user/user_repository.dart';
import 'package:job_app/cores/utils/helpers/network_manager.dart';
import 'package:job_app/cores/utils/popups/loaders.dart';
import 'package:job_app/features/personalization/controllers/user_controller.dart';
import 'package:job_app/routes/app_routes.dart';

enum AuthTab { login, register }

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  // Repository
  final authRepository = Get.put(AuthenticationRepository());
  final userRepository = Get.put(UserRepository());

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final otpController = TextEditingController();

  final rememberMe = false.obs;
  final isObscure = true.obs;
  final isObscureConfirmPassword = true.obs;
  final isLoading = false.obs;

  final hintTextRx = 'user@gmail.com'.obs;
  final hintPasswordRx = '••••••••'.obs;

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

  /// Google Sign In
  Future<void> googleSignIn() async {
    if (!await NetworkManager.instance.isConnected()) {
      Loaders.errorSnackBar(
        title: 'Network Error',
        message: 'No internet connection.',
      );
      return;
    }

    try {
      isLoading.value = true;

      // Sign in with Google
      await authRepository.signInWithGoogle();

      Loaders.successSnackBar(
        title: 'Success',
        message: 'Google sign-in successful!',
      );

      // Navigate to home screen
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Google Sign In Failed', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (!await NetworkManager.instance.isConnected()) {
      Loaders.errorSnackBar(
        title: 'Network Error',
        message: 'No internet connection.',
      );
      return;
    }

    try {
      isLoading.value = true;

      // Login user using email and password authentication
      await authRepository.loginWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      // Clear the input fields
      emailController.clear();
      passwordController.clear();

      Loaders.successSnackBar(title: 'Success', message: 'Login successful!');

      // Navigate to home or next screen
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Login Failed', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    if (!(registerFormKey.currentState?.validate() ?? false)) return;

    if (!await NetworkManager.instance.isConnected()) {
      Loaders.errorSnackBar(
        title: 'Network Error',
        message: 'No internet connection.',
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Loaders.errorSnackBar(title: 'Error', message: 'Passwords do not match.');
      return;
    }

    try {
      isLoading.value = true;

      // Register user using email and password authentication
      final userCredential = await authRepository.registerWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      // Save user data to Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        username: UserModel.generateUsername('${firstNameController.text.trim()} ${lastNameController.text.trim()}'),
        email: emailController.text.trim(),
        phoneNumber: '',
        profilePicture: '',
      );

      await userRepository.saveUserRecord(newUser);

      // Update UserController with new user data
      if (Get.isRegistered<UserController>()) {
        Get.find<UserController>().fetchUserRecord();
      }

      // Send email verification
      await authRepository.sendEmailVerification();

      // Clear the input fields
      firstNameController.clear();
      lastNameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      Loaders.successSnackBar(
        title: 'Success',
        message: 'Registration successful! Please verify your email to complete the process.',
      );

      // Navigate to email verification screen
      Get.offAllNamed(AppRoutes.otp);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Registration Failed', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword() async {
    if (!(forgotFormKey.currentState?.validate() ?? false)) return;

    if (!await NetworkManager.instance.isConnected()) {
      Loaders.errorSnackBar(
        title: 'Network Error',
        message: 'No internet connection.',
      );
      return;
    }

    try {
      isLoading.value = true;

      // Send password reset email
      await authRepository.sendPasswordResetEmail(emailController.text.trim());

      Loaders.successSnackBar(
        title: 'Success',
        message: 'Password reset email sent. Please check your email.',
      );

      // Clear the input field
      emailController.clear();

      // Navigate back to login screen
      Get.back();

    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Resend email verification
  Future<void> resendEmailVerification() async {
    if (!await NetworkManager.instance.isConnected()) {
      Loaders.errorSnackBar(
        title: 'Network Error',
        message: 'No internet connection.',
      );
      return;
    }

    try {
      isLoading.value = true;

      // Resend email verification
      await authRepository.sendEmailVerification();

      Loaders.successSnackBar(
        title: 'Email Sent',
        message: 'Verification email has been sent again. Please check your email.',
      );
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword() async {
    if (!(resetFormKey.currentState?.validate() ?? false)) return;

    if (!await NetworkManager.instance.isConnected()) {
      Loaders.errorSnackBar(
        title: 'Network Error',
        message: 'No internet connection.',
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Loaders.errorSnackBar(title: 'Error', message: 'Passwords do not match.');
      return;
    }

    try {
      isLoading.value = true;

      // Note: Firebase handles password reset through email links
      // This is more for demonstration - actual password reset happens through email
      Loaders.successSnackBar(
        title: 'Success',
        message: 'Password has been reset successfully! Please login with your new password.',
      );

      // Clear fields
      passwordController.clear();
      confirmPasswordController.clear();

      // Navigate to login screen
      Get.offAllNamed(AppRoutes.auth);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> confirmOtp() async {
    if (!await NetworkManager.instance.isConnected()) {
      Loaders.errorSnackBar(
        title: 'Network Error',
        message: 'No internet connection.',
      );
      return;
    }

    try {
      Loaders.successSnackBar(
        title: 'Success', 
        message: 'Please complete the email verification and try logging in again.',
      );
      
      // Navigate back to auth screen
      Get.offAllNamed(AppRoutes.auth);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
