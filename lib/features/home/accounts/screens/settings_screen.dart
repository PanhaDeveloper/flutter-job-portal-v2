import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_app/cores/shared/app_bar_widget.dart';
import 'package:job_app/features/home/accounts/widgets/menu_item.dart';
import 'package:job_app/features/security/screens/security_setup_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'settings'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              
              // Language Settings Section
              Text(
                'language_settings'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              MenuItem(
                icon: Iconsax.language_square,
                title: 'change_language'.tr,
                onTap: () {
                  Get.snackbar(
                    'settings'.tr,
                    'language_change_coming_soon'.tr,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
              
              const SizedBox(height: 24),
              
              // Notification Settings Section
              Text(
                'notification_settings'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              MenuItem(
                icon: Iconsax.notification,
                title: 'push_notifications'.tr,
                onTap: () {
                  Get.snackbar(
                    'settings'.tr,
                    'notification_settings_coming_soon'.tr,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
              MenuItem(
                icon: Iconsax.sms_notification,
                title: 'email_notifications'.tr,
                onTap: () {
                  Get.snackbar(
                    'settings'.tr,
                    'email_notification_settings_coming_soon'.tr,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
              
              const SizedBox(height: 24),
              
              // Security Settings Section
              Text(
                'security_settings'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              MenuItem(
                icon: Iconsax.shield_security,
                title: 'app_security'.tr,
                onTap: () {
                  Get.to(() => const SecuritySetupScreen());
                },
              ),
              
              const SizedBox(height: 24),
              
              // Privacy Settings Section
              Text(
                'privacy_settings'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              MenuItem(
                icon: Iconsax.shield_security,
                title: 'privacy_policy'.tr,
                onTap: () {
                  Get.snackbar(
                    'settings'.tr,
                    'privacy_policy_coming_soon'.tr,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
              MenuItem(
                icon: Iconsax.document_text,
                title: 'terms_conditions'.tr,
                onTap: () {
                  Get.snackbar(
                    'settings'.tr,
                    'terms_conditions_coming_soon'.tr,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
              
              const SizedBox(height: 24),
              
              // App Settings Section
              Text(
                'app_settings'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              MenuItem(
                icon: Iconsax.information,
                title: 'about_app'.tr,
                onTap: () {
                  Get.snackbar(
                    'settings'.tr,
                    'about_app_coming_soon'.tr,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
              MenuItem(
                icon: Iconsax.refresh_2,
                title: 'app_version'.tr,
                onTap: () {
                  Get.snackbar(
                    'app_version'.tr,
                    'current_version_1_0_0'.tr,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
