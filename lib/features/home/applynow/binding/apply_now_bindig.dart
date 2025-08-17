import 'package:get/get.dart';
import 'package:job_app/features/home/applynow/controller/apply_now_controller.dart';

class ApplyNowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApplyNowController());
  }
}
