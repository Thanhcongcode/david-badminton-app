import 'package:david_badminton/api/api.dart';

import 'package:david_badminton/app/modules/add_student/views/add_student.dart';
import 'package:david_badminton/app/modules/student_detail/views/student_detail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:david_badminton/app/modules/student_list/controllers/student_controller.dart';
import 'package:david_badminton/common/components/text_component.dart';
import 'package:david_badminton/common/widgets/custom_shape/containers/search_container.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:iconly/iconly.dart';

class StudentManagement extends StatelessWidget {
  final StudentController controller = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

   

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
        child: Column(
          children: [
            // Search and Filter
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: SearchContainer(
                    searchBarWidth: double.infinity,
                    text: 'Tìm kiếm...',
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  flex: 1,
                  child: Icon(IconlyLight.filter),
                ),
              ],
            ),
            SizedBox(height: 30.h),

            // Add and Delete Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 40.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => AddStudent());
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(width: 0.2),
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Obx(() {
                      return SizedBox(
                        height: 40.h,
                        child: controller.isSelecting.value
                            ? ElevatedButton(
                                onPressed: () {
                                  // Action for delete
                                },
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
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(width: 0.2),
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                              )
                            : null,
                      );
                    }),
                  ],
                ),
                Obx(() {
                  return SizedBox(
                    height: 30.h,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.toggleSelectionMode();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: controller.isSelecting.value
                          ? TextComponent(content: 'Hủy', size: 14.sp)
                          : TextComponent(content: 'Chọn', size: 14.sp),
                    ),
                  );
                }),
              ],
            ),
            SizedBox(height: 16.h),
            // Display Data Table or CircularProgressIndicator
            Obx(
              () {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Expanded(
                    child: buildDataTable(),
                  );
                }
              },
            ),
            SizedBox(height: 24.h),
            // SizedBox(
            //   height: 40.h,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Get.to(() => AttendanceSheet());
            //     },
            //     style: ElevatedButton.styleFrom(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(5),
            //         ),
            //         backgroundColor: AppColor.primaryOrange),
            //     child: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         TextComponent(
            //           content: 'Điểm danh',
            //           color: Colors.white,
            //           weight: FontWeight.bold,
            //         ),
            //         SizedBox(
            //           width: 10,
            //         ),
            //         Icon(
            //           IconlyLight.arrow_right,
            //           color: Colors.white,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildDataTable() {
    return Obx(
      () {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: DataTable(
                      showCheckboxColumn: false,
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey[350]!),
                      columns: [
                        if (controller.isSelecting.value)
                          DataColumn(
                            label: Checkbox(
                              value: controller.isSelectAll.value,
                              onChanged: (value) {
                                controller.toggleSelectAll();
                              },
                            ),
                          ),
                        DataColumn(
                          label: Text('ID'),
                          onSort: (columnIndex, ascending) {
                            controller.sortById();
                          },
                        ),
                        DataColumn(label: Text('Tên')),
                        DataColumn(label: Text('Ca học')),
                      ],
                      rows: controller.paginatedStudents
                          .asMap()
                          .map((index, student) {
                            return MapEntry(
                                index,
                                DataRow(
                                  onSelectChanged: ((selected) {
                                    if (selected ?? false) {
                                      Get.to(() => StudentDetail(),
                                          arguments: student);
                                    }
                                  }),
                                  cells: [
                                    if (controller.isSelecting.value)
                                      DataCell(
                                        Checkbox(
                                          value: controller.pageCheckboxStates[
                                                      controller.currentPage]
                                                  ?[index] ??
                                              false,
                                          onChanged: (bool? value) {
                                            controller.toggleCheckbox(index +
                                                controller.currentPage *
                                                    controller.rowsPerPage);
                                          },
                                        ),
                                      ),
                                    DataCell(
                                      Container(
                                          width: 30,
                                          child: Text(student.id.toString())),
                                    ),
                                    DataCell(
                                      Container(
                                        width: 100,
                                        child: Text(
                                          student.name,
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        child: Text(
                                          controller
                                              .classSessions[student.shift],
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                          })
                          .values
                          .toList(),
                    ),
                  ),
                ),
                Obx(
                  () {
                    final totalPages = controller.totalPages;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: controller.currentPage > 0
                              ? () {
                                  controller.currentPage--;
                                }
                              : null,
                          icon: Icon(IconlyLight.arrow_left_2),
                        ),
                        SizedBox(width: 20.w),
                        Text(
                            'Trang ${controller.currentPage + 1} trên $totalPages'),
                        SizedBox(width: 20.w),
                        IconButton(
                          onPressed: controller.currentPage < totalPages - 1
                              ? () {
                                  controller.currentPage++;
                                  print(totalPages);
                                }
                              : null,
                          icon: Icon(IconlyLight.arrow_right_2),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
