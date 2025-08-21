import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/constants/image_strings.dart';
import 'package:job_app/features/personalization/controllers/user_controller.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Center(
      child: Obx(() {
        final imageUrl = controller.user.value.profilePicture;
        return Stack(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(width: 4, color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 10),
                  )
                ],
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: imageUrl.isNotEmpty
                    ? FadeInImage.assetNetwork(
                        placeholder: Images.profileImage,
                        image: imageUrl,
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            Images.profileImage,
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                          );
                        },
                      )
                    : Image.asset(
                        Images.profileImage,
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                      ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => _showImageSourceDialog(context, controller),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(width: 4, color: Colors.white),
                    borderRadius: BorderRadius.circular(35),
                    color: AppColors.boldPrimary,
                  ),
                  child: const Icon(
                    Iconsax.camera,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  void _showImageSourceDialog(BuildContext context, UserController controller) {
    Get.dialog(
      AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Iconsax.camera),
              title: const Text('Camera'),
              onTap: () {
                Get.back();
                // TODO: Implement camera image picking
                _showComingSoonDialog();
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.gallery),
              title: const Text('Gallery'),
              onTap: () {
                Get.back();
                // TODO: Implement gallery image picking
                _showComingSoonDialog();
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.refresh, color: Colors.blue),
              title: const Text('Refresh from Social Media'),
              onTap: () {
                Get.back();
                controller.fetchSocialMediaProfilePicture();
              },
            ),
            if (controller.user.value.profilePicture.isNotEmpty)
              ListTile(
                leading: const Icon(Iconsax.trash, color: Colors.red),
                title: const Text('Remove Picture', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Get.back();
                  controller.updateProfilePicture('');
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showComingSoonDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Coming Soon'),
        content: const Text('Image upload functionality will be implemented soon. For now, you can test with Google Sign-In which automatically sets profile pictures.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
