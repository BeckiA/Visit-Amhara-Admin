import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:visit_amhara_admin_app/screens/settings.dart';
import 'package:visit_amhara_admin_app/screens/dashboard.dart';
import 'package:visit_amhara_admin_app/screens/users.dart';
import '../constants/colors.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/dashboard_body.dart';
import '../widgets/dashboard_header_widget.dart';
import '../widgets/dashboard_table.dart';
import 'attraction_display.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //setting the expansion function for the navigation rail
  // bool isExpanded = Get.arguments['isExpanded'];
  // bool isExpanded = false;
  var currentIndex = 0;
  final pages = [
    Dashboard(),
    const AttractionDisplay(),
    const Users(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    final isExpandedController = DashboardController.instance.isExpanded.value;

    return Scaffold(
      body: Row(
        children: [
          //Let's start by adding the Navigation Rail
          NavigationRail(
            selectedIndex: currentIndex,
            onDestinationSelected: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            extended: isExpandedController,
            backgroundColor: Colors.deepPurple.shade400,
            unselectedIconTheme:
                const IconThemeData(color: Colors.white, opacity: 1),
            unselectedLabelTextStyle: const TextStyle(
              color: Colors.white,
            ),
            selectedIconTheme: const IconThemeData(color: VAPrimaryColor),
            selectedLabelTextStyle: const TextStyle(
              color: VAPrimaryColor,
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(LineAwesomeIcons.home),
                label: Text("Home"),
              ),
              NavigationRailDestination(
                icon: Icon(LineAwesomeIcons.globe_with_africa_shown),
                label: Text("Attractions"),
              ),
              NavigationRailDestination(
                icon: Icon(LineAwesomeIcons.users),
                label: Text("Profile"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text("Settings"),
              ),
            ],
          ),
          Expanded(
              child: IndexedStack(
            index: currentIndex,
            children: pages,
          )),
        ],
      ),
      //let's add the floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: VAPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
