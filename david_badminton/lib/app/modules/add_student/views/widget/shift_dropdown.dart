import 'package:david_badminton/app/modules/add_student/controllers/add_student_controller.dart';
import 'package:david_badminton/common/widgets/dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class ShiftDropdown extends StatelessWidget {
  ShiftDropdown({this.isEdit = false});
  final bool isEdit;
  @override
  Widget build(BuildContext context) {
    final AddStudentController controller = Get.find();

    return Obx(() {
      final items =
          controller.shiftOptions.entries.map<DropdownMenuItem<int>>((entry) {
        return DropdownMenuItem<int>(
          value: entry.value,
          child: Text(entry.key),
        );
      }).toList();

      return CustomDropdown<int>(
        label: isEdit ? '' : 'Ca học',
        prefixIcon: Icons.schedule,
        items: items,
        value: controller.selectedShift.value,
        onChanged: (newValue) {
          if (newValue != null) {
            controller.selectedShift.value = newValue;
          }
        },
      );
    });
  }
}