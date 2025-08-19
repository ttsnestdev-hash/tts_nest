import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveRequestController extends GetxController {
  // Dropdown
  var leaveTypes = ["Sick Leave", "Casual Leave", "Earned Leave"].obs;
  var selectedLeaveType = "".obs;

  // Date fields
  TextEditingController fromDateCtrl = TextEditingController();
  TextEditingController toDateCtrl = TextEditingController();

  // Other fields
  TextEditingController durationCtrl = TextEditingController();
  TextEditingController reasonCtrl = TextEditingController();
  TextEditingController empCodeCtrl = TextEditingController();
  TextEditingController empNameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();

  // Full Day / AN / FN
  var selectedDayType = "Full day".obs;

  // Comp off
  var isCompOff = false.obs;

  // Submit Function
  void submitLeave() {
    if (selectedLeaveType.isEmpty) {
      Get.snackbar("Error", "Please select leave type");
      return;
    }
    if (fromDateCtrl.text.isEmpty || toDateCtrl.text.isEmpty) {
      Get.snackbar("Error", "Please select dates");
      return;
    }
    if (reasonCtrl.text.isEmpty) {
      Get.snackbar("Error", "Reason is required");
      return;
    }

    // Example collected data
    var data = {
      "leaveType": selectedLeaveType.value,
      "fromDate": fromDateCtrl.text,
      "toDate": toDateCtrl.text,
      "duration": durationCtrl.text,
      "dayType": selectedDayType.value,
      "reason": reasonCtrl.text,
      "compOff": isCompOff.value,
      "employeeCode": empCodeCtrl.text,
      "employeeName": empNameCtrl.text,
      "phone": phoneCtrl.text,
    };

    Get.snackbar("Submitted", data.toString(),
        snackPosition: SnackPosition.BOTTOM);
  }
}
