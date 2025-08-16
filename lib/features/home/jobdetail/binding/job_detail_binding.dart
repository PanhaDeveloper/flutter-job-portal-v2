import 'package:get/get.dart';
import 'package:job_app/features/home/jobdetail/controller/job_detail_controller.dart';

class JobDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JobDetailController());
  }
}
