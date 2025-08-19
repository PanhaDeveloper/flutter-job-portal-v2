import 'package:get/get.dart';
import 'package:job_app/cores/utils/helpers/network_manager.dart';
import 'package:job_app/routes/app_routes.dart';

class GeneralRepo extends GetxController {
  static GeneralRepo get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    try {
      final connected = await NetworkManager.instance.isConnected();
      if (!connected) {
        Get.offNamed(AppRoutes.noInternet);
      }
    } catch (e) {
      Get.offNamed(AppRoutes.noInternet);
    }
  }
}
