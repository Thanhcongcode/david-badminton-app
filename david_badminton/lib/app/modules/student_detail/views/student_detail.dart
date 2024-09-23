import 'package:david_badminton/app/modules/add_student/views/widget/coach_dropdown.dart';
import 'package:david_badminton/app/modules/add_student/views/widget/gender_dropdown.dart';
import 'package:david_badminton/app/modules/add_student/views/widget/input_field.dart';
import 'package:david_badminton/app/modules/add_student/views/widget/location_dropdown.dart';
import 'package:david_badminton/app/modules/add_student/views/widget/shift_dropdown.dart';
import 'package:david_badminton/app/modules/add_student/views/widget/status_dropdown.dart';
import 'package:david_badminton/app/modules/student_detail/controller/student_detail_controller.dart';
import 'package:david_badminton/app/modules/student_detail/views/widget/title_field.dart';
import 'package:david_badminton/common/components/text_component.dart';
import 'package:david_badminton/common/widgets/appbar/appbar_common.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class StudentDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StudentDetailController controller = Get.put(StudentDetailController());

    controller.stdName.text = controller.student.name;
    controller.stdPhoneNumber.text = controller.student.phoneNumber;
    controller.stdAddress.text = controller.student.address;
    controller.stdDob.text = formatDate(controller.student.dob);
    controller.stdGender.text =
        controller.student.gender.toString() == true ? 'Nam' : 'Nữ';

    controller.stdCoachName.text = controller.student.coachName;
    controller.selectedGender.value = controller.student.gender;
    controller.stdLocationName.text = controller.student.locationName;
    controller.stdShift.text = controller.classSessions[controller.student.shift];
    controller.stdCreateAt.text = formatDate(controller.student.createdAt);
    controller.stdHealthStatus.text = controller.student.healthStatus;
    controller.stdHeight.text = controller.student.height.toString();
    controller.stdWeight.text = controller.student.weight.toString();
    controller.stdTuitionFee.text =
        controller.student.defaultTuitionFee.toString();
    controller.stdAvatar.text = controller.student.avatar;
    controller.stdDescription.text = controller.student.description;

    

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Obx(
          () => AppBarCommon(
            title: controller.isEdit.value ? 'Chỉnh sửa học viên' : 'Chi tiết',
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
            Obx(
              () => InputField(
                controller: controller.stdName,
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
                controller: controller.stdPhoneNumber,
                fieldName: '',
                icon: Icon(
                  IconlyBold.call,
                  size: 26.sp,
                ),
                isDetail: controller.isEdit.value ? false : true,
                inputType: TextInputType.phone,
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
                controller: controller.stdAddress,
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
                          controller: controller.stdDob,
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
                      Obx(() {
                        if (controller.isEdit.value) {
                          return GenderDropdown(
                            isEdit: true,
                            value: controller.selectedGender,
                          );
                        } else {
                          // When isEdit is false, show the InputField
                          return InputField(
                            controller: controller.stdGender,
                            fieldName: '',
                            icon: Icon(
                              Icons.transgender,
                              size: 26.sp,
                            ),
                            isDetail:
                                true, // isDetail should be true when not in edit mode
                          );
                        }
                      }),
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
              title: 'Huấn luyện viên: ',
            ),
            Obx(
              () {
                if (controller.isEdit.value) {
                  return CoachDropdown(
                    isEdit: true,
                    value: controller.selectedCoachId,
                  );
                } else {
                  // When isEdit is false, show the InputField
                  return InputField(
                    controller: controller.stdCoachName,
                    fieldName: '',
                    icon: Icon(
                      Icons.run_circle_outlined,
                      size: 26.sp,
                    ),
                    isDetail:
                        true, // isDetail should be true when not in edit mode
                  );
                }
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            TitleField(
              title: 'Cơ sở: ',
            ),
            Obx(
              () {
                if (controller.isEdit.value) {
                  return LocationDropdown(
                    isEdit: true,
value: controller.selectedLocationId,
                  );
                } else {
                  // When isEdit is false, show the InputField
                  return InputField(
                    controller: controller.stdLocationName,
                    fieldName: '',
                    icon: Icon(
                      IconlyBold.location,
                      size: 26.sp,
                    ),
                    isDetail:
                        true, // isDetail should be true when not in edit mode
                  );
                }
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            //shift
            TitleField(
              title: 'Ca học: ',
            ),
            Obx(
              () {
                if (controller.isEdit.value) {
                  return ShiftDropdown(
                    isEdit: true,
                  );
                } else {
                  // When isEdit is false, show the InputField
                  return InputField(
                    controller: controller.stdShift,
                    fieldName: '',
                    icon: Icon(
                      Icons.schedule,
                      size: 26.sp,
                    ),
                    isDetail:
                        true, // isDetail should be true when not in edit mode
                  );
                }
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            TitleField(
              title: 'Ngày bắt đầu: ',
            ),
            Obx(
              () => InputField(
                controller: controller.stdCreateAt,
                fieldName: '',
                icon: Icon(
                  Icons.calendar_month,
                  size: 26.sp,
                ),
                isDetail: controller.isEdit.value ? false : true,
                isDatePicker: controller.isEdit.value ? true : false,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            TitleField(
              title: 'Tình trạng: ',
            ),
            Obx(
              () {
                if (controller.isEdit.value) {
                  return StatusDropdown(
                    isEdit: true,
                    value: controller.selectedStatus,
                  );
                } else {
                  // When isEdit is false, show the InputField
                  return InputField(
                    controller: controller.stdStatus,
                    fieldName: '',
                    icon: Icon(
                      Icons.info,
                      size: 26.sp,
                    ),
                    isDetail:
                        true, // isDetail should be true when not in edit mode
                  );
                }
              },
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
            Obx(
              () => InputField(
                controller: controller.stdHealthStatus,
                fieldName: '',
                icon: Icon(
                  Icons.health_and_safety,
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
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleField(
                        title: 'Chiều cao: ',
                      ),
                      Obx(
                        () => InputField(
                          controller: controller.stdHeight,
                          fieldName: '',
                          icon: Icon(
                            Icons.straighten,
                            size: 26.sp,
                          ),
                          isDetail: controller.isEdit.value ? false : true,
                          inputType: TextInputType.number,
                        ),
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
                      Obx(
                        () => InputField(
                          controller: controller.stdWeight,
                          fieldName: '',
                          icon: Icon(
                            Icons.fitness_center,
                            size: 26.sp,
                          ),
                          isDetail: controller.isEdit.value ? false : true,
                          inputType: TextInputType.number,
                        ),
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
            Obx(
              () => InputField(
                controller: controller.stdGuardianName,
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
                      Obx(
                        () => InputField(
                          controller: controller.stdGuardianRelation,
                          fieldName: '',
                          icon: Icon(
                            Icons.family_restroom,
                            size: 26.sp,
                          ),
                          isDetail: controller.isEdit.value ? false : true,
                        ),
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
                      Obx(() {
                        if (controller.isEdit.value) {
                          return GenderDropdown(
                            isEdit: true,
                            value: controller.selectedGuardianGender,
                          );
                        } else {
                          // When isEdit is false, show the InputField
                          return InputField(
                            controller: controller.stdGender,
                            fieldName: '',
                            icon: Icon(
                              Icons.transgender,
                              size: 26.sp,
                            ),
                            isDetail:
                                true, // isDetail should be true when not in edit mode
                          );
                        }
                      }),
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
            Obx(
() => InputField(
                controller: controller.stdGuardianPhone,
                fieldName: '',
                icon: Icon(
                  IconlyBold.call,
                  size: 26.sp,
                ),
                isDetail: controller.isEdit.value ? false : true,
                inputType: TextInputType.phone,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            TitleField(
              title: 'Ghi chú: ',
            ),
            Obx(
              () => InputField(
                controller: controller.stdGuardianNote,
                fieldName: '',
                icon: Icon(
                  Icons.comment,
                  size: 26.sp,
                ),
                isDetail: controller.isEdit.value ? false : true,
              ),
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