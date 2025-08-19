import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_app/cores/utils/exceptions/firebase_auth_exceptions.dart' as auth_exceptions;
import 'package:job_app/cores/utils/exceptions/firebase_exceptions.dart' as firebase_exceptions;
import 'package:job_app/cores/utils/exceptions/format_exceptions.dart' as format_exceptions;
import 'package:job_app/features/auth/screen/auth_screen.dart';
import 'package:job_app/features/personalization/controllers/user_controller.dart';
import 'package:job_app/routes/app_routes.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  /// Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  /// Called from main.dart on app launch
  @override
  void onReady() {
    // Remove any loader from splash screen
    screenRedirect();
  }

  /// Function to Show Relevant Screen
  void screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      // If the user is logged in, initialize user data and navigate to home
      if (Get.isRegistered<UserController>()) {
        Get.find<UserController>().fetchUserRecord();
      }
      Get.offAllNamed(AppRoutes.home);
    } else {
      // If user is not logged in, redirect to authentication screen
      Get.offAll(() => const AuthScreen());
    }
  }

  /*------------ Email & Password sign-in -------------*/

  /// [EmailAuthentication] - SignIn
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      
      // Update user data after login
      if (Get.isRegistered<UserController>()) {
        Get.find<UserController>().fetchUserRecord();
      }
      
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
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
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
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
    try {
      // Create a credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

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

  /*------------ Federated identity & Social sign-in -------------*/

  /// [GoogleAuthentication] - GOOGLE
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      // Create a new credential
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential userCredential = await _auth.signInWithCredential(credentials);

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
      throw 'Something went wrong. Please try again';
    }
  }

  /*------------ ./end Federated identity & Social sign-in -------------*/

  /// [LogoutUser] - Valid for any authentication.
  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      Get.offAll(() => const AuthScreen());
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
