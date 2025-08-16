import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/features/home/accounts/controller/personal_profile_controller.dart';

class ProfileImg extends StatelessWidget {
  const ProfileImg({super.key, required this.controller});

  final PersonalProfileController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.showImagePickerOptions,
      child: Obx(() {
        final image = controller.profileImage.value;

        return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade300,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child:
              image != null
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.file(image, fit: BoxFit.cover),
                  )
                  : Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(Icons.person, size: 60, color: Colors.grey),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
        );
      }),
    );
  }
}
