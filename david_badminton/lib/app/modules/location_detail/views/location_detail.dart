import 'package:david_badminton/app/modules/add_student/views/widget/input_field.dart';
import 'package:david_badminton/app/modules/coach_detail/controllers/coach_detail_controller.dart';
import 'package:david_badminton/app/modules/location_detail/controllers/location_detail_controller.dart';
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

class LocationDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocationDetailController controller = Get.put(LocationDetailController());

    controller.locationName.text = controller.location.name;
    controller.locationAddress.text = controller.location.address;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Obx(
          () => AppBarCommon(
            title: controller.isEdit.value ? 'Chỉnh sửa cơ sở' : 'Chi tiết',
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
              height: 20.h,
            ),

            TitleField(
              title: 'Mã số cơ sở: ',
            ),
            //id
            InputField(
              controller: controller.example,
              fieldName: controller.location.id.toString(),
              icon: Icon(
                Icons.stadium,
                size: 26.sp,
              ),
              isDetail: true,
            ),
            SizedBox(
              height: 20.h,
            ),
            TitleField(
              title: 'Tên cơ sở: ',
            ),
            //name
            Obx(
              () => InputField(
                controller: controller.locationName,
                fieldName: '',
                icon: Icon(
                  Icons.stadium,
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
                controller: controller.locationAddress,
                fieldName: '',
                softWrap: true,
                icon: Icon(
                  IconlyBold.location,
                  size: 26.sp,
                ),
                maxLines: 2,
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