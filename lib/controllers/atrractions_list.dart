import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/image_strings.dart';
import 'attraction.dart';

class AttractionList extends GetxController {
  static AttractionList get instance => Get.find();

  final List<List<Attraction>> _attractionList = [
    // [
    //   Attraction(
    //     id: "hs-1",
    //     title: "Castle of Gonder",
    //     location: "Gondar",
    //     picture: VACarouselImage2,
    //     description:
    //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    //     categoryId: "hs",
    //     latitude: 12.6099,
    //     longitude: 37.4664,
    //   ),
    //   Attraction(
    //     id: "hs-2",
    //     title: "vhffgejr",
    //     location: "nbjbjnb",
    //     picture: VACarouselImage2,
    //     description:
    //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    //     categoryId: "hs",
    //     latitude: 12.6099,
    //     longitude: 37.4664,
    //   ),
    //   Attraction(
    //     id: "hs-3",
    //     title: "cscss",
    //     location: "sdsdsdsd",
    //     picture: VACarouselImage3,
    //     description:
    //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    //     categoryId: "hs",
    //     latitude: 12.6099,
    //     longitude: 37.4664,
    //   ),
    // ],
    // [
    //   Attraction(
    //     id: "rs-1",
    //     title: "Rock-hewn  churches of Lalibela",
    //     location: "Lalibela",
    //     description:
    //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    //     picture: VACarouselImage1,
    //     categoryId: "rs",
    //     latitude: 12.0359,
    //     longitude: 39.0455,
    //   ),
    //   Attraction(
    //     id: "rs-2",
    //     title: "Rock-hewn churches of Lalibela",
    //     location: "Lalibela",
    //     picture: VACarouselImage1,
    //     description:
    //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    //     categoryId: "rs",
    //     latitude: 12.0359,
    //     longitude: 39.0455,
    //   ),
    //   Attraction(
    //     id: "rs-3",
    //     title: "Rock-hewn churches of Lalibela",
    //     location: "Lalibela",
    //     picture: VACarouselImage1,
    //     description:
    //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    //     categoryId: "rs",
    //     latitude: 12.0359,
    //     longitude: 39.0455,
    //   ),
    // ],
  ];

  List<Attraction> get favoriteItems {
    List<Attraction> favorites = [];
    for (List<Attraction> row in _attractionList) {
      for (Attraction attraction in row) {
        if (attraction.isFavorite) {
          favorites.add(attraction);
        }
      }
    }
    return favorites;
  }

  List<Attraction> getAttractionIndex(int index) {
    switch (index) {
      case 0:
        return [..._attractionList[index]];
      case 1:
        return [..._attractionList[index]];
      default:
        return [];
    }
  }

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

  Future<void> addAttraction(String categoryId, Attraction attraction) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentReference<Map<String, dynamic>> attractionsCollection =
        firestore.collection('Attractions').doc();

    final Map<String, dynamic> attractionData = {
      'id': attraction.id,
      'title': attraction.title,
      'location': attraction.location,
      'picture': attraction.picture,
      'description': attraction.description,
      'categoryId': attraction.categoryId,
      'latitude': attraction.latitude,
      'longitude': attraction.longitude,
    };

    await attractionsCollection.set(attractionData);

    print('Attraction data uploaded to Firestore.');
  }

  Future<void> fetchAndSetAttraction(Attraction attraction) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentReference<Map<String, dynamic>> attractionsCollection =
        firestore.collection('Attractions').doc();

   
// Get the document snapshot
DocumentSnapshot documentSnapshot = await attractionsCollection.get();
    Object data = documentSnapshot.data() as Object;

      final Map<String, dynamic> attractionData = {
      'id': data['id'],
      'title': attraction.title,
      'location': attraction.location,
      'picture': attraction.picture,
      'description': attraction.description,
      'categoryId': attraction.categoryId,
      'latitude': attraction.latitude,
      'longitude': attraction.longitude,
    };
    }

    await attractionsCollection.set(attractionData);

    print('Attraction data uploaded to Firestore.');
  }
}
