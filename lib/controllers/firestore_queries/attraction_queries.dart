import 'dart:math';

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

  Future<Attraction> getAttraction(String attractionId) async {
    final snapshot = await _db
        .collection("Attractions")
        .where("id", isEqualTo: attractionId)
        .get();
    if (snapshot.docs.isEmpty) {
      print(Exception(
          "No attraction found with this attraction id $attractionId"));
    }
    if (snapshot.docs.length > 1) {
      print(throw Exception(
          "Multiple attractions found with this attraction id $attractionId"));
    }
    final attractData = Attraction.fromSnapshot(snapshot.docs.single);
    return attractData;
  }

  Future<List<Attraction>> allAttractionData() async {
    final snapshot = await _db.collection("Attractions").get();
    final attractionData =
        snapshot.docs.map((e) => Attraction.fromSnapshot((e))).toList();
    return attractionData;
  }

  Future<void> updateAttractionRecord(Attraction attraction) async {
    var querySnapshot = await _db
        .collection("Attractions")
        .where("id", isEqualTo: attraction.id)
        .get();

    var documentSnapshot = querySnapshot.docs.first;
    await documentSnapshot.reference
        .update(attraction.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Attraction site updated successfully",
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
