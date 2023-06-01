import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:visit_amhara_admin_app/screens/edit_attractions.dart';
import 'package:visit_amhara_admin_app/screens/login/login_screen.dart';
import 'package:visit_amhara_admin_app/screens/upload_attractions.dart';
import 'firebase_options.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:visit_amhara_admin_app/screens/attraction_display.dart';
import 'package:visit_amhara_admin_app/screens/dashboard_screen.dart';
import 'package:visit_amhara_admin_app/screens/settings.dart';
import 'package:visit_amhara_admin_app/screens/users.dart';
import 'package:visit_amhara_admin_app/utils/themes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      theme: VAAppTheme.lightTheme,
      darkTheme: VAAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      getPages: [
        GetPage(name: '/', page: () => const LoginScreen()),
        GetPage(name: '/attraction', page: () => const AttractionDisplay()),
        GetPage(
          name: '/users',
          page: () => Users(),
        ),
        GetPage(
          name: '/edit-attraction',
          page: () => EditAttractions(),
        ),
        GetPage(
          name: '/upload-attractions',
          page: () => UploadAttractions(),
        ),
        GetPage(
          name: '/settings',
          page: () => UserProfileScreen(),
        ),
      ],
    );
  }
}
