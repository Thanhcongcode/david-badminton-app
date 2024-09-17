import 'package:david_badminton/app/modules/add_student/controllers/add_student_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Đảm bảo đường dẫn đúng

class StatusDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AddStudentController controller = Get.find();

    return Obx(() => DropdownButtonFormField<int>(
      value: controller.selectedStatus.value,
      onChanged: (newValue) {
        if (newValue != null) {
          controller.selectedStatus.value = newValue;
        }
      },
      items: controller.statusOptions.entries.map<DropdownMenuItem<int>>((entry) {
        return DropdownMenuItem<int>(
          value: entry.value,
          child: Text(entry.key),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Status',
        border: OutlineInputBorder(),
      ),
    ));
  }
}
