import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class Attraction with ChangeNotifier {
  final String id;
  final String title;
  final String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final String location;
  final String picture;
  final String description;
  final String categoryId;
  final String latitude;
  final String longitude;
  bool isFavorite;

  Attraction({
    required this.id,
    required this.title,
    required this.location,
    required this.picture,
    required this.description,
    required this.categoryId,
    required this.latitude,
    required this.longitude,
    this.isFavorite = false,
  });

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
}
