import 'package:david_badminton/app/modules/add_student/controllers/add_student_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 // Đảm bảo đường dẫn đúng

class ShiftDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AddStudentController controller = Get.find();

    return Obx(() => DropdownButtonFormField<int>(
      value: controller.selectedShift.value,
      onChanged: (newValue) {
        if (newValue != null) {
          controller.selectedShift.value = newValue;
        }
      },
      items: controller.shiftOptions.entries.map<DropdownMenuItem<int>>((entry) {
        return DropdownMenuItem<int>(
          value: entry.value,
          child: Text(entry.key),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Shift',
        border: OutlineInputBorder(),
      ),
    ));
  }
}
