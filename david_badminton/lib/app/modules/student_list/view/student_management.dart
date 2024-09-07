import 'package:david_badminton/app/modules/add_student/view/add_student.dart';
import 'package:david_badminton/app/modules/login/controllers/login_controller.dart';
import 'package:david_badminton/app/modules/student_list/controllers/student_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:david_badminton/common/components/text_component.dart';
import 'package:david_badminton/common/widgets/custom_shape/containers/search_container.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:iconly/iconly.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class StudentManagement extends StatelessWidget {
  const StudentManagement({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextComponent(
          content: 'Danh sách học viên',
          color: Colors.white,
          isTitle: true,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: AppColor.secondaryBlue,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
        child: GetBuilder<StudentController>(
          init: StudentController(),
          builder: (controller) => Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: SearchContainer(
                      searchBarWidth: double.infinity,
                      text: 'Tìm kiếm...',
                      // onChanged: (value) {
                      //   controller.updateSearchQuery(value);
                      // },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    flex: 1,
                    child: Icon(Icons.filter),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 40.h,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(AddStudent());
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                IconlyBold.plus,
                                color: Colors.green,
                                size: 18.sp,
                              ),
                              SizedBox(width: 5.sp),
                              TextComponent(
                                content: 'Thêm mới',
                                size: 14.sp,
                                color: Colors.green,
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(width: 0.2),
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Obx(
                        () {
                          return SizedBox(
                            height: 40.h,
                            child: controller.isSelecting.value
                                ? ElevatedButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          IconlyBold.delete,
                                          color: Colors.red,
                                          size: 18.sp,
                                        ),
                                        SizedBox(width: 5.sp),
                                        TextComponent(
                                          content: 'Xóa',
                                          size: 14.sp,
                                          color: Colors.red,
                                          weight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: BeveledRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: BorderSide(width: 0.2),
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                  )
                                : null,
                          );
                        },
                      ),
                    ],
                  ),
                  Obx(
                    () {
                      return ElevatedButton(
                        onPressed: () {
                          controller.toggleSelectionMode();
                        },
                        child: controller.isSelecting.value
                            ? TextComponent(
                                content: 'Hủy',
                              )
                            : TextComponent(
                                content: 'Chọn',
                                size: 16,
                              ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: controller.displayedStudents.length,
                    itemBuilder: (context, index) {
                      final student = controller.displayedStudents[index];
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.only(top: 10.h),
                        color: Colors.white,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(width: 0.5, color: Colors.grey),
                        ),
                        child: Obx(
                          () {
                            return ListTile(
                              title: Row(
                                children: [
                                  TextComponent(
                                    content: '${index + 1}. ',
                                    weight: FontWeight.bold,
                                  ),
                                  Flexible(
                                    child: Text(
                                      student.name,
                                      softWrap: true,
                                      maxLines: null,
                                    ),
                                  ),
                                ],
                              ),
                              leading: controller.isSelecting.value
                                  ? Checkbox(
                                      value: controller.selectedStudents
                                          .contains(student),
                                      onChanged: (bool? selected) {
                                        if (selected != null) {
                                          controller
                                              .toggleStudentSelection(student);
                                        }
                                      },
                                    )
                                  : null,
                              subtitle: Text(
                                student.birthDate,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: TextComponent(
                                      content: student.details,
                                      size: 16,
                                      softWrap: true,
                                      maxLines: null,
                                    ),
                                  ),
                                  SizedBox(width: 8.sp),
                                  Icon(
                                    IconlyLight.arrow_right_2,
                                    size: 16.sp,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              onTap: () {
                                //controller.toggleSelectionMode();
                              },
                              onLongPress: () {
                                controller.toggleSelectionMode();
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.previousPage();
                    },
                    icon: Icon(IconlyLight.arrow_left_2),
                  ),
                  Text(
                      'Trang ${controller.currentPage + 1} / ${controller.totalPages}'),
                  IconButton(
                    onPressed: () {
                      controller.nextPage();
                    },
                    icon: Icon(IconlyLight.arrow_right_2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
