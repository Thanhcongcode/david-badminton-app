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

class CoachDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CoachDetailController controller = Get.put(CoachDetailController());

    controller.hlvName.text = controller.coaches.name;
    controller.hlvPhone.text = controller.coaches.phoneNumber;
    controller.hlvAdress.text = controller.coaches.address;
    controller.hlvDescription.text = controller.coaches.description;
    controller.hlvDob.text = formatDate(controller.coaches.dob);
    controller.hlvGender.text =
        controller.coaches.gender.toString() == true ? 'Nam' : 'Nữ';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Obx(
          () => AppBarCommon(
            title: controller.isEdit.value ? 'Chỉnh sửa HLV' : 'Chi tiết',
            actions: [
              IconButton(
                onPressed: () {
                  controller.toggleEdit();
                },
                icon: controller.isEdit.value
                    ? TextComponent(
                        content: 'Hủy',
                        color: Colors.white,
                      )
                    : Icon(
                        IconlyLight.edit_square,
                        size: 30,
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () {
          return controller.isEdit.value
              ? Padding(
                  padding: EdgeInsets.only(
                      top: 10, bottom: 10.h, left: 10.w, right: 10.w),
                  child: SizedBox(
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: () {
                        // Thực hiện hành động lưu ở đây
                      },
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
                )
              : SizedBox.shrink(); // Trả về một widget rỗng khi isEdit là false
        },
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
              foregroundImage: AssetImage('assets/logos/logo.png'),
              radius: 60.sp,
            ),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => controller.isEdit.value
                  ? TextButton(
                      onPressed: () {},
                      child: TextComponent(
                        content: 'Tải ảnh lên',
                        size: 18.sp,
                      ),
                    )
                  : SizedBox.shrink(),
            ),

            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            TitleField(
              title: 'Mã số huấn luyện viên: ',
            ),
            //id
            InputField(
              controller: controller.example,
              fieldName: controller.coaches.numberId.toString(),
              icon: Icon(
                Icons.perm_identity,
                size: 26.sp,
              ),
              isDetail: true,
            ),
            SizedBox(
              height: 20.h,
            ),
            TitleField(
              title: 'Họ tên: ',
            ),
            //name
            Obx(
              () => InputField(
                controller: controller.hlvName,
                fieldName: '',
                icon: Icon(
                  IconlyBold.profile,
                  size: 26.sp,
                ),
                isDetail: controller.isEdit.value ? false : true,
              ),
            ),

            SizedBox(
              height: 20.h,
            ),
            TitleField(
              title: 'Số điện thoại: ',
            ),
            //phone
            Obx(
              () => InputField(
                controller: controller.hlvPhone,
                fieldName: '',
                icon: Icon(
                  IconlyBold.call,
                  size: 26.sp,
                ),
                isDetail: controller.isEdit.value ? false : true,
              ),
            ),

            SizedBox(
              height: 20.h,
            ),
            //address
            TitleField(
              title: 'Địa chỉ: ',
            ),
            Obx(
              () => InputField(
                controller: controller.hlvAdress,
fieldName: '',
                icon: Icon(
                  IconlyBold.location,
                  size: 26.sp,
                ),
                isDetail: controller.isEdit.value ? false : true,
              ),
            ),

            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //dob
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleField(
                        title: 'Ngày sinh: ',
                      ),
                      Obx(
                        () => InputField(
                          controller: controller.hlvDob,
                          fieldName: '',
                          icon: Icon(
                            IconlyBold.calendar,
                            size: 26.sp,
                          ),
                          isDetail: controller.isEdit.value ? false : true,
                          isDatePicker: controller.isEdit.value ? true : false,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),

                //gender
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleField(
                        title: 'Giới tính: ',
                      ),
                      InputField(
                        controller: controller.hlvGender,
                        fieldName: '',
                        icon: Icon(
                          Icons.transgender,
                          size: 26.sp,
                        ),
                        isDetail: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            TitleField(
              title: 'Mô tả: ',
            ),
            //phone
            Obx(
              () => InputField(
                controller: controller.hlvDescription,
                fieldName: '',
                icon: Icon(
                  IconlyBold.call,
                  size: 26.sp,
                ),
                isDetail: controller.isEdit.value ? false : true,
              ),
            ),

            SizedBox(
              height: 20.h,
            ),
          ],
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