import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// --------------------
/// MODEL
/// --------------------
class Attendance {
  final DateTime date;
  final String punchIn;
  final String punchOut;
  final String totalHours;
  final String status; // success, warning, danger, holiday

  Attendance({
    required this.date,
    required this.punchIn,
    required this.punchOut,
    required this.totalHours,
    required this.status,
  });
}

/// --------------------
/// CONTROLLER
/// --------------------
class AttendanceController extends GetxController {
  var selectedMonth = DateTime.now().obs;
  var isExpanded = true.obs;

  var attendanceList = <Attendance>[
    Attendance(
      date: DateTime(2025, 8, 8),
      punchIn: "09:08 AM",
      punchOut: "06:05 PM",
      totalHours: "08:13",
      status: "success",
    ),
    Attendance(
      date: DateTime(2025, 8, 6),
      punchIn: "09:08 AM",
      punchOut: "06:05 PM",
      totalHours: "08:13",
      status: "holiday",
    ),
    Attendance(
      date: DateTime(2025, 8, 15),
      punchIn: "-",
      punchOut: "-",
      totalHours: "-",
      status: "danger",
    ),
    Attendance(
      date: DateTime(2025, 8, 5),
      punchIn: "10:00 AM",
      punchOut: "05:00 PM",
      totalHours: "07:00",
      status: "warning",
    ),
  ];

  /// Priority: success > warning > danger > holiday > others
  final Map<String, int> _statusPriority = {
    "success": 1,
    "warning": 2,
    "danger": 3,
    "holiday": 4,
  };

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  /// Map status to colors
  Color getStatusColor(String status) {
    switch (status) {
      case "success":
        return Colors.green;
      case "warning":
        return Colors.orange;
      case "danger":
        return Colors.red;
      case "holiday":
        return Colors.yellow.shade700;
      default:
        return Colors.grey.shade400;
    }
  }

  int getPriority(String status) {
    return _statusPriority[status] ?? 99;
  }

  List<Attendance> get sortedAttendanceList {
    List<Attendance> sorted = List.from(attendanceList);
    sorted.sort((a, b) {
      int aPriority = getPriority(a.status);
      int bPriority = getPriority(b.status);
      return aPriority.compareTo(bPriority);
    });
    return sorted;
  }

  void nextMonth() {
    selectedMonth.value =
        DateTime(selectedMonth.value.year, selectedMonth.value.month + 1, 1);
  }

  void prevMonth() {
    selectedMonth.value =
        DateTime(selectedMonth.value.year, selectedMonth.value.month - 1, 1);
  }
}
