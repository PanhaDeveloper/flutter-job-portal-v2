import 'package:get/get.dart';
import 'package:quiz_app/features/auth/bindings/auth_binding.dart';
import 'package:quiz_app/features/auth/screen/auth_screen.dart';
import 'package:quiz_app/features/auth/screen/auth_success_screen.dart';
import 'package:quiz_app/features/auth/screen/forgot_password_screen.dart';
import 'package:quiz_app/features/auth/screen/otp_screen.dart';
import 'package:quiz_app/features/auth/screen/reset_password_screen.dart';
import 'package:quiz_app/features/onboarding/binding/onboarding_binding.dart';
import 'package:quiz_app/features/splash/binding/splash_binding.dart';
import 'package:quiz_app/features/splash/screen/splash_screen.dart';
import 'package:quiz_app/features/onboarding/screen/boarding_screen.dart';
import 'package:quiz_app/routes/app_routes.dart';

final appPages = [
  GetPage(
    name: AppRoutes.splash,
    page: () => SplashScreen(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: AppRoutes.onboarding,
    page: () => OnBoardingScreen(),
    binding: OnboardingBinding(),
  ),
  GetPage(
    name: AppRoutes.auth,
    page: () => AuthScreen(),
    binding: AuthBinding(),
  ),

  GetPage(
    name: AppRoutes.forgotPassword,
    page: () => ForgotPasswordScreen(),
    binding: AuthBinding(),
  ),

  GetPage(
    name: AppRoutes.resetPassword,
    page: () => ResetPasswordScreen(),
    binding: AuthBinding(),
  ),

  GetPage(name: AppRoutes.otp, page: () => OtpScreen(), binding: AuthBinding()),

  GetPage(name: AppRoutes.authSuccess, page: () => AuthSuccessScreen()),
];
