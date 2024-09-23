import 'package:david_badminton/app/modules/add_student/controllers/add_student_controller.dart';
import 'package:david_badminton/common/widgets/dropdown/custom_dropdown.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
// Đảm bảo đường dẫn đúng

class GenderDropdown extends StatelessWidget {
  GenderDropdown({this.isEdit = false, required this.value});
  
  final bool isEdit;
  final RxBool value; // Đảm bảo là RxBool

  @override
  Widget build(BuildContext context) {
    final AddStudentController controller = Get.find();

    return Obx(() {
      final items = controller.genderOptions.entries
          .map<DropdownMenuItem<bool>>((entry) {
        return DropdownMenuItem<bool>(
          value: entry.value,
          child: Text(entry.key),
        );
      }).toList();

      return CustomDropdown<bool>(
        label: isEdit ? '' : 'Giới tính',
        prefixIcon: Icons.transgender,
        items: items,
        value: value.value, // Truyền giá trị của RxBool
        onChanged: (newValue) {
          if (newValue != null) {
            value.value = newValue; // Cập nhật giá trị của RxBool
          }
        },
        isRequired: !isEdit,
      );
    });
  }
}