import 'package:get/get.dart';
import 'package:job_app/cores/utils/helpers/network_manager.dart';
import 'package:job_app/cores/utils/popups/loaders.dart';
import 'package:job_app/routes/app_routes.dart';

class NoInternetController extends GetxController {
  static NoInternetController get instance => Get.find();

  final isRetrying = false.obs;

  /// Static method to navigate to no internet screen
  static void showNoInternetScreen() {
    Get.toNamed(AppRoutes.noInternet);
  }

  /// Check internet connection and navigate back if connection is restored
  Future<void> retryConnection() async {
    isRetrying.value = true;

    try {
      // Wait a moment to show loading state
      await Future.delayed(const Duration(seconds: 1));

      if (await NetworkManager.instance.isConnected()) {
        Loaders.successSnackBar(
          title: 'Connection Restored',
          message: 'Internet connection is back!',
        );
        // Navigate back to previous screen or home
        Get.back();
      } else {
        Loaders.errorSnackBar(
          title: 'Still No Connection',
          message: 'Please check your internet connection and try again.',
        );
      }
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Error',
        message: 'Something went wrong. Please try again.',
      );
    } finally {
      isRetrying.value = false;
    }
  }

  /// Navigate back without checking connection
  void goBack() {
    Get.back();
  }
}
