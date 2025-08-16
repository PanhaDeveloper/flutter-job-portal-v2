import 'package:get/get.dart';

class SearchResultController extends GetxController {
  static SearchResultController get instance => Get.find();

  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
