import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quiz_app/features/home/accounts/screens/account_screen.dart';
import 'package:quiz_app/features/home/screen/home_screen.dart';
import 'package:quiz_app/features/home/widgets/custom_navigate.dart';

class AppNavigateController extends GetxController {
  static AppNavigateController get instance => Get.find();
  RxInt selectIndex = 0.obs;
  final List<Widget> screens = [
    const HomeScreen(),
    const Center(child: Text('Favorite Screen')),
    const Center(child: Text('Job Screen')),
    const AccountScreen(),
  ];

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
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomNavigate(
                iconPath: Iconsax.home,
                label: "Home",
                index: 0,
                isSelected: controller.selectIndex.value == 0,
                onTab: () {
                  controller.currentIndex(0);
                },
              ),
              CustomNavigate(
                iconPath: Iconsax.heart,
                label: "Favorite",
                index: 1,
                isSelected: controller.selectIndex.value == 1,
                onTab: () {
                  controller.currentIndex(1);
                },
              ),
              CustomNavigate(
                iconPath: Iconsax.shopping_bag4,
                label: "Job",
                index: 2,
                isSelected: controller.selectIndex.value == 2,
                onTab: () {
                  controller.currentIndex(2);
                },
              ),
              CustomNavigate(
                iconPath: Iconsax.user,
                label: "Profile",
                index: 3,
                isSelected: controller.selectIndex.value == 3,
                onTab: () {
                  controller.currentIndex(3);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
