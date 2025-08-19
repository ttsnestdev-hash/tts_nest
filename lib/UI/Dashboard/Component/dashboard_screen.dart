import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Widgets/Drawer/drawer_screen.dart';
import '../../Attendance/Component/attendance_screen.dart';
import '../../Home/Component/home_screen.dart';
import '../../Leaves/Component/leaves_screen.dart';
import '../../Profile/Component/profile_screen.dart';
import '../../Tasks/Component/tasks_screen.dart';
import '../Controller/dashboard_controller.dart';

// Dashboard Screen
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.put(DashboardController());

    final List<Widget> pages = [
      const DashboardHome(),
      const AttendanceScreen(),
      const TasksScreen(),
      const LeavesScreen(),
      const ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            title: const Text("Dashboard"),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              )
            ],
          ),
          drawer: DrawerScreen(
            onItemSelected: controller.changePage,
            selectedIndex: controller.selectedIndex.value,
          ),
          body: pages[controller.selectedIndex.value],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    context,
                    icon: Icons.home,
                    label: "Home",
                    isActive: controller.selectedIndex.value == 0,
                    onTap: () => controller.changePage(0),
                  ),
                  _buildNavItem(
                    context,
                    icon: Icons.calendar_today,
                    label: "Attendance",
                    isActive: controller.selectedIndex.value == 1,
                    onTap: () => controller.changePage(1),
                  ),
                  _buildNavItem(
                    context,
                    icon: Icons.task,
                    label: "Tasks",
                    isActive: controller.selectedIndex.value == 2,
                    onTap: () => controller.changePage(2),
                  ),
                  _buildNavItem(
                    context,
                    icon: Icons.assignment,
                    label: "Leaves",
                    isActive: controller.selectedIndex.value == 3,
                    onTap: () => controller.changePage(3),
                  ),
                  _buildNavItem(
                    context,
                    icon: Icons.person,
                    label: "Profile",
                    isActive: controller.selectedIndex.value == 4,
                    onTap: () => controller.changePage(4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            decoration: BoxDecoration(
              color:
                  isActive ? Colors.blue.withOpacity(0.2) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.blue : Colors.grey,
              size: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.blue : Colors.grey,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
