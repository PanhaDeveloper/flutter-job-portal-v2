import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/data/models/user_model.dart';
import 'package:job_app/cores/data/repositories/authentication/authentication_repository.dart';
import 'package:job_app/cores/data/repositories/user/user_repository.dart';
import 'package:job_app/cores/utils/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = UserRepository.instance;
  final authRepository = AuthenticationRepository.instance;

  // Observable user data
  Rx<UserModel> user = UserModel.empty().obs;
  final isLoading = false.obs;
  final profileLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  /// Fetch user record from Firestore
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save user record to Firestore
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // Refresh user record
      await fetchUserRecord();

      // If no record already stored
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convert Name to First and Last Name
          final nameParts = UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(userCredentials.user!.displayName ?? '');

          // Map Data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          // Save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      Loaders.warningSnackBar(
        title: 'Data not saved',
        message: 'Something went wrong while saving your information. You can re-save your data in your Profile.',
      );
    }
  }

  /// Delete account warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(20),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
        child: const Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text('Delete')),
      ),
      cancel: OutlinedButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }

  /// Delete user account
  Future<void> deleteUserAccount() async {
    try {
      isLoading.value = true;
      
      // First delete the user's Firestore document
      await userRepository.removeUserRecord(authRepository.authUser!.uid);
      
      // Then delete the user's authentication record
      await authRepository.deleteAccount();
      
      isLoading.value = false;
      
      Loaders.successSnackBar(title: 'Success', message: 'Your account has been deleted successfully!');
      
      // Close dialog and navigate to auth screen
      Get.back();
    } catch (e) {
      isLoading.value = false;
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  /// Update user profile picture
  Future<void> updateProfilePicture(String imageUrl) async {
    try {
      isLoading.value = true;

      // Update user's profile picture URL in Firestore
      await userRepository.updateSingleField({'ProfilePicture': imageUrl});

      // Update local user object
      user.value.profilePicture = imageUrl;
      user.refresh();

      Loaders.successSnackBar(title: 'Success', message: 'Profile picture updated successfully!');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      await authRepository.logout();
      user(UserModel.empty());
      Loaders.successSnackBar(
        title: 'Success',
        message: 'You have been logged out successfully.',
      );
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Error',
        message: e.toString(),
      );
    }
  }
}
