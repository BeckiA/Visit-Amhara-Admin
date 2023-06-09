import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class Attraction with ChangeNotifier {
  // String docId;
  final String id;
  final String title;
  final String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final String location;
  final String picture;
  final String description;
  final String categoryId;
  final double latitude;
  final double longitiude;
  bool isFavorite;

  Attraction({
    required this.id,
    required this.title,
    required this.location,
    required this.picture,
    required this.description,
    required this.categoryId,
    required this.latitude,
    required this.longitiude,
    this.isFavorite = false,
    // this.docId = 'null',
  });

  toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'picture': picture,
      'description': description,
      'categoryId': categoryId,
      'latitude': latitude,
      'longitiude': longitiude,
    };
  }

  Future<void> _saveFavoriteStatus() async {
    final box = GetStorage();
    final favorites = box.read<List>('favorites') ?? [];
    if (isFavorite) {
      favorites.add(id);
    } else {
      favorites.remove(id);
    }
    await box.write('favorites', favorites);
  }

  void toggleFavoriteStatus() async {
    isFavorite = !isFavorite;
    await _saveFavoriteStatus();
    notifyListeners();
  }

  factory Attraction.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return Attraction(
        // docId: document.id,
        id: data!['id'],
        title: data['title'],
        location: data['location'],
        picture: data['picture'],
        description: data['description'],
        categoryId: data['categoryId'],
        latitude: data['latitude'],
        longitiude: data['longitiude']);
  }
}
