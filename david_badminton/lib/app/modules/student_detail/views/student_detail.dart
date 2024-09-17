import 'package:david_badminton/app/modules/add_student/views/widget/input_field.dart';
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

class StudentDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StudentDetailController controller = Get.put(StudentDetailController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarCommon(
        title: 'Chi tiết',
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
              height: 20.h,
            ),
            TextComponent(
              content: 'Thông tin học viên',
              isTitle: true,
              color: AppColor.primaryOrange,
            ),
            SizedBox(
              height: 10.h,
            ),
            TitleField(
              title: 'Má số học viên: ',
            ),
            //id
            InputField(
              controller: controller.stdnumberId,
              fieldName: controller.student.numberId.toString(),
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
            InputField(
              controller: controller.stdName,
              fieldName: controller.student.name,
              icon: Icon(
                IconlyBold.profile,
                size: 26.sp,
              ),
              isDetail: true,
            ),
            SizedBox(
              height: 20.h,
            ),
            TitleField(
              title: 'Số điện thoại: ',
            ),
            //phone
            InputField(
              controller: controller.stdPhoneNumber,
              fieldName: controller.student.phoneNumber.toString(),
              icon: Icon(
                IconlyBold.call,
                size: 26.sp,
              ),
              isDetail: true,
            ),
            SizedBox(
              height: 20.h,
            ),
            //address
            TitleField(
              title: 'Địa chỉ: ',
            ),
            InputField(
              controller: controller.stdAddress,
              fieldName: controller.student.address.toString(),
              icon: Icon(
                IconlyBold.location,
                size: 26.sp,
              ),
              isDetail: true,
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
                      InputField(
                        controller: controller.stdDob,
                        fieldName: formatDate(controller.student.dob),
                        icon: Icon(
                          IconlyBold.calendar,
                          size: 26.sp,
                        ),
                        isDetail: true,
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
                        controller: controller.stdGender,
                        fieldName:
                            controller.student.gender == true ? 'Nam' : 'Nữ',
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

            TextComponent(
                content: 'Thông tin khóa học',
                isTitle: true,
                color: AppColor.primaryOrange),
            SizedBox(
              height: 10.h,
            ),
            TitleField(
              title: 'Khóa học: ',
            ),
            //courseName
            InputField(
              controller: controller.stdCourseName,
              fieldName: controller.student.courseName.toString(),
              icon: Icon(
                Icons.sports_tennis_rounded,
                size: 26.sp,
              ),
              isDetail: true,
            ),
            SizedBox(
              height: 20.h,
            ),
            TitleField(
              title: 'Huấn luyên viên: ',
            ),
            InputField(
              controller: controller.stdCoachName,
              fieldName: controller.student.coachName.toString(),
              icon: Icon(
                IconlyBold.profile,
                size: 26.sp,
              ),
              isDetail: true,
            ),
            SizedBox(
              height: 20.h,
            ),
            TitleField(
              title: 'Cơ sở: ',
            ),
            InputField(
              controller: controller.stdLocationName,
              fieldName: controller.student.locationName.toString(),
              icon: Icon(
                IconlyBold.location,
                size: 26.sp,
              ),
              isDetail: true,
            ),
            SizedBox(
              height: 20.h,
            ),
            //shift
            TitleField(
              title: 'Ca học: ',
            ),
            InputField(
              controller: controller.stdShift,
              fieldName: controller.getShiftName(controller.student.shift),
              icon: Icon(
                Icons.schedule,
                size: 26.sp,
              ),
              isDetail: true,
            ),
            SizedBox(
              height: 20.h,
            ),
            TitleField(
              title: 'Ngày bắt đầu: ',
            ),
            InputField(
              controller: controller.stdCreateAt,
              fieldName: formatDate(controller.student.createdAt),
              icon: Icon(
                Icons.calendar_month,
                size: 26.sp,
              ),
              isDetail: true,
            ),
            SizedBox(
              height: 20.h,
            ),
            TitleField(
              title: 'Tình trạng: ',
            ),
            InputField(
              controller: controller.stdStatus,
              fieldName: controller.student.status.toString(),
              icon: Icon(
                Icons.info,
                size: 26.sp,
              ),
              isDetail: true,
            ),
            SizedBox(
              height: 20.h,
            ),
            TextComponent(
              content: 'Thông tin khác',
              isTitle: true,
              color: AppColor.primaryOrange,
            ),
            SizedBox(
              height: 10.h,
            ),
            TitleField(
              title: 'Tình trạng sức khỏe: ',
            ),
            InputField(
              controller: controller.stdHealthStatus,
              fieldName: controller.student.healthStatus.toString(),
              icon: Icon(
                Icons.health_and_safety,
                size: 26.sp,
              ),
              isDetail: true,
            ),
            SizedBox(
              height: 20.h,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleField(
                        title: 'Chiều cao: ',
                      ),
                      InputField(
                        controller: controller.stdHeight,
                        fieldName: controller.student.height.toString(),
                        icon: Icon(
                          Icons.straighten,
                          size: 26.sp,
                        ),
                        isDetail: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.h,
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleField(
                        title: 'Cân nặng: ',
                      ),
                      InputField(
                        controller: controller.stdWeight,
                        fieldName: controller.student.weight.toString(),
                        icon: Icon(
                          Icons.fitness_center,
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
            TextComponent(
              content: 'Thông tin người giám hộ',
              isTitle: true,
              color: AppColor.primaryOrange,
            ),
            SizedBox(
              height: 10.h,
            ),
            TitleField(
              title: 'Tên người giám hộ: ',
            ),
            InputField(
              controller: controller.stdGuardianName,
              fieldName: 'Tên người giám hộ',
              icon: Icon(
                IconlyBold.profile,
                size: 26.sp,
              ),
              isDetail: true,
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleField(
                        title: 'Quan hệ: ',
                      ),
                      InputField(
                        controller: controller.stdGuardianRelation,
                        fieldName: 'Quan hệ',
                        icon: Icon(
                          Icons.family_restroom,
                          size: 26.sp,
                        ),
                        isDetail: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleField(
                        title: 'Giới tính: ',
                      ),
                      InputField(
                        controller: controller.stdGuardianGender,
                        fieldName: 'Giới tính',
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
              title: 'Số điện thoại: ',
            ),
            InputField(
              controller: controller.stdGuardianPhone,
              fieldName: 'Điện thoại',
              icon: Icon(
                IconlyBold.call,
                size: 26.sp,
              ),
              isDetail: true,
            ),
            SizedBox(
              height: 20.h,
            ),
            TitleField(
              title: 'Ghi chú: ',
            ),
            InputField(
              controller: controller.stdGuardianNote,
              fieldName: 'Ghi chú',
              icon: Icon(
                Icons.comment,
                size: 26.sp,
              ),
              isDetail: true,
            ),
            SizedBox(height: 18.h),
            // Column(
            //   children: [
            //     Text('ID: ${student.id}',
            //         style:
            //             TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            //     SizedBox(height: 8),
            //     Text('Tên: ${student.name ?? 'N/A'}',
            //         style: TextStyle(fontSize: 16)),
            //     // Thêm các thông tin chi tiết khác ở đây
            //   ],
            // ),
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
