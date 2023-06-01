import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visit_amhara_admin_app/authentication_repository/authentication_repository.dart';

import '../screens/dashboard_screen.dart';
import '../user_repository/user_repository.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();
  // Create a reference to the Firestore collection where user data is stored
  final _usersCollection = FirebaseFirestore.instance.collection('Admin');
  final _auth = FirebaseAuth.instance;
  final _userRepo = Get.put(UserRepository());
  final _authRepo = Get.put(AuthenticationRepository());
  String userName = '';

  // TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();

  Future<List<String>> getUserEmails(String email) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('Admin')
        .where('email', isEqualTo: email)
        .get();

    List<String> emails = [];
    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        emails.add(doc.data()['email']);
      }
    }

    return emails;
  }

  // Example usage in login screen:
  void onLoginPressed(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var querySnapshot = await FirebaseFirestore.instance
            .collection('Admin')
            .where('email', isEqualTo: email)
            .get();
        var name = querySnapshot.docs[0].data()["fullName"];
        print(name);
        prefs.setString("displayName", name.toString());
        prefs.setString("displayEmail", credential.user!.email.toString());
      }

      List<String> matchingEmails = await getUserEmails(email);

      userName = await UserRepository.instance.getUsername(email);
      if (matchingEmails.isEmpty) {
        // Show error message to user that their account is no longer active
        Get.snackbar("Failed to Login", "Account does not Exist",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red);
      } else {
        final credentialEmail = credential.user!.email;

        if (matchingEmails[0] == credentialEmail) {
          Get.to(() => DashboardScreen());
        } else {
          //  Show error message to user that their account is no longer active
          Get.snackbar("Failed to Login", "Account does not exist",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.redAccent.withOpacity(0.1),
              colorText: Colors.red);
        }
      }
    } on Exception catch (e) {
      // TODO
      print(e);
      Get.snackbar("Something Unusual Occurs", "Message- ${e}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }
}
