import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visit_amhara_admin_app/controllers/attraction.dart';

class AttractionQuery extends GetxController {
  static AttractionQuery get instance => Get.find();
  // Instantiating the firebase instance
  final _db = FirebaseFirestore.instance;
  createAttraction(Attraction attraction) async {
    await _db
        .collection("Attractions")
        .add(attraction.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Attraction site created successfully",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, StackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }
}
