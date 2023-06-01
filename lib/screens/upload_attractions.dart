import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visit_amhara_admin_app/controllers/atrractions_list.dart';
import 'package:visit_amhara_admin_app/controllers/firestore_queries/attraction_queries.dart';
import 'package:visit_amhara_admin_app/screens/view_attractions.dart';

import '../constants/image_strings.dart';
import '../models/attraction.dart';
import '../controllers/edit_attraction_controllers.dart';
import 'attraction_display.dart';

class UploadAttractions extends StatefulWidget {
  @override
  _UploadAttractionsState createState() => _UploadAttractionsState();
}

class _UploadAttractionsState extends State<UploadAttractions> {
  final _attractionQuery = Get.put(AttractionQuery());
  final editController = Get.put(EditAttractionController());
  // Image picker variable declaration
  String selectedImage = '';
  late String selectedImagePath;
  File? imageFile;
  Uint8List? idInByte;
  bool isFetched = false;
// Image Picker Function Logic
  pickImage() async {
    FilePickerResult? fileResult;
    fileResult = await FilePicker.platform.pickFiles();
    if (fileResult != null) {
      idInByte = fileResult.files.single.bytes;
      selectedImage = fileResult.files.first.name;

      Reference reference = FirebaseStorage.instance
          .ref()
          .child('attractions')
          .child('/ $selectedImage');
      final UploadTask uploadTask = reference.putData(
          idInByte!, SettableMetadata(contentType: 'image/png'));
      await uploadTask.whenComplete(() async {
        String image = await uploadTask.snapshot.ref.getDownloadURL();
        setState(() {
          selectedImagePath = image;
        });
      });
    }

    print('The Selected Image Path $selectedImagePath');
  }

  final _formKey = GlobalKey<FormState>();
  final _attractionIdController = TextEditingController();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _categoryIdController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Uploading the Image file into Firebase Storage

      String imageUrl = selectedImagePath;
      print("Uploaded Image Url $selectedImagePath");

      // Getting started with the firestore database
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final String id = _attractionIdController.text;
      final String title = _titleController.text;
      final String location = _locationController.text;
      final String categoryId = _categoryIdController.text;
      final String description = _descriptionController.text;
      final String picture = imageUrl;
      final double latitude = double.parse(_latitudeController.text);
      final double longitiude = double.parse(_longitudeController.text);

      final Attraction newAttraction = Attraction(
        id: id,
        title: title,
        location: location,
        categoryId: categoryId,
        description: description,
        picture: picture,
        latitude: latitude,
        longitiude: longitiude,
      );

      await AttractionQuery.instance.createAttraction(newAttraction);

      // Clear form fields
      _attractionIdController.clear();
      _titleController.clear();
      _locationController.clear();
      _categoryIdController.clear();
      _descriptionController.clear();
      _latitudeController.clear();
      _longitudeController.clear();

      // Show success message or navigate to another screen
      // ...
      Get.to(ViewAttraction());
    }
  }

  @override
  void dispose() {
    _attractionIdController.dispose();
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
          title: const Text('Upload Attraction Sites'),
          actions: <Widget>[
            TextButton.icon(
              onPressed: () => Get.to(ViewAttraction()),
              icon: Icon(Icons.remove_red_eye),
              label: Text("View Attractions"),
            ),
            SizedBox(width: 10),
            TextButton.icon(
              onPressed: () => Get.to(AttractionDisplay()),
              icon: Icon(Icons.menu),
              label: Text("Main Menu"),
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                        key: _formKey,
                        child: Column(children: [
                          TextFormField(
                            controller: _attractionIdController,
                            decoration: const InputDecoration(
                                labelText: 'Attraction ID'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please provide an attraction id.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _titleController,
                            decoration:
                                const InputDecoration(labelText: 'Title'),
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
                            decoration:
                                const InputDecoration(labelText: 'Location'),
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
                            decoration:
                                const InputDecoration(labelText: 'Category ID'),
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
                            decoration:
                                const InputDecoration(labelText: 'Description'),
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
                                          // isFetched
                                          //     ? attractionData.picture
                                          selectedImagePath,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          VANoImage,
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
                            decoration:
                                const InputDecoration(labelText: 'Latitude'),
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
                            decoration:
                                const InputDecoration(labelText: 'Longitude'),
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
                          const SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                child: const Text("UPLOAD ATTRACTION"),
                                onPressed: () {
                                  _submitForm();
                                }),
                          )
                        ]))
                  ]),
            )));
  }
}
