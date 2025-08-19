import 'package:flutter/material.dart';

import '../../../Widgets/quick_access_card.dart';

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --- TOP CHECKIN / CHECKOUT SECTION ---
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: const Offset(0, 1),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Column(
                    children: [
                      Text(
                        "Check in",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "09:00:00",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  _divider(),
                  const Column(
                    children: [
                      Text(
                        "Check out",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "00:00:00",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.fingerprint, size: 28, color: Colors.green),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// --- TASK STATS ROW ---
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: const Offset(0, 1),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statCard("10", "Not started"),
                  _divider(),
                  _statCard("6", "In progress"),
                  _divider(),
                  _statCard("8", "Testing"),
                  _divider(),
                  _statCard("77", "Feedback"),
                  _divider(),
                  _statCard("100", "Done"),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// --- ACTION BUTTONS ---
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "NEW TASK",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "OVERVIEW",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// --- ASSIGNED TASKS TITLE ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Assigned task",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Icon(Icons.filter_list, color: Colors.black54),
              ],
            ),
            const SizedBox(height: 10),

            /// --- SAMPLE TASKS ---
            _taskCard(
              priority: "High",
              priorityColor: Colors.red,
              taskNo: "4323",
              taskName: "Build full garment app",
              date: "12-08-25 to 14-08-25",
              assignedTo: "alan, hari, mani",
              status: "in progress",
            ),
            const SizedBox(height: 12),
            _taskCard(
              priority: "Low",
              priorityColor: Colors.orange,
              taskNo: "4323",
              taskName: "Build full garment app",
              date: "12-08-25 to 14-08-25",
              assignedTo: "alan, hari, mani",
              status: "in progress",
            ),

            const SizedBox(height: 20),

            /// --- QUICK ACCESS GRID ---
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.5,
              children: const [
                QuickAccessCard(
                    icon: Icons.calendar_today, title: "Attendance"),
                QuickAccessCard(icon: Icons.task, title: "Tasks"),
                QuickAccessCard(icon: Icons.assignment, title: "Leaves"),
                QuickAccessCard(icon: Icons.inventory, title: "Assets"),
                QuickAccessCard(icon: Icons.money, title: "Expenses"),
                QuickAccessCard(icon: Icons.person, title: "Profile"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// --- STAT CARD WIDGET ---
  Widget _statCard(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10, color: Colors.black54),
        ),
      ],
    );
  }

  /// Divider between stat cards
  Widget _divider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.grey[300],
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  /// --- TASK CARD WIDGET ---
  Widget _taskCard({
    required String priority,
    required Color priorityColor,
    required String taskNo,
    required String taskName,
    required String date,
    required String assignedTo,
    required String status,
  }) {
    Color getStatusColor(String status) {
      switch (status.toLowerCase()) {
        case "in progress":
          return Colors.green;
        case "completed":
          return Colors.blue;
        case "pending":
          return Colors.orange;
        default:
          return Colors.red;
      }
    }

    Widget _row(String title, String value, {Color? valueColor}) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              title,
              style: TextStyle(color: Colors.grey[700], fontSize: 12),
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: valueColor ?? Colors.black,
              ),
            ),
          ),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, offset: Offset(0, 1), blurRadius: 3)
        ],
        border: Border(
          left: BorderSide(color: priorityColor, width: 4),
          right: BorderSide(color: priorityColor, width: 4),
        ),
      ),
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Priority Badge
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: priorityColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                priority,
                style: TextStyle(
                    color: priorityColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 9),
              ),
            ),
          ),
          const SizedBox(height: 6),
          _row("Task No", taskNo),
          const SizedBox(height: 4),
          _row("Task Name", taskName),
          const SizedBox(height: 4),
          _row("Date", date),
          const SizedBox(height: 4),
          _row("Assigned to", assignedTo),
          const SizedBox(height: 6),
          _row("Status", status, valueColor: getStatusColor(status)),
        ],
      ),
    );
  }
}
