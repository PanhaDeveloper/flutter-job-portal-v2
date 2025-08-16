import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static JobDetailController get instance => Get.find();

  late TabController tabController;
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
