import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      
      // Refresh social profile picture if user is logged in via social media
      await refreshSocialProfilePicture();
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save user record to Firestore
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // If no record already stored
      if (userCredentials != null) {
        // First check if user already exists in Firestore
        final existingUser = await userRepository.fetchUserDetails();
        
        if (existingUser.id.isEmpty) {
          // New user - create record with social media data
          final nameParts = UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(userCredentials.user!.displayName ?? '');

          // Map Data including profile picture from Google/Facebook
          final newUser = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
            address: '',
          );

          // Save user data
          await userRepository.saveUserRecord(newUser);
          // Update local user object
          user(newUser);
        } else {
          // Existing user - update profile picture if it's from social media and different
          if (userCredentials.user!.photoURL != null && 
              userCredentials.user!.photoURL!.isNotEmpty &&
              existingUser.profilePicture != userCredentials.user!.photoURL) {
            
            // Update profile picture from social media
            await userRepository.updateSingleField({'ProfilePicture': userCredentials.user!.photoURL});
            existingUser.profilePicture = userCredentials.user!.photoURL!;
          }
          // Update local user object
          user(existingUser);
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

  /// Refresh profile picture from Firebase Auth (for social login users)
  Future<void> refreshSocialProfilePicture() async {
    try {
      final currentUser = authRepository.authUser;
      if (currentUser != null && currentUser.photoURL != null && currentUser.photoURL!.isNotEmpty) {
        // Check if the current photoURL is different from stored one
        if (user.value.profilePicture != currentUser.photoURL) {
          await updateProfilePicture(currentUser.photoURL!);
        }
      }
    } catch (e) {
      // Silently handle errors for this background refresh
      print('Error refreshing social profile picture: $e');
    }
  }

  /// Manually fetch and update profile picture from social media accounts
  Future<void> fetchSocialMediaProfilePicture() async {
    try {
      isLoading.value = true;
      final currentUser = authRepository.authUser;
      
      if (currentUser != null) {
        String? newProfilePictureUrl;

        // Check if user is signed in with Google
        final googleSignIn = GoogleSignIn();
        if (await googleSignIn.isSignedIn()) {
          final googleUser = await googleSignIn.signInSilently();
          if (googleUser?.photoUrl != null) {
            newProfilePictureUrl = googleUser!.photoUrl;
          }
        }

        // Check if user is signed in with Facebook
        if (newProfilePictureUrl == null) {
          final accessToken = await FacebookAuth.instance.accessToken;
          if (accessToken != null) {
            try {
              final userData = await FacebookAuth.instance.getUserData(
                fields: 'picture.width(200).height(200)',
              );
              if (userData['picture'] != null && userData['picture']['data'] != null) {
                newProfilePictureUrl = userData['picture']['data']['url'];
              }
            } catch (e) {
              print('Error fetching Facebook profile picture: $e');
            }
          }
        }

        // Update profile picture if found
        if (newProfilePictureUrl != null && newProfilePictureUrl.isNotEmpty) {
          // Update Firebase Auth user profile
          await currentUser.updatePhotoURL(newProfilePictureUrl);
          
          // Update in Firestore and local state
          await updateProfilePicture(newProfilePictureUrl);
          
          Loaders.successSnackBar(
            title: 'Success', 
            message: 'Profile picture updated from your social media account!'
          );
        } else {
          Loaders.warningSnackBar(
            title: 'No Update', 
            message: 'No new profile picture found in your social media accounts.'
          );
        }
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: 'Failed to fetch social media profile picture: ${e.toString()}');
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
