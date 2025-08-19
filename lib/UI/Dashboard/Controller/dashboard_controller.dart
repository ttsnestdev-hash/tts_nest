import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  final pages = [
    const Center(child: Text("Dashboard Home")),
    const Center(child: Text("Attendance Page")),
    const Center(child: Text("Tasks Page")),
    const Center(child: Text("Leaves Page")),
    const Center(child: Text("Profile Page")),
  ];

  void changePage(int index) {
    selectedIndex.value = index;
  }

  Future<bool> onWillPop() async {
    if (selectedIndex.value != 0) {
      selectedIndex.value = 0; // go back to home
      return false;
    } else {
      return await Get.dialog(
            AlertDialog(
              title: const Text("Exit App"),
              content: const Text("Do you really want to exit?"),
              actions: [
                TextButton(
                    onPressed: () => Get.back(result: false),
                    child: const Text("No")),
                TextButton(
                    onPressed: () => Get.back(result: true),
                    child: const Text("Yes")),
              ],
            ),
          ) ??
          false;
    }
  }
}
