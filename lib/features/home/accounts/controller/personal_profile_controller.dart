import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_app/cores/shared/image_source_button.dart';
import 'package:job_app/cores/utils/helpers/network_manager.dart';
import 'package:job_app/cores/utils/popups/alert_dialog.dart';
import 'package:job_app/cores/utils/popups/loaders.dart';

class PersonalProfileController extends GetxController {
  static PersonalProfileController get instance => Get.find();
  final username = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final Rx<File?> profileImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  void showImagePickerOptions() {
    Get.bottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Profile Picture',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ImageSourceButton(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () => pickImage(ImageSource.camera),
                ),
                ImageSourceButton(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () => pickImage(ImageSource.gallery),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final xFile = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      if (xFile != null) {
        profileImage.value = File(xFile.path);

        if (Get.isBottomSheetOpen!) {
          Get.back();
        }
      }
    } catch (e) {
      Loaders.errorSnackBar(
        title: "Error",
        message: "Failed to pick image: ${e.toString()}",
      );
    }
  }

  void logout() async {
    if (!await NetworkManager.instance.isConnected()) {
      Loaders.errorSnackBar(
        title: "Network Error",
        message: "No internet connection.",
      );
      return;
    }

    SweetAlert.show(
      barrierDismissible: true,
      type: SweetAlertType.warning,
      title: "Are you sure?",
      subTitle: "Do you really want to logout?",
      confirmText: "Yes",
      cancelText: "Cancel",
      onConfirm: () {
        // Get.offAllNamed('/login');
      },
      onCancel: () {},
    );
  }

  void saveChange() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (!await NetworkManager.instance.isConnected()) {
      Loaders.errorSnackBar(
        title: "Network Error",
        message: "No internet connection.",
      );
      return;
    }
  }
}
