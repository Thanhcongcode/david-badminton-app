import 'package:david_badminton/app/modules/add_student/controllers/add_student_controller.dart';
import 'package:david_badminton/common/widgets/dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StatusDropdown extends StatelessWidget {
  StatusDropdown({this.isEdit = false, required this.value});
  final bool isEdit;
  final RxInt value; // Đảm bảo value không phải là nullable

  @override
  Widget build(BuildContext context) {
    final AddStudentController controller = Get.find();

    return Obx(() {
      final items = controller.statusOptions.entries
          .map<DropdownMenuItem<int>>((entry) {
        return DropdownMenuItem<int>(
          value: entry.value,
          child: Text(entry.key),
        );
      }).toList();

      return CustomDropdown<int>(
        label: isEdit ? '' : 'Trạng thái',
        prefixIcon: Icons.info,
        items: items,
        value: value.value, // Truy cập giá trị của RxInt
        onChanged: (newValue) {
          if (newValue != null) {
            value.value = newValue; // Cập nhật giá trị cho RxInt
          }
        },
      );
    });
  }
}