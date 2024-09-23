import 'package:david_badminton/app/modules/add_coach/controllers/add_coach_controller.dart';
import 'package:david_badminton/app/modules/add_student/views/widget/gender_dropdown.dart';
import 'package:david_badminton/app/modules/add_student/views/widget/input_field.dart';
import 'package:david_badminton/app/modules/coach_detail/controllers/coach_detail_controller.dart';
import 'package:david_badminton/app/modules/student_detail/controller/student_detail_controller.dart';
import 'package:david_badminton/app/modules/student_detail/views/widget/title_field.dart';
import 'package:david_badminton/common/components/text_component.dart';
import 'package:david_badminton/common/widgets/appbar/appbar_common.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class AddCoach extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AddCoachController controller = Get.put(AddCoachController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarCommon(
        title: 'Thêm huấn luyện viên',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
        ),
        child: ListView(
          children: [
            SizedBox(
              height: 18.h,
            ),
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

            //name
            InputField(
              controller: controller.nameController,
              fieldName: 'Họ và tên',
              icon: Icon(
                IconlyBold.profile,
                size: 26.sp,
              ),
              isCompulsory: true,
            ),
            SizedBox(
              height: 20.h,
            ),
            //phone
            InputField(
              controller: controller.phoneController,
              fieldName: 'Số điện thoại',
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
              controller: controller.addressController,
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
                //dob
                Expanded(
                  flex: 3,
                  child: InputField(
                    controller: controller.dobController,
                    fieldName: 'Ngày sinh',
                    icon: Icon(
                      IconlyBold.calendar,
                      size: 26.sp,
                    ),
                    isCompulsory: true,
                    isDatePicker: true,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),

                //gender
                Expanded(flex: 2, child: GenderDropdown(value: controller.selectedGender,))
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            //phone
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

  String formatDate(String dateTimeString) {
    try {
      // Chuyển đổi chuỗi ngày giờ thành đối tượng DateTime
      DateTime dateTime = DateTime.parse(dateTimeString);

      // Định dạng ngày theo định dạng mong muốn
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

      return formattedDate;
    } catch (e) {
      // Xử lý lỗi nếu chuỗi ngày giờ không hợp lệ
      print('Error parsing date: $e');
      return 'Invalid date';
    }
  }
}