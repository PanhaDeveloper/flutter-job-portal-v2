import 'package:get/get.dart';
import 'package:job_app/features/auth/bindings/auth_binding.dart';
import 'package:job_app/features/auth/screen/auth_screen.dart';
import 'package:job_app/features/auth/screen/auth_success_screen.dart';
import 'package:job_app/features/auth/screen/forgot_password_screen.dart';
import 'package:job_app/features/auth/screen/otp_screen.dart';
import 'package:job_app/features/auth/screen/reset_password_screen.dart';
import 'package:job_app/features/home/accounts/binding/change_password_binding.dart';
import 'package:job_app/features/home/accounts/screens/change_password_screen.dart';
import 'package:job_app/features/home/accounts/screens/personal_profile_screen.dart';
import 'package:job_app/features/home/accounts/screens/settings_screen.dart';
import 'package:job_app/features/home/applynow/binding/apply_now_bindig.dart';
import 'package:job_app/features/home/applynow/screens/apply_now_screen.dart';
import 'package:job_app/features/home/applynow/screens/preview_pdf_screen.dart';
import 'package:job_app/features/home/fav/screens/favorite_screen.dart';
import 'package:job_app/features/home/jobdetail/binding/job_detail_binding.dart';
import 'package:job_app/features/home/jobdetail/screens/job_detail_screen.dart';
import 'package:job_app/features/home/notification/screens/notification_screen.dart';
import 'package:job_app/features/home/search_result/screens/search_result_screen.dart';
import 'package:job_app/features/network/binding/no_internet_binding.dart';
import 'package:job_app/features/network/screens/no_internet_screen.dart';
import 'package:job_app/features/onboarding/binding/onboarding_binding.dart';
import 'package:job_app/features/splash/binding/splash_binding.dart';
import 'package:job_app/features/splash/screen/splash_screen.dart';
import 'package:job_app/features/onboarding/screen/boarding_screen.dart';
import 'package:job_app/navigate.dart';
import 'package:job_app/routes/app_routes.dart';

final appPages = [
  GetPage(
    name: AppRoutes.splash,
    page: () => const SplashScreen(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: AppRoutes.onboarding,
    page: () => const OnBoardingScreen(),
    binding: OnboardingBinding(),
  ),
  GetPage(
    name: AppRoutes.auth,
    page: () => const AuthScreen(),
    binding: AuthBinding(),
  ),

  GetPage(
    name: AppRoutes.forgotPassword,
    page: () => const ForgotPasswordScreen(),
    binding: AuthBinding(),
  ),

  GetPage(
    name: AppRoutes.resetPassword,
    page: () => const ResetPasswordScreen(),
    binding: AuthBinding(),
  ),

  GetPage(
    name: AppRoutes.otp,
    page: () => const OtpScreen(),
    binding: AuthBinding(),
  ),

  GetPage(name: AppRoutes.authSuccess, page: () => const AuthSuccessScreen()),

  GetPage(name: AppRoutes.home, page: () => const AppNavigateBar()),

  GetPage(
    name: AppRoutes.personalProfile,
    page: () => const PersonalProfileScreen(),
  ),

  GetPage(name: AppRoutes.notification, page: () => const NotificationScreen()),

  GetPage(
    name: AppRoutes.changePassword,
    page: () => const ChangePasswordScreen(),
    binding: ChangePasswordBinding(),
  ),

  GetPage(
    name: AppRoutes.settings,
    page: () => const SettingsScreen(),
  ),

  GetPage(name: AppRoutes.favoriteJobs, page: () => const FavoriteScreen()),

  GetPage(
    name: AppRoutes.jobDetail,
    page: () => const JobDetailScreen(),
    binding: JobDetailBinding(),
  ),

  GetPage(
    name: AppRoutes.applyNow,
    page: () => const ApplyNowScreen(),
    binding: ApplyNowBinding(),
  ),

  GetPage(name: AppRoutes.previewPdf, page: () => PreviewPdfScreen()),

  GetPage(name: AppRoutes.searchResult, page: () => const SearchResultScreen()),

  GetPage(
    name: AppRoutes.noInternet,
    page: () => const NoInternetScreen(),
    binding: NoInternetBinding(),
  ),
];
