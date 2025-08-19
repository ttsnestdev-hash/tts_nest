import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Widgets/DropdownWigets/dropdown_widgtes.dart';
import '../Controller/leave_controller.dart';

class LeavesScreen extends StatelessWidget {
  const LeavesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeaveRequestController());

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Leave Type Dropdown with CardDropdown
            Obx(() => CardDropdown<String>(
              height: 60,
              hintText: "Select leave type",
              items: controller.leaveTypes
                  .map(
                      (e) => CustDropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                controller.selectedLeaveType.value = val ?? "";
              },
            )),

            const SizedBox(height: 10),

            // From / To Date
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.fromDateCtrl,
                    readOnly: true,
                    decoration: _inputDecoration("From date")
                        .copyWith(suffixIcon: const Icon(Icons.calendar_today)),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                        initialDate: DateTime.now(),
                      );
                      if (picked != null) {
                        controller.fromDateCtrl.text =
                        picked.toString().split(" ")[0];
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: controller.toDateCtrl,
                    readOnly: true,
                    decoration: _inputDecoration("To date")
                        .copyWith(suffixIcon: const Icon(Icons.calendar_today)),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                        initialDate: DateTime.now(),
                      );
                      if (picked != null) {
                        controller.toDateCtrl.text =
                        picked.toString().split(" ")[0];
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.durationCtrl,
              decoration: _inputDecoration("Duration"),
            ),

            const SizedBox(height: 16),

            // Day Type Toggle
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ["Full day", "AN", "FN"]
                  .map((e) => ChoiceChip(
                label: Text(e),
                selected: controller.selectedDayType.value == e,
                onSelected: (_) =>
                controller.selectedDayType.value = e,
                selectedColor: Colors.red,
              ))
                  .toList(),
            )),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.reasonCtrl,
              decoration: _inputDecoration("Reason for leave"),
            ),

            const SizedBox(height: 16),

            // Comp off toggle
            Row(
              children: [
                const Text("Is it a Comp Off?"),
                const SizedBox(width: 12),
                Obx(() => Switch(
                  value: controller.isCompOff.value,
                  onChanged: (val) => controller.isCompOff.value = val,
                )),
              ],
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.empCodeCtrl,
              decoration: _inputDecoration("Employee Code"),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: controller.empNameCtrl,
              decoration: _inputDecoration("Employee Name"),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: controller.phoneCtrl,
              decoration: _inputDecoration("Applicant's phone Number"),
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                onPressed: controller.submitLeave,
                child:
                const Text("SUBMIT", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white, // 🔥 White background
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }
}
