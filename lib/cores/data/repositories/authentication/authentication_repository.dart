import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_app/cores/utils/exceptions/firebase_auth_exceptions.dart'
    as auth_exceptions;
import 'package:job_app/cores/utils/exceptions/firebase_exceptions.dart'
    as firebase_exceptions;
import 'package:job_app/cores/utils/exceptions/format_exceptions.dart'
    as format_exceptions;
import 'package:job_app/features/auth/screen/verify_screen.dart';
import 'package:job_app/features/personalization/controllers/user_controller.dart';
import 'package:job_app/routes/app_routes.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  User? get authUser => _auth.currentUser;
  final deviceStorage = GetStorage();

  @override
  void onReady() {
    screenRedirect();
  }

  Future<void> screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      // Initialize UserController if not already done
      if (Get.isRegistered<UserController>()) {
        Get.find<UserController>().fetchUserRecord();
      }

      // Reload user to get the latest email verification status
      await user.reload();
      final updatedUser = _auth.currentUser;

      if (updatedUser != null && updatedUser.emailVerified) {
        // User is authenticated and verified, go to home
        Get.offAllNamed(AppRoutes.home);
      } else {
        // Check if this is a social login user (they don't need email verification)
        bool isSocialLogin = false;
        if (updatedUser != null) {
          for (UserInfo userInfo in updatedUser.providerData) {
            if (userInfo.providerId == 'google.com' || userInfo.providerId == 'facebook.com') {
              isSocialLogin = true;
              break;
            }
          }
        }
        
        if (isSocialLogin) {
          // Social login users don't need email verification
          Get.offAllNamed(AppRoutes.home);
        } else {
          // User is logged in but not verified, go to email verification
          Get.offAll(() => VerifyEmailScreen(email: updatedUser?.email));
        }
      }
    } else {
      print('================= GET STORAGE AUTH REPO ===============');
      print(deviceStorage.read('isFirstTime'));

      deviceStorage.writeIfNull('isFirstTime', true);
      // User is not logged in, check if first time or not
      deviceStorage.read('isFirstTime') != true
          ? Get.offAllNamed(AppRoutes.auth)
          : Get.offAllNamed(AppRoutes.onboarding);
    }
  }

  /*------------ Email & Password sign-in -------------*/

  /// [EmailAuthentication] - SignIn
  Future<UserCredential> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user data after login
      // if (Get.isRegistered<UserController>()) {
      //   Get.find<UserController>().fetchUserRecord();
      // }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw auth_exceptions.FirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw firebase_exceptions.FirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const format_exceptions.FormatException();
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw auth_exceptions.FirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw firebase_exceptions.FirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const format_exceptions.FormatException();
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailVerification] - MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw auth_exceptions.FirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw firebase_exceptions.FirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const format_exceptions.FormatException();
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailAuthentication] - FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw auth_exceptions.FirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw firebase_exceptions.FirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const format_exceptions.FormatException();
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [ReAuthenticate] - ReAuthenticate User
  Future<void> reAuthenticateWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      // Create a credential
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      // ReAuthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw auth_exceptions.FirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw firebase_exceptions.FirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const format_exceptions.FormatException();
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [ChangePassword] - Update User Password
  Future<void> updatePassword(String newPassword) async {
    try {
      await _auth.currentUser!.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw auth_exceptions.FirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw firebase_exceptions.FirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const format_exceptions.FormatException();
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /*------------ Federated identity & Social sign-in -------------*/

  /// [GoogleAuthentication] - GOOGLE
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      // Create a new credential
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential userCredential = await _auth.signInWithCredential(
        credentials,
      );

      // Save user data using UserController if this is a new user or fetch existing data
      if (Get.isRegistered<UserController>()) {
        final userController = Get.find<UserController>();
        await userController.saveUserRecord(userCredential);
        await userController.fetchUserRecord();
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw auth_exceptions.FirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw firebase_exceptions.FirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const format_exceptions.FormatException();
    } catch (e) {
      throw e.toString();
    }
  }

  /// [FacebookAuthentication] - FACEBOOK
  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Trigger the authentication flow
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        // Get additional user data from Facebook to get high-quality profile picture
        final userData = await FacebookAuth.instance.getUserData(
          fields: 'name,email,picture.width(200).height(200)',
        );

        // Create a credential from the access token
        final OAuthCredential credential = FacebookAuthProvider.credential(
          result.accessToken!.tokenString,
        );

        // Once signed in, return the UserCredential
        final UserCredential userCredential = await _auth.signInWithCredential(
          credential,
        );

        // Update the user's photo URL with high-quality Facebook picture
        if (userData['picture'] != null && userData['picture']['data'] != null) {
          final highQualityPhotoURL = userData['picture']['data']['url'];
          if (highQualityPhotoURL != null) {
            // Update the Firebase user profile with the high-quality picture
            await userCredential.user?.updatePhotoURL(highQualityPhotoURL);
          }
        }

        // Save user data using UserController if this is a new user or fetch existing data
        if (Get.isRegistered<UserController>()) {
          final userController = Get.find<UserController>();
          await userController.saveUserRecord(userCredential);
          await userController.fetchUserRecord();
        }

        return userCredential;
      } else {
        throw 'Facebook sign-in was cancelled or failed: ${result.message}';
      }
    } on FirebaseAuthException catch (e) {
      throw auth_exceptions.FirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw firebase_exceptions.FirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const format_exceptions.FormatException();
    } catch (e) {
      print('Facebook sign-in error: $e');
      throw 'Something went wrong. Please try again: ${e.toString()}';
    }
  }

  /*------------ ./end Federated identity & Social sign-in -------------*/

  /// [LogoutUser] - Valid for any authentication.
  Future<void> logout() async {
    try {
      // Check if user is currently authenticated
      if (_auth.currentUser == null) {
        // User is already logged out, just navigate to auth screen
        Get.offAllNamed(AppRoutes.auth);
        return;
      }

      // Sign out from Google if signed in
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

      // Sign out from Facebook if signed in
      await FacebookAuth.instance.logOut();

      // Sign out from Firebase
      await _auth.signOut();

      // Clear any stored user data
      final storage = GetStorage();
      await storage.erase();

      // Clear any GetX controllers that might hold user data
      Get.delete<UserController>(force: true);

      print('AuthMiddleware: User logged out');

      Get.offAllNamed(AppRoutes.auth);
    } on FirebaseAuthException catch (e) {
      throw auth_exceptions.FirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw firebase_exceptions.FirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const format_exceptions.FormatException();
    } catch (e) {
      print(e.toString());
      throw 'Something went wrong. Please try again';
    }
  }

  /// DELETE USER - Remove user Auth and Firestore Account.
  Future<void> deleteAccount() async {
    try {
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw auth_exceptions.FirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw firebase_exceptions.FirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const format_exceptions.FormatException();
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
