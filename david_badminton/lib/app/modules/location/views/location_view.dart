import 'package:david_badminton/app/modules/add_location/views/add_location.dart';
import 'package:david_badminton/app/modules/add_student/views/add_student.dart';
import 'package:david_badminton/app/modules/location/controllers/location_controller.dart';
import 'package:david_badminton/app/modules/location_detail/views/location_detail.dart';
import 'package:david_badminton/common/components/text_component.dart';
import 'package:david_badminton/common/widgets/custom_shape/containers/search_container.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class LocationView extends StatelessWidget {
  final LocationController controller = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    // final BranchDataSource branchDataSource =
    //     BranchDataSource(controller.branches);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: TextComponent(
            content: 'Danh sách cơ sở',
            color: Colors.white,
            isTitle: true,
          ),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: AppColor.secondaryBlue,
        ),
        floatingActionButton: Obx(
          () => FloatingActionButton(
            onPressed: () {
              Get.to(() => AddLocation());
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: controller.isSelecting.value
                ? Colors.red
                : AppColor.buttonGreen,
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
        body: SingleChildScrollView(
          child: Padding(
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
                SizedBox(height: 20.h),

                // Add and Delete Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => TextComponent(
                          content:
                              'Tổng số cơ sở: ${controller.totalLocations.value}'),
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
                        items:
                            [5, 10, 15].map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text('$value hàng'),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.sp),
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
                        DataColumn(
                          label: Text('Tên'),
                          onSort: (columnIndex, ascending) {
                            controller.sortByName();
                          },
                        ),
                        DataColumn(
                          label: Text('Địa chỉ'),
                          onSort: (columnIndex, ascending) {
                            controller.sortByAddress();
                          },
                        ),
                      ],
                      rows: controller.locations
                          .asMap()
                          .map((index, location) {
                            return MapEntry(
                                index,
                                DataRow(
                                  onSelectChanged: ((selected) {
                                    if (selected ?? false) {
                                      Get.to(() => LocationDetail(),
                                          arguments: location);
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
                                      Text(location.id.toString()),
                                    ),
                                    DataCell(
                                      Text(
                                        location.name,
                                        softWrap: true,
                                        maxLines: null,
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        location.address,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
