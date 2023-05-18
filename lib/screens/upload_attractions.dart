import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Attraction {
  String id;
  String title;
  String location;
  String categoryId;
  String description;
  String picture;
  String latitude;
  String longitude;

  Attraction({
    required this.id,
    required this.title,
    required this.location,
    required this.categoryId,
    required this.description,
    required this.picture,
    required this.latitude,
    required this.longitude,
  });
}

class UploadAttractions extends StatefulWidget {
  @override
  _UploadAttractionsState createState() => _UploadAttractionsState();
}

class _UploadAttractionsState extends State<UploadAttractions> {
  // Image picker variable declaration
  late XFile pickedImage;
  String selectedImage = '';
  late String selectedImagePath;

// Image Picker Function Logic
  pickImage() async {
    pickedImage = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage.name;
        selectedImagePath = pickedImage.path;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _categoryIdController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Uploading the Image file into Firebase Storage
      firebase_storage.UploadTask uploadTask;
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('attraction')
          .child('/' + pickedImage.name);
      uploadTask = ref.putFile(File(pickedImage.path));
      await uploadTask.whenComplete(() => null);
      String imageUrl = await ref.getDownloadURL();
      print("Uploaded Image Url $imageUrl");

      // Getting started with the firestore database
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final String id = DateTime.now().toString();
      final String title = _titleController.text;
      final String location = _locationController.text;
      final String categoryId = _categoryIdController.text;
      final String description = _descriptionController.text;
      final String picture = imageUrl;
      final String latitude = _latitudeController.text;
      final String longitude = _longitudeController.text;

      final Attraction newAttraction = Attraction(
        id: id,
        title: title,
        location: location,
        categoryId: categoryId,
        description: description,
        picture: picture,
        latitude: latitude,
        longitude: longitude,
      );

      await addAttraction(categoryId, newAttraction);

      // Clear form fields
      _titleController.clear();
      _locationController.clear();
      _categoryIdController.clear();
      _descriptionController.clear();
      _latitudeController.clear();
      _longitudeController.clear();

      // Show success message or navigate to another screen
      // ...
    }
  }

  Future<void> addAttraction(String categoryId, Attraction attraction) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference attractionsCollection =
        firestore.collection('attractions_$categoryId');

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

    await attractionsCollection.doc(attraction.id).set(attractionData);

    print('Attraction data uploaded to Firestore.');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _categoryIdController.dispose();
    _descriptionController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Attraction Sites'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _submitForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a title.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a location.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _categoryIdController,
                decoration: const InputDecoration(labelText: 'Category ID'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a category id.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description.';
                  }
                  if (value.length < 10) {
                    return 'Should be at least 10 characters long.';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: selectedImage.isNotEmpty
                          ? Image.network(
                              selectedImagePath,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "lib/assets/images/no_image.jpg",
                              fit: BoxFit.cover,
                            )),
                  Expanded(
                    child: Container(
                      width: 50,
                      child: ElevatedButton(
                        child: const Text("Pick Image"),
                        onPressed: () {
                          if (true) {
                            setState(() {
                              pickImage();
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _latitudeController,
                decoration: const InputDecoration(labelText: 'Latitude'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a latitude of the attraction site.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _longitudeController,
                decoration: const InputDecoration(labelText: 'Longitude'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a longitude of the attraction site.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
