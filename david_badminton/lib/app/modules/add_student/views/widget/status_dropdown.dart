import 'package:david_badminton/app/modules/add_student/controllers/add_student_controller.dart';
import 'package:david_badminton/common/widgets/dropdown/custom_dropdown.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// Đảm bảo đường dẫn đúng

class StatusDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AddStudentController controller = Get.find();

    return Obx(() {
      final items =
          controller.statusOptions.entries.map<DropdownMenuItem<int>>((entry) {
        return DropdownMenuItem<int>(
          value: entry.value,
          child: Text(entry.key),
        );
      }).toList();

      return CustomDropdown<int>(
        label: 'Trạng thái',
        prefixIcon: Icons.schedule,
        items: items,
        value: controller.selectedStatus.value,
        onChanged: (newValue) {
          if (newValue != null) {
            controller.selectedStatus.value = newValue;
          }
        },
      );
    });
  }
}
