import 'package:david_badminton/api/api.dart';

import 'package:david_badminton/app/modules/add_student/views/add_student.dart';
import 'package:david_badminton/app/modules/attendance/views/attendance_sheet.dart';
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
        actions: [
          Obx(
            () => TextButton(
              onPressed: () {
                controller.toggleSelectionMode();
              },
              child: controller.isSelecting.value
                  ? TextComponent(
                      content: 'Hủy',
                      size: 14.sp,
                      color: Colors.white,
                    )
                  : TextComponent(
                      content: 'Chọn',
                      size: 14.sp,
                      color: Colors.white,
                    ),
            ),
          ),
        ],
      ),
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
          backgroundColor:
              controller.isSelecting.value ? Colors.red : AppColor.buttonGreen,
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => TextComponent(
                      content:
                          'Tổng số học viên: ${controller.totalStudents.value}'),
                ),
                Obx(
                  () => DropdownButton<int>(
                    value: controller.selectedRowsPerPage.value,
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        controller.selectedRowsPerPage.value = newValue;
                        controller.updatePageIndex(0);
                      }
                    },
                    dropdownColor: Colors.white,
                    items: [5, 10, 15].map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value hàng'),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),
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
                          label: Row(
                            children: [
                              Text('ID'),
                              SizedBox(width: 5),
                              if (controller.isAscendingId.value)
                                Icon(
                                  IconlyLight.arrow_up_2,
                                  size: 16,
                                )
                              else
                                Icon(
                                  IconlyLight.arrow_down_2,
                                  size: 16,
                                )
                            ],
                          ),
                          onSort: (columnIndex, ascending) {
                            controller.sortById();
                          },
                        ),
                        DataColumn(
                          label: Row(
                            children: [
                              Text('Tên'),
                              SizedBox(width: 5),
                              if (controller.isAscendingName.value)
                                Icon(
                                  IconlyLight.arrow_up_2,
                                  size: 16,
                                )
                              else
                                Icon(
                                  IconlyLight.arrow_down_2,
                                  size: 16,
                                )
                            ],
                          ),
                          onSort: (columnIndex, ascending) {
                            controller.sortByName();
                          },
                        ),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
