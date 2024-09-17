import 'package:david_badminton/app/modules/attendance/controllers/attendance_controller.dart';
import 'package:david_badminton/app/modules/attendance/views/widget/dropdown_widget.dart';
import 'package:david_badminton/common/components/text_component.dart';
import 'package:david_badminton/common/widgets/custom_shape/containers/search_container.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class AttendanceSheet extends StatelessWidget {
  final AttendanceController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Obx(
        () {
          if (controller.showTable.value) {
            return Padding(
              padding: EdgeInsets.only(bottom: 9.h, left: 8.w, right: 8.w),
              child: Container(
                height: height * 0.06,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.saveAttendance(context);
                    print("Lưu dữ liệu");
                    print('abc');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.buttonGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: TextComponent(
                    content: 'Lưu',
                    size: 18.sp,
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      appBar: AppBar(
        title: TextComponent(
          content: 'Điểm danh',
          color: Colors.white,
          size: 24.sp,
          weight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: AppColor.secondaryBlue,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Column(
            children: [
              Obx(() {
                if (controller.showTable.value) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: SearchContainer(
                            searchBarWidth: double.maxFinite,
                            text: 'Tìm kiếm',
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.updateShowTable();
                              },
                              child: Text('Trở về'),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                backgroundColor: AppColor.primaryOrange,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox(
                    height: 0,
                  );
                }
              }),

              Obx(() {
                if (controller.showTable.value) {
                  return SizedBox(
                    height: 0,
                  ); // Không hiển thị gì nếu showTable là true
                } else {
                  return Padding(
                    padding:  EdgeInsets.only(top: 25.h),
                    child: Card(
                      color: Colors.white,
                      elevation: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 20,
                          bottom: 15,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: TextComponent(
                                    content: 'Điểm danh',
                                    color: AppColor.primaryOrange,
                                    isTitle: true,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller: controller.dateController,
                                    onTapOutside: (event) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    onTap: () {
                                      controller.selectDate(context);
                                    },
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 5.h),
                                      prefixIcon: IconButton(
                                        icon: Icon(
                                          IconlyLight.calendar,
                                          size: 26.sp,
                                        ),
                                        onPressed: () {
                                          controller.selectDate(context);
                                        },
                                      ),
                                      floatingLabelStyle: const TextStyle(
                                        color: AppColor.primaryOrange,
                                      ),
                                      label: TextComponent(
                                        content: 'Ngày',
                                        size: 18.sp,
                                      ),
                                      hintText: 'Ngày',
                                      hintStyle: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 11.sp),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black26,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: AppColor.primaryOrange,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25.h),
                            // Dropdown cho Locations
                            Obx(() {
                              if (controller.locations.isEmpty) {
                                return CircularProgressIndicator(); // Hoặc thông báo khi không có dữ liệu
                              } else {
                                return DropdownWidget(
                                  options: controller.locations,
                                  value: controller.selectedBranchId.value,
                                  hintText: 'Chọn cơ sở',
                                  onChanged: (newValue) {
                                    controller.updateBranch(newValue);
                                  },
                                  labelText: 'Cơ sở',
                                  icon: Icon(Icons.stadium_outlined),
                                );
                              }
                            }),
                            SizedBox(height: 20.h),
                            // Dropdown cho Coaches
                            Obx(() {
                              if (controller.coaches.isEmpty) {
                                return CircularProgressIndicator(); // Hoặc thông báo khi không có dữ liệu
                              } else {
                                return DropdownWidget(
                                  options: controller.coaches,
                                  value: controller.selectedCoachId.value,
                                  hintText: 'Chọn huấn luyện viên',
                                  onChanged: (newValue) {
                                    controller.updateCoach(newValue);
                                  },
                                  labelText: 'Huấn luyện viên',
                                  icon: Icon(Icons.person),
                                );
                              }
                            }),
                            SizedBox(height: 20.h),
                            // Dropdown cho Courses
                            Obx(() {
                              if (controller.courses.isEmpty) {
                                return CircularProgressIndicator(); // Hoặc thông báo khi không có dữ liệu
                              } else {
                                return DropdownWidget(
                                  options: controller.courses,
                                  value: controller.selectedCourseId.value,
                                  hintText: 'Chọn khóa học',
                                  onChanged: (newValue) {
                                    controller.updateCourse(newValue);
                                  },
                                  labelText: 'Khóa học',
                                  icon: Icon(Icons.sports_tennis),
                                );
                              }
                            }),
                            SizedBox(height: 20.h),
                            Obx(() {
                              return DropdownButtonFormField<int>(
                                value: controller.selectedShiftId.value,
                                icon: Icon(
                                  IconlyLight.arrow_down_2,
                                  size: 26.sp,
                                ),
                                hint: TextComponent(
                                  content: 'Ca học',
                                  size: 15.sp,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 5),
                                  label: TextComponent(
                                    content: 'Ca học',
                                    size: 18.sp,
                                  ),
                                  prefixIcon: Icon(Icons.schedule),
                                  floatingLabelStyle: const TextStyle(
                                    color: AppColor.primaryOrange,
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Colors.black26,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors
                                          .black26, // Default border color
                                    ),
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color:
                                            Colors.grey // Default border color
                                        ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: AppColor.primaryOrange),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.grey,
                                ),
                                items: List.generate(
                                    controller.classSessions.length, (index) {
                                  return DropdownMenuItem<int>(
                                    value: controller.classSessionValues[index],
                                    child:
                                        Text(controller.classSessions[index]),
                                  );
                                }),
                                onChanged: (newValue) {
                                  controller.updateShift(newValue!);
                                  // Xử lý khi giá trị thay đổi, ví dụ gửi đến API
                                  print("Selected Value: $newValue");
                                },
                              );
                            }),
                            SizedBox(height: 15.h),
                            SizedBox(
                              width: double.infinity, // Hoặc width theo nhu cầu
                              child: Obx(
                                () => ElevatedButton(
                                  onPressed: controller.isSearchEnabled.value
                                      ? () {
                                          controller.searchStudents();
                                        }
                                      : null, // Nếu không có lựa chọn nào, nút sẽ không hoạt động
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primaryOrange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        IconlyLight.search,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      TextComponent(
                                        content: 'Tìm kiếm',
                                        size: 18.sp,
                                        weight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }),

              SizedBox(height: 24.h),
              Obx(() {
                if (controller.showTable.value) {
                  return Expanded(child: buildDataTable());
                } else {
                  return SizedBox
                      .shrink(); // Không hiển thị gì nếu `showTable` là false
                }
              }),
              // Attendance Table

              SizedBox(height: 10.h),

              // Pagination Controls
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDataTable() {
    final students = controller.paginatedStudents;
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
                  columnSpacing: 16.0,
                  dataRowHeight: 50.h,
                  dataTextStyle: TextStyle(fontSize: 14.sp),
                  headingTextStyle: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.grey[350]!),
                  columns: [
                    DataColumn(label: Text('STT')),
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Tên')),
                    DataColumn(label: Text('Ca học')),
                    DataColumn(label: Text('Điểm danh')),
                  ],
                  rows: students.asMap().entries.map((entry) {
                    final index = entry.key;
                    final student = entry.value;
                    return DataRow(
                      cells: [
                        DataCell(Text(
                            '${index + 1 + controller.currentPage * controller.rowsPerPage}')),
                        DataCell(Text(student.id.toString())),
                        DataCell(Container(
                          width: 130.w,
                          child: Text(
                            student.name,
                            softWrap: true,
                            maxLines: null,
                          ),
                        )),
                        DataCell(Text(student.shift.toString())),
                        DataCell(
                          Checkbox(
                            value: student.isPresent,
                            onChanged: (bool? value) {
                              if (value != null) {
                                controller.updateStudentAttendance(
                                    student.id, value);
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
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
  }
}
