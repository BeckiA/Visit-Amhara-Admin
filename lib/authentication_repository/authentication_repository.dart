import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../exceptions/signup_email_password_failure.dart';
import '../screens/dashboard_screen.dart';
import '../screens/login/login_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final _auth = FirebaseAuth.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitalScreen);
  }

  _setInitalScreen(User? user) {
    user != null
        ? Get.offAll(() => DashboardScreen())
        : Get.offAll(() => LoginScreen());
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => DashboardScreen())
          : Get.to(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION -${ex.message}');
      // Write the error code with snackbars here using Get.Snackbars("Message here more on screen shots")
      throw ex;
    }
  }

// Function to clear shared preferences data
  void clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> logout() async {
    clearSharedPreferences();
    await _auth.signOut();
    Get.to(LoginScreen());
  }
}
