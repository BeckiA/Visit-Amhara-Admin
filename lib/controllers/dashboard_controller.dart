import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Add your state variables and logic here
  static DashboardController get instance => Get.find();

  Rx<bool> isExpanded = false.obs;
  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }
}
