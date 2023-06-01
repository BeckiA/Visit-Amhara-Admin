import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/dashboard_body.dart';
import '../widgets/dashboard_header_widget.dart';
import '../widgets/dashboard_table.dart';

class Dashboard extends GetView<DashboardController> {
  // const Test({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    final dashboardController = DashboardController.instance;
    return Padding(
      padding: const EdgeInsets.all(60.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //let's add the navigation menu for this project
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => IconButton(
                    onPressed: () {
                      //let's trigger the navigation expansion
                      dashboardController.toggleExpansion();
                    },
                    icon: Icon(dashboardController.isExpanded.value
                        ? Icons.close
                        : Icons.menu),
                  ),
                ),
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://faces-img.xcdn.link/image-lorem-face-3430.jpg"),
                  radius: 26.0,
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            //Now let's start with the dashboard main rapports
            DashboardHeader(),
            //Now let's set the article section
            const SizedBox(
              height: 30.0,
            ),
            const DashboardBody(),
            const SizedBox(
              height: 40.0,
            ),
            //Now let's add the Table
            const DashboardTable()
          ],
        ),
      ),
    );
  }
}
