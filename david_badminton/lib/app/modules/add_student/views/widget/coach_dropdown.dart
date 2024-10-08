import 'package:david_badminton/app/modules/add_student/controllers/add_student_controller.dart';
import 'package:david_badminton/common/widgets/dropdown/custom_dropdown.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
// Đảm bảo đường dẫn đúng

class CoachDropdown extends StatelessWidget {
  CoachDropdown({this.isEdit = false, required this.value});
  
  final bool isEdit;
  RxInt? value; // Thay đổi để cho phép giá trị null

  @override
  Widget build(BuildContext context) {
    final AddStudentController controller = Get.find();

    return Obx(() {
      final items = controller.coaches.map((coach) {
        return DropdownMenuItem<int>(
          child: Text(coach.name),
          value: coach.id,
        );
      }).toList();

      return CustomDropdown<int>(
        label: isEdit ? '' : 'Huấn luyện viên',
        prefixIcon: Icons.run_circle_outlined,
        items: items,
        value: value?.value, // Lấy giá trị, có thể là null
        onChanged: (newValue) {
          if (newValue != null) {
            value?.value = newValue; // Cập nhật giá trị nếu không null
          }
        },
        isRequired: isEdit ? false : true,
      );
    });
  }
}