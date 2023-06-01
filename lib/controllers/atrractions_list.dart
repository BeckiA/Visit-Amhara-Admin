import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/image_strings.dart';
import '../models/attraction.dart';

class AttractionList extends GetxController {
  static AttractionList get instance => Get.find();

  final List<List<Attraction>> _attractionList = [];

  List<List<Attraction>> get attractionItems {
    return [
      ..._attractionList.map((attractions) => [...attractions])
    ];
  }

  // Function to find the attraction by id
  Attraction findAttractionById(String id) {
    for (var attractions in _attractionList) {
      for (var attraction in attractions) {
        if (attraction.id == id) {
          return attraction;
        }
      }
    }
    throw Exception('Attraction not found for id: $id');
  }
}
