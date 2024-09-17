import 'package:david_badminton/app/modules/add_student/views/add_student.dart';
import 'package:david_badminton/app/modules/coach/controllers/coach_controller.dart';
import 'package:david_badminton/common/components/text_component.dart';
import 'package:david_badminton/common/widgets/custom_shape/containers/search_container.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class CoachView extends StatelessWidget {
  final CoachController controller = Get.put(CoachController());

  @override
  Widget build(BuildContext context) {
    // final coachDataSource = CoachDataSource(controller.coaches);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextComponent(
          content: 'Danh sách huấn luyện viên',
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
                  child: Icon(Icons.filter),
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
                  return ElevatedButton(
                    onPressed: () {
                      controller.toggleSelectionMode();
                    },
                    child: controller.isSelecting.value
                        ? TextComponent(content: 'Hủy')
                        : TextComponent(content: 'Chọn', size: 16),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                }),
              ],
            ),
            SizedBox(height: 8.sp),

            // Student Table
            Obx(
              () {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return buildDataTable();
                }
              },
            ),
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
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Tên')),
                        DataColumn(label: Text('Địa chỉ')),
                        DataColumn(label: Text('Ngày sinh')),
                      ],
                      rows: controller.coaches
                          .asMap()
                          .map((index, coach) {
                            return MapEntry(
                                index,
                                DataRow(
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
                                      Text(coach.id.toString()),
                                    ),
                                    DataCell(
                                      Text(
                                        coach.name,
                                        softWrap: true,
                                        maxLines: null,
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        coach.address,
                                        softWrap: true,
                                        maxLines: null,
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        formatDate(coach.dob),
                                        softWrap: true,
                                        maxLines: null,
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
