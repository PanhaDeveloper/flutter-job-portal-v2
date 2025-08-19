import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/constants/sizes.dart';
import 'package:job_app/features/personalization/controllers/user_controller.dart';
import 'package:job_app/features/personalization/widgets/profile_picture_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.boldPrimary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => controller.logout(),
            icon: const Icon(Iconsax.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              // Profile Picture
              const ProfilePictureWidget(),
              const SizedBox(height: Sizes.spaceBtwItems),

              // User Details
              Obx(() => Card(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: Sizes.spaceBtwItems),
                      
                      _buildInfoRow('Full Name', controller.user.value.fullName),
                      _buildInfoRow('Username', controller.user.value.username),
                      _buildInfoRow('Email', controller.user.value.email),
                      _buildInfoRow('Phone', controller.user.value.formattedPhoneNo),
                      
                      const SizedBox(height: Sizes.spaceBtwItems),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: Navigate to edit profile screen
                                Get.snackbar(
                                  'Coming Soon',
                                  'Profile editing will be implemented soon.',
                                  backgroundColor: AppColors.boldPrimary,
                                  colorText: Colors.white,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.boldPrimary,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Edit Profile'),
                            ),
                          ),
                          const SizedBox(width: Sizes.spaceBtwInputFields),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => controller.deleteAccountWarningPopup(),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                                side: const BorderSide(color: Colors.red),
                              ),
                              child: const Text('Delete Account'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            child: Text(
              value.isEmpty ? 'Not set' : value,
              style: TextStyle(
                color: value.isEmpty ? Colors.grey : Colors.black,
                fontStyle: value.isEmpty ? FontStyle.italic : FontStyle.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
