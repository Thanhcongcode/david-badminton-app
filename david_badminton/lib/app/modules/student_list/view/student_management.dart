import 'package:david_badminton/api/api.dart';
import 'package:david_badminton/app/modules/add_student/views/add_student.dart';
import 'package:david_badminton/app/modules/student_detail/views/student_detail.dart';
import 'package:david_badminton/common/widgets/appbar/custom_appbar.dart';
import 'package:david_badminton/common/widgets/custom_shape/containers/primary_header_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:david_badminton/app/modules/student_list/controllers/student_controller.dart';
import 'package:david_badminton/common/components/text_component.dart';
import 'package:david_badminton/common/widgets/custom_shape/containers/search_container.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:iconly/iconly.dart';

class StudentManagement extends StatelessWidget {
  final StudentController controller = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomAppBar(
        title: TextComponent(
          content: 'Danh sách học viên',
          color: Colors.white,
          isTitle: true,
        ),
        centerTitle: true,
        showBackArrow: true,
        transparent: false,
        actions: [
          // Obx(() => TextButton(
          //       onPressed: () {
          //         controller.toggleSelectionMode();
          //       },
          //       child: controller.isSelecting.value
          //           ? TextComponent(
          //               content: 'Hủy',
          //               size: 15.sp,
          //               color: Colors.white,
          //             )
          //           : TextComponent(
          //               content: 'Chọn',
          //               size: 15.sp,
          //               color: Colors.white,
          //             ),
          //     ))
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: Obx(
        () => FloatingActionButton(
          onPressed: controller.isSelecting.value
              ? () {}
              : () {
                  Get.to(() => AddStudent());
                },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: controller.isSelecting.value
              ? Colors.red
              : AppColor.secondaryBlue,
          child: controller.isSelecting.value
              ? Icon(
                  Icons.delete,
                  color: Colors.white,
                )
              : Icon(
                  Icons.add,
                  color: Colors.white,
                ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // bottomNavigationBar: Container(
      //   height: 50.h,
      //   child: Padding(
      //     padding: EdgeInsets.only(bottom: 10.h),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Obx(
      //           () {
      //             final totalPages = controller.totalPages;
      //             return Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 IconButton(
      //                   onPressed: controller.currentPage > 0
      //                       ? () {
      //                           controller.currentPage--;
      //                         }
      //                       : null,
      //                   icon: Icon(IconlyLight.arrow_left_2),
      //                 ),
      //                 SizedBox(width: 10.w),
      //                 Text(
      //                   'Trang ${controller.currentPage + 1} trên $totalPages',
      //                   style: TextStyle(fontSize: 16.sp),
      //                 ),
      //                 SizedBox(width: 10.w),
      //                 IconButton(
      //                   onPressed: controller.currentPage < totalPages - 1
      //                       ? () {
      //                           controller.currentPage++;
      //                         }
      //                       : null,
      //                   icon: Icon(IconlyLight.arrow_right_2),
      //                 ),
      //               ],
      //             );
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: NestedScrollView(headerSliverBuilder: (_, innerBoxIsScroll) {
        return [
          SliverAppBar(
            automaticallyImplyLeading: false,
            iconTheme: IconThemeData(color: Colors.white),
            floating: true,
            expandedHeight: 97.h,
            snap: true,         //khi mà kéo lên thì nó hiện lại liền
            backgroundColor: AppColor.secondaryBlue,
            flexibleSpace: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: SearchContainer(
                          searchBarWidth: double.infinity,
                          text: 'Tìm kiếm...',
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        flex: 1,
                        child: Icon(
                          IconlyBold.filter_2,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Obx(() {
                  return Container(
                    alignment: Alignment.centerLeft,
                    height: 30.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    width: double.infinity,

                    child: TextComponent(
                      content: '${controller.totalStudents.value} học viên',
                      size: 17.sp,
                    ),
                    decoration: BoxDecoration(
                      gradient: AppColor.customLineGradientLine,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 3), color: Color(0xffe2ebfb)),
                      ],
                    ),
                    // decoration: BoxDecoration(boxShadow: [
                    //   BoxShadow(
                    //     color: const Color.fromARGB(255, 218, 218, 218),
                    //     spreadRadius: 5,
                    //     blurRadius: 7,
                    //     offset: Offset(0, 0), // Độ lệch của bóng
                    //   ),
                    // ]),
                  );
                }),
              ],
            ),
          )
        ];
      }, body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: buildStudentList()),
            ],
          );
        }
      })),
    );
  }

  Widget buildStudentList() {
    return Obx(() {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: controller.students.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
          thickness: 0.5,
        ),
        itemBuilder: (context, index) {
          final student = controller.students[index];
          return ListTile(
            tileColor: Color(0xfffefefe),
            onTap: () {
              Get.to(() => StudentDetail(), arguments: student);
            },
            leading: Container(
              height: 60.h,
              width: 60.h,
              decoration: BoxDecoration(
                color: Color(0xfff4f8fb),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
              ),
              child: ClipRect(
                child: Center(
                  child: student.avatar.isNotEmpty
                      ? SvgPicture.asset(
                          'assets/icons/image.svg',
                          fit: BoxFit.cover,
                          width: 40.w,
                          height: 40.h,
                        )
                      : SvgPicture.asset(
                          'assets/icons/image.svg',
                          fit: BoxFit.cover,
                          width: 40.w,
                          height: 40.h,
                        ),
                ),
              ),
            ),
            title: TextComponent(
              content: student.name,
              size: 16.sp,
              weight: FontWeight.w600,
              softWrap: true,
              maxLines: null,
            ),
            subtitle: TextComponent(
              content: student.numberId.toString(),
            ),
            trailing: Text(controller.classSessions[student.shift]),
          );
        },
      );
    });
  }
}
