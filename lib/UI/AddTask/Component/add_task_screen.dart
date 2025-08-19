import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Widgets/custom_button.dart';
import '../../../Widgets/custom_fields.dart';
import '../../../Widgets/customer_dropdown.dart';
import '../Controller/add_task_controller.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddTaskController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Task"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                Obx(() => Checkbox(
                  value: controller.isPublic.value,
                  onChanged: (val) => controller.isPublic.value = val!,
                )),
                const Text("Public"),
                const SizedBox(width: 20),
                Obx(() => Checkbox(
                  value: controller.isBillable.value,
                  onChanged: (val) => controller.isBillable.value = val!,
                )),
                const Text("Billable"),
              ],
            ),

            const SizedBox(height: 10),
            CustomTextField(
              label: "Subject",
              onChanged: (val) => controller.subject.value = val,
            ),

            const SizedBox(height: 10),
            CustomTextField(
              label: "Hourly Rate",
              keyboardType: TextInputType.number,
              onChanged: (val) => controller.hourlyRate.value = double.tryParse(val) ?? 0.0,
            ),

            const SizedBox(height: 10),
            CustomTextField(
              label: "Start Date",
              readOnly: true,
              suffixIcon: const Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (date != null) {
                  controller.startDate.value = date.toIso8601String().split("T").first;
                }
              },
              controllerText: controller.startDate,
            ),

            const SizedBox(height: 10),
            CustomTextField(
              label: "Due Date",
              readOnly: true,
              suffixIcon: const Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (date != null) {
                  controller.dueDate.value = date.toIso8601String().split("T").first;
                }
              },
              controllerText: controller.dueDate,
            ),

            const SizedBox(height: 10),
            Obx(() => CustomDropdown(
              label: "Priority",
              items: controller.priorityList,
              value: controller.selectedPriority.value,
              onChanged: (val) => controller.selectedPriority.value = val!,
            )),
            const SizedBox(height: 10),
            Obx(() => CustomDropdown(
              label: "Related To",
              items: controller.relatedList,
              value: controller.selectedRelated.value,
              onChanged: (val) => controller.selectedPriority.value = val!,
            )),
            const SizedBox(height: 10),
            Obx(() => CustomDropdown(
              label: "Assigned To",
              items: controller.assignedList,
              value: controller.selectedAssigned.value,
              onChanged: (val) => controller.selectedPriority.value = val!,
            )),
            const SizedBox(height: 10),
            Obx(() => CustomDropdown(
              label: "Followers",
              items: controller.followUpList,
              value: controller.selectedFollowUp.value,
              onChanged: (val) => controller.selectedPriority.value = val!,
            )),
            const SizedBox(height: 10),
            CustomTextField(
              label: "Department",
              keyboardType: TextInputType.number,
              onChanged: (val) => controller.hourlyRate.value = double.tryParse(val) ?? 0.0,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              label: "Dev assigned Date",
              readOnly: true,
              suffixIcon: const Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (date != null) {
                  controller.startDate.value = date.toIso8601String().split("T").first;
                }
              },
              controllerText: controller.startDate,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              label: "Close Date",
              readOnly: true,
              suffixIcon: const Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (date != null) {
                  controller.startDate.value = date.toIso8601String().split("T").first;
                }
              },
              controllerText: controller.startDate,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              label: "Issued Date",
              readOnly: true,
              suffixIcon: const Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (date != null) {
                  controller.startDate.value = date.toIso8601String().split("T").first;
                }
              },
              controllerText: controller.startDate,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              label: "Task description",
             // keyboardType: TextInputType.number,
              onChanged: (val) => controller.hourlyRate.value = double.tryParse(val) ?? 0.0,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomButton(
          text: "Save Task",
          onPressed: () {
            Get.snackbar("Success", "Task Saved Successfully",
                snackPosition: SnackPosition.BOTTOM);
          },
        ),
      ),
    );
  }
}
