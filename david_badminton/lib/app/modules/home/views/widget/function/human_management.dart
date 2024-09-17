import 'package:david_badminton/app/modules/attendance/views/attendance_sheet.dart';
import 'package:david_badminton/app/modules/coach/views/coach_view.dart';
import 'package:david_badminton/app/modules/student_list/view/student_management.dart';
import 'package:david_badminton/common/widgets/function/function_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HumanManagement extends StatelessWidget {
  const HumanManagement({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 29.w),
      child: Wrap(
        spacing: 41.w,
        runSpacing: 24.h,
        children: [
          FunctionButton(
            icon: 'assets/icons/student.svg',
            label: 'Quản lý học viên',
            onPressed: () {
              Get.to(() => StudentManagement());
            },
          ),
          FunctionButton(
            icon: 'assets/icons/coach.svg',
            label: 'Quản lý Huấn luyện viên',
            onPressed: () {
              Get.to(() => CoachView());
            },
          ),
          FunctionButton(
            icon: 'assets/icons/attend.svg',
            label: 'Điểm danh',
            onPressed: () {
              Get.to(() => AttendanceSheet());
            },
          ),
        ],
      ),
    );
  }
}
