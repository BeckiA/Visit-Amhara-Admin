import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:visit_amhara_admin_app/screens/attraction.dart';
import 'package:visit_amhara_admin_app/screens/dashboard_screen.dart';
import 'package:visit_amhara_admin_app/screens/settings.dart';
import 'package:visit_amhara_admin_app/screens/users.dart';
import 'package:visit_amhara_admin_app/utils/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DashboardScreen(),
      theme: VAAppTheme.lightTheme,
      darkTheme: VAAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      getPages: [
        GetPage(name: '/', page: () => const DashboardScreen()),
        GetPage(name: '/attraction', page: () => const Attraction()),
        GetPage(
          name: '/users',
          page: () => const Users(),
        ),
        GetPage(name: '/settings', page: () => const Settings()),
      ],
    );
  }
}
