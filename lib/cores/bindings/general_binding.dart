import 'package:get/get.dart';
import 'package:job_app/cores/data/repositories/authentication/authentication_repository.dart';
import 'package:job_app/cores/data/repositories/user/user_repository.dart';
import 'package:job_app/cores/utils/helpers/network_manager.dart';
import 'package:job_app/features/personalization/controllers/user_controller.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(AuthenticationRepository());
    Get.put(UserRepository());
    Get.put(UserController());
  }
}
