import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_app/cores/shared/button_widget.dart';
import 'package:job_app/features/home/accounts/controller/personal_profile_controller.dart';
import 'package:job_app/features/home/accounts/widgets/menu_item.dart';
import 'package:job_app/features/home/accounts/widgets/profile_info.dart';
import 'package:job_app/features/home/accounts/widgets/stat_column.dart';
import 'package:job_app/navigate.dart';
import 'package:job_app/routes/app_routes.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalProfileController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  'account_settings'.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              // ------ Profile Info Section ------
              const SizedBox(height: 16),
              const ProfileInfo(),

              // ------ Stats Section ------
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StatColumn(label: 'applied'.tr, value: '23'),
                    StatColumn(label: 'reviewed'.tr, value: '14'),
                    StatColumn(label: 'accepted'.tr, value: '20'),
                  ],
                ),
              ),

              // ------ menu items ------
              const SizedBox(height: 24),
              MenuItem(
                icon: Iconsax.user,
                title: 'personal_profile'.tr,
                onTap: () => Get.toNamed(AppRoutes.personalProfile),
              ),
              MenuItem(
                icon: Iconsax.lock,
                title: 'change_password'.tr,
                onTap: () => Get.toNamed(AppRoutes.changePassword),
              ),
              MenuItem(
                icon: Iconsax.shopping_bag,
                title: 'job_applied'.tr,
                onTap: () => AppNavigateController.instance.currentIndex(2),
              ),
              MenuItem(
                icon: Iconsax.setting_2,
                title: 'settings'.tr,
                onTap: () {},
              ),

              // -------- Logout Button --------
              const SizedBox(height: 32),
              ButtonWidget(
                width: double.infinity,
                height: 50,
                btnTitle: 'logout'.tr,
                btnBgColor: const Color(0xFFFF4757),
                borderRadius: 15,
                isIcon: true,
                icon: Iconsax.logout,
                onPressed: () => controller.logout(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
