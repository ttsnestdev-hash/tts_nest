import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Drawer Screen
class DrawerScreen extends StatelessWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;

  const DrawerScreen({
    super.key,
    required this.onItemSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Drawer(
        backgroundColor: Colors.grey[200],
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text(
                "Emily Brown",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text("emily.brown@email.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.blue),
              ),
             // decoration: BoxDecoration(color: Colors.blue),
              margin: EdgeInsets.zero,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(context, Icons.home, "Home", 0),
                  const Divider(height: 1, thickness: 0.5),
                  _buildDrawerItem(
                      context, Icons.calendar_today, "Attendance", 1),
                  const Divider(height: 1, thickness: 0.5),
                  _buildDrawerItem(context, Icons.task, "Tasks", 2),
                  const Divider(height: 1, thickness: 0.5),
                  _buildDrawerItem(context, Icons.assignment, "Leaves", 3),
                  const Divider(height: 1, thickness: 0.5),
                  _buildDrawerItem(context, Icons.person, "Profile", 4),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Divider(height: 1, thickness: 0.5),
                  const SizedBox(height: 8),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app, color: Colors.red),
                    title: const Text("Logout",),
                    onTap: () => _confirmLogout(context),
                  ),
                  const Text(
                    "App Version: 1.0.0",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, int index) {
    final isSelected = selectedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.blue : Colors.blue[700],
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey[800],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        minLeadingWidth: 30,
        onTap: () {
          onItemSelected(index);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Get.offAllNamed('/login'),
            child: const Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
