import 'package:david_badminton/app/modules/add_student/controllers/add_student_controller.dart';
import 'package:david_badminton/common/widgets/dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class LocationDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AddStudentController controller = Get.find();

    return Obx(() {
      final items = controller.locations.map((location) {
        return DropdownMenuItem<int>(
          child: Text(location.name),
          value: location.id,
        );
      }).toList();

      return CustomDropdown<int>(
        label: 'Cơ sở',
        prefixIcon: IconlyBold.location,
        items: items,
        value: controller.selectedLocationId.value,
        onChanged: (newValue) {
          if (newValue != null) {
            controller.selectedLocationId.value = newValue;
          }
        },
        isRequired: true,
        
      );
    });
  }
}
