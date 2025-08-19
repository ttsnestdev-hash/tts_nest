import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Controller/attendance_controller.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceController controller = Get.put(AttendanceController());

    return Scaffold(
      body: Obx(
        () {
          DateTime month = controller.selectedMonth.value;
          int daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);

          return Column(
            children: [
              // Month Selector + Calendar

              Card(
                margin: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: controller.toggleExpanded,
                          child: Icon(
                            controller.isExpanded.value
                                ? Icons.expand_less
                                : Icons.expand_more,
                          ),
                        ),
                      ],
                    ),
                    // Month Header
                    InkWell(
                      onTap: controller.toggleExpanded,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: controller.prevMonth,
                              icon: const Icon(Icons.arrow_back_ios, size: 18),
                            ),
                            Text(
                              DateFormat("MMMM yyyy").format(month),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: controller.nextMonth,
                                  icon: const Icon(Icons.arrow_forward_ios,
                                      size: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Expandable Calendar Grid
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      crossFadeState: controller.isExpanded.value
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          childAspectRatio: 1,
                        ),
                        itemCount: daysInMonth,
                        itemBuilder: (context, index) {
                          int day = index + 1;
                          DateTime currentDate =
                              DateTime(month.year, month.month, day);

                          // Defaults
                          Color bgColor = Colors.transparent;
                          Color textColor = Colors.black;

                          // Find all matches for the day
                          final matches = controller.attendanceList.where(
                            (a) =>
                                a.date.year == currentDate.year &&
                                a.date.month == currentDate.month &&
                                a.date.day == currentDate.day,
                          );

                          if (matches.isNotEmpty) {
                            // Pick highest-priority one
                            final match = matches.reduce((a, b) {
                              int aPriority = controller.getPriority(a.status);
                              int bPriority = controller.getPriority(b.status);
                              return (aPriority <= bPriority) ? a : b;
                            });

                            bgColor = controller.getStatusColor(match.status);
                            textColor = (bgColor.computeLuminance() > 0.5)
                                ? Colors.black
                                : Colors.white;
                          }

                          // Today highlight
                          bool isToday =
                              DateUtils.isSameDay(currentDate, DateTime.now());

                          return Tooltip(
                            message: matches.isNotEmpty
                                ? matches
                                    .map((m) =>
                                        "In: ${m.punchIn}, Out: ${m.punchOut}, Hours: ${m.totalHours}")
                                    .join("\n")
                                : "No Data",
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: bgColor,
                                shape: BoxShape.circle,
                                border: isToday
                                    ? Border.all(
                                        color: Colors.blueAccent,
                                        width: 2,
                                      )
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  "$day",
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      secondChild: const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),

              // Attendance List
              Expanded(
                child: ListView.builder(
                  itemCount: controller.sortedAttendanceList.length,
                  itemBuilder: (context, index) {
                    return AttendanceCard(
                      attendance: controller.sortedAttendanceList[index],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AttendanceCard extends StatelessWidget {
  final Attendance attendance;

  const AttendanceCard({super.key, required this.attendance});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AttendanceController>();
    String dayName = DateFormat('EEE').format(attendance.date);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Date & Day
            Container(
              decoration: BoxDecoration(
                color: controller.getStatusColor(attendance.status),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              child: Column(
                children: [
                  Text(
                    DateFormat('dd').format(attendance.date),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    dayName.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),

            // Punch In/Out Info
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Punch In: \n",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: attendance.punchIn ?? "-",
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Punch Out: \n",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: attendance.punchOut ?? "-",
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.red, // you can change the color
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        attendance.totalHours,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const Text(
                        "Total Hours",
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            // Total Hours
          ],
        ),
      ),
    );
  }
}
