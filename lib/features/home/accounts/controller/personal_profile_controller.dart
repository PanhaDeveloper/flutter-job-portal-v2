import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_app/cores/data/repositories/authentication/authentication_repository.dart';
import 'package:job_app/cores/data/repositories/user/user_repository.dart';
import 'package:job_app/cores/shared/image_source_button.dart';
import 'package:job_app/cores/utils/helpers/network_manager.dart';
import 'package:job_app/cores/utils/popups/alert_dialog.dart';
import 'package:job_app/cores/utils/popups/loaders.dart';
import 'package:job_app/features/personalization/controllers/user_controller.dart';

class PersonalProfileController extends GetxController {
  static PersonalProfileController get instance => Get.find();
  
  // Dependencies
  final userController = Get.find<UserController>();
  final userRepository = UserRepository.instance;
  
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final Rx<File?> profileImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  final RxBool isLoggingOut = false.obs;
  final RxBool isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    
    // Wait for UserController to be ready before loading data
    Future.delayed(Duration.zero, () {
      if (userController.user.value.id.isNotEmpty) {
        loadUserData();
      } else {
        // If user data is not loaded yet, wait and try again
        userController.fetchUserRecord().then((_) {
          loadUserData();
        });
      }
    });
    
    // Listen to user data changes
    userController.user.listen((user) {
      if (user.id.isNotEmpty) {
        loadUserData();
      }
    });
  }

  /// Load user data from UserController
  void loadUserData() {
    final user = userController.user.value;
    
    // Populate form fields with user data
    firstName.text = user.firstName;
    lastName.text = user.lastName;
    username.text = user.username.replaceFirst('cwt_', ''); // Remove prefix for display
    phone.text = user.phoneNumber;
    email.text = user.email;
    address.text = user.address;
  }

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
        title: 'Error',
        message: 'Failed to pick image: ${e.toString()}',
      );
    }
  }

  void logout() async {
    if (!await NetworkManager.instance.isConnected()) {
      Loaders.errorSnackBar(
        title: 'Network Error',
        message: 'No internet connection.',
      );
      return;
    }

    SweetAlert.show(
      barrierDismissible: true,
      type: SweetAlertType.warning,
      title: 'Are you sure?',
      subTitle: 'Do you really want to logout?',
      confirmText: 'Yes',
      cancelText: 'Cancel',
      onConfirm: () async {
        try {
          isLoggingOut.value = true;
          
          // Close the dialog first
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          
          await AuthenticationRepository.instance.logout();
        } catch (e) {
          // Close any open dialogs first
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          Loaders.errorSnackBar(
            title: 'Logout Error',
            message: e.toString(),
          );
        } finally {
          isLoggingOut.value = false;
        }
      },
      onCancel: () {},
    );
  }

  void saveChange() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (!await NetworkManager.instance.isConnected()) {
      Loaders.errorSnackBar(
        title: 'Network Error',
        message: 'No internet connection.',
      );
      return;
    }

    try {
      isSaving.value = true;

      // Get current user data
      final currentUser = userController.user.value;

      // Create updated user model with new data
      final updatedUser = currentUser.copyWith(
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        phoneNumber: phone.text.trim(),
        address: address.text.trim(),
      );

      // Update user data in Firestore
      await userRepository.updateUserDetails(updatedUser);

      // Update local user data
      userController.user.value = updatedUser;
      userController.user.refresh();

      Loaders.successSnackBar(
        title: 'Success',
        message: 'Profile updated successfully!',
      );
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Update Failed',
        message: e.toString(),
      );
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    firstName.dispose();
    lastName.dispose();
    username.dispose();
    phone.dispose();
    email.dispose();
    address.dispose();
    super.onClose();
  }
}
