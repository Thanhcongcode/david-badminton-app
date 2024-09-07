import 'package:david_badminton/app/modules/add_student/controller/add_student_controller.dart';
import 'package:david_badminton/app/modules/add_student/view/widget/input_field.dart';
import 'package:david_badminton/app/modules/home/views/widget/function/human_management.dart';
import 'package:david_badminton/common/components/text_component.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final controller = Get.put(AddStudentController());

  List<String> gender = ['Nam', 'Nữ'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextComponent(
          content: 'Thêm học viên',
          color: Colors.white,
          isTitle: true,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: AppColor.secondaryBlue,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView(
          children: [
            CircleAvatar(
              radius: 60.sp,
            ),
            TextButton(
              onPressed: () {},
              child: TextComponent(
                content: 'Tải ảnh lên',
                size: 18.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            TextComponent(
              content: 'Thông tin học viên',
              isTitle: true,
            ),
            SizedBox(
              height: 10.h,
            ),
            InputField(
              controller: controller.stdName,
              fieldName: 'Tên học viên',
              icon: Icon(
                IconlyBold.profile,
                size: 26.sp,
              ),
              isCompulsory: true,
            ),
            SizedBox(
              height: 20.h,
            ),
            InputField(
              controller: controller.stdPhone,
              fieldName: 'Điện thoại',
              icon: Icon(
                IconlyBold.call,
                size: 26.sp,
              ),
              isCompulsory: true,
            ),
            SizedBox(
              height: 20.h,
            ),
            InputField(
              controller: controller.stdAddress,
              fieldName: 'Địa chỉ',
              icon: Icon(
                IconlyBold.location,
                size: 26.sp,
              ),
              isCompulsory: true,
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: InputField(
                    controller: controller.stdDOB,
                    fieldName: 'Ngày sinh',
                    icon: Icon(
                      Icons.calendar_month,
                      size: 26.sp,
                    ),
                    isCompulsory: true,
                    isDatePicker: true,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  flex: 2,
                  child: InputField(
                    controller: controller.stdGender,
                    fieldName: 'Giới tính',
                    icon: Icon(
                      Icons.transgender,
                      size: 26.sp,
                    ),
                    isDropdown: true,
                    isCompulsory: true,
                    options: gender,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            TextComponent(
              content: 'Thông tin khóa học',
              isTitle: true,
            ),
            SizedBox(
              height: 10.h,
            ),
            InputField(
              controller: controller.course,
              fieldName: 'Khóa học',
              icon: Icon(
                Icons.sports_tennis_rounded,
                size: 26.sp,
              ),
              isDropdown: true,
              isCompulsory: true,
              options: gender,
            ),
            SizedBox(
              height: 20.h,
            ),
            InputField(
              controller: controller.courseShift,
              fieldName: 'Ca học',
              icon: Icon(
                Icons.schedule,
                size: 26.sp,
              ),
              isDropdown: true,
              isCompulsory: true,
              options: gender,
            ),
            SizedBox(
              height: 20.h,
            ),
            InputField(
              controller: controller.coach,
              fieldName: 'Huấn luyện viên',
              icon: Icon(
                IconlyBold.profile,
                size: 26.sp,
              ),
              isDropdown: true,
              isCompulsory: true,
              options: gender,
            ),
            SizedBox(
              height: 20.h,
            ),
            InputField(
              controller: controller.tuition,
              fieldName: 'Học phí',
              icon: Icon(
                Icons.monetization_on,
                size: 26.sp,
              ),
              isCompulsory: true,
            ),
            SizedBox(
              height: 20.h,
            ),
            InputField(
              controller: controller.startedDay,
              fieldName: 'Ngày bắt đầu học',
              icon: Icon(
                Icons.calendar_month,
                size: 26.sp,
              ),
              isCompulsory: true,
              isDatePicker: true,
            ),
            SizedBox(
              height: 20.h,
            ),
            InputField(
              controller: controller.status,
              fieldName: 'Trạng thái',
              icon: Icon(
                Icons.info,
                size: 26.sp,
              ),
              isDropdown: true,
              isCompulsory: true,
              options: gender,
            ),
            SizedBox(
              height: 20.h,
            ),
            InputField(
              controller: controller.description,
              fieldName: 'Mô tả',
              icon: Icon(
                Icons.article,
                size: 26.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            TextComponent(
              content: 'Thông tin người giám hộ',
              isTitle: true,
            ),
            SizedBox(
              height: 10.h,
            ),
            InputField(
              controller: controller.relativeName,
              fieldName: 'Tên người giám hộ',
              icon: Icon(
                IconlyBold.profile,
                size: 26.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: InputField(
                    controller: controller.relativeName,
                    fieldName: 'Quan hệ',
                    icon: Icon(
                      Icons.family_restroom,
                      size: 26.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  flex: 2,
                  child: InputField(
                    controller: controller.relativeGender,
                    fieldName: 'Giới tính',
                    icon: Icon(
                      Icons.transgender,
                      size: 26.sp,
                    ),
                    isDropdown: true,
                    isCompulsory: true,
                    options: gender,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            InputField(
              controller: controller.relativePhone,
              fieldName: 'Điện thoại',
              icon: Icon(
                IconlyBold.call,
                size: 26.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            InputField(
              controller: controller.note,
              fieldName: 'Ghi chú',
              icon: Icon(
                Icons.comment,
                size: 26.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            TextComponent(
              content: 'Thông tin khác',
              isTitle: true,
            ),
            SizedBox(
              height: 10.h,
            ),
            InputField(
              controller: controller.healthInfo,
              fieldName: 'Thông tin sức khỏe',
              icon: Icon(
                Icons.health_and_safety,
                size: 26.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Expanded(
                  child: InputField(
                    controller: controller.height,
                    fieldName: 'Chiều cao',
                    icon: Icon(
                      Icons.straighten,
                      size: 26.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: InputField(
                    controller: controller.weight,
                    fieldName: 'Cân nặng',
                    icon: Icon(
                      Icons.fitness_center,
                      size: 26.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top: 0, bottom: 10.h, left: 10.w, right: 10.w),
        child: SizedBox(
          height: 50.h,
          child: ElevatedButton(
            onPressed: () {},
            child: TextComponent(
              content: 'Lưu',
              size: 22.sp,
              weight: FontWeight.bold,
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.buttonGreen,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
