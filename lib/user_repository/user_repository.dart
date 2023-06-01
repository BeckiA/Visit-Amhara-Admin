import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<String> getUsername(String email) async {
    final snapshot =
        await _db.collection("Admin").where("email", isEqualTo: email).get();

    if (snapshot.docs.isEmpty) {
      throw Exception("No user found with this email $email");
    }

    if (snapshot.docs.length > 1) {
      throw Exception("Multiple users found with this email $email");
    }

    final userData = snapshot.docs.single.data();
    final username = userData['userName'];

    return username;
  }
}
