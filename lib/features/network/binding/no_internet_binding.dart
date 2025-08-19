import 'package:get/get.dart';
import 'package:job_app/features/network/controller/no_internet_controller.dart';

class NoInternetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoInternetController>(() => NoInternetController());
  }
}
