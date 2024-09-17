import 'package:david_badminton/app/modules/add_student/controllers/add_student_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Đảm bảo đường dẫn đúng

class GenderDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AddStudentController controller = Get.find();

    return Obx(() => DropdownButtonFormField<bool>(
      value: controller.selectedGender.value,
      onChanged: (newValue) {
        if (newValue != null) {
          controller.selectedGender.value = newValue;
        }
      },
      items: controller.genderOptions.entries.map<DropdownMenuItem<bool>>((entry) {
        return DropdownMenuItem<bool>(
          value: entry.value,
          child: Text(entry.key),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Gender',
        border: OutlineInputBorder(),
      ),
    ));
  }
}
