import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNavigateController extends GetxController {
  static AppNavigateController get instance => Get.find();
  RxInt selectIndex = 0.obs;
  final List<Widget> screens = [];

  void currentIndex(int index) {
    selectIndex.value = index;
  }
}

class AppNavigateBar extends StatelessWidget {
  const AppNavigateBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppNavigateController());
    return Obx(
      () => Scaffold(
        body: controller.screens[controller.selectIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectIndex.value,
          onTap: (index) => controller.currentIndex(index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
