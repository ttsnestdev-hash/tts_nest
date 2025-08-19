import 'package:flutter/material.dart';

import '../../../Widgets/Appbar/custom_appbar.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(
        title: "Tasks",
        showBack: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

          ],
        ),
      ),
    );
  }
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
