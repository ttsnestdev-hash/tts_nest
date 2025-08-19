import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Widgets/DropdownWigets/dropdown_widgtes.dart';
import '../../../Widgets/TextFormFeildWigets/textformfeilds_widgets.dart';
import '../../../Widgets/custom_button.dart';
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
                  borderRadius: 5,
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
                  child: CommonTextField(
                    controller: controller.fromDateCtrl,
                    hintText: "From date",
                    readOnly: true,
                    suffixIcon: const Icon(Icons.calendar_today),
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
                  child: CommonTextField(
                    controller: controller.toDateCtrl,
                    hintText: "To date",
                    readOnly: true,
                    suffixIcon: const Icon(Icons.calendar_today),
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

            CommonTextField(
              controller: controller.durationCtrl,
              hintText: "Duration",
            ),

            const SizedBox(height: 16),
            // Inside your build method
            // Day Type Selector
            Obx(() {
              final options = ["Full day", "AN", "FN"];
              final selected = controller.selectedDayType.value;

              return Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: options.map((option) {
                    final isSelected = selected == option;

                    return Expanded(
                      child: InkWell(
                        onTap: () => controller.selectedDayType.value = option,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.red.shade50
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (isSelected) ...[
                                const Icon(Icons.check,
                                    color: Colors.red, size: 18),
                                const SizedBox(width: 4),
                              ],
                              Text(
                                option,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? Colors.red : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),

            const SizedBox(height: 16),

            CommonTextField(
              controller: controller.reasonCtrl,
              hintText: "Reason for leave",
            ),

            const SizedBox(height: 16),

            CommonTextField(
              controller: controller.empCodeCtrl,
              hintText: "Employee Code",
            ),
            const SizedBox(height: 16),
            CommonTextField(
              controller: controller.empNameCtrl,
              hintText: "Employee Name",
            ),
            const SizedBox(height: 16),
            CommonTextField(
              controller: controller.phoneCtrl,
              hintText: "Applicant's phone Number",
              keyboardType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone),
            ),

            const SizedBox(height: 24),

            CustomButton(
              text: 'SUBMIT',
              onPressed: controller.submitLeave,
            ),
          ],
        ),
      ),
    );
  }
}
