import 'package:data_table_2/data_table_2.dart';
import 'package:david_badminton/app/modules/attendance/controllers/attendance_controller.dart';
import 'package:david_badminton/app/modules/attendance/view/widget/dropdown_widget.dart';
import 'package:david_badminton/common/components/text_component.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class AttendanceSheet extends StatefulWidget {
  const AttendanceSheet({super.key});

  @override
  State<AttendanceSheet> createState() => _AttendanceSheetState();
}

class _AttendanceSheetState extends State<AttendanceSheet> {
  final controller = Get.put(AttendanceController());

  String? _selectedValue;

  List<String> options = <String>[
    'Nguyễn Văn A',
    'Nguyễn Văn B',
    'Nguyễn Văn C',
    'Nguyễn Văn Dasdasdadasd'
  ];

  List<Map<String, dynamic>> students = List.generate(
    20,
    (index) => {
      'stt': index + 1,
      'id': 'IDádasda${index + 1}',
      'name': 'Nguyễn Huỳnh Thị Hoài Thương${index + 1}',
      'class': 'Lớp ${index + 1}',
      'checked': false,
    },
  );

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        controller.dateController.text = '${pickedDate.toLocal()}'
            .split(' ')[0]; // Format the date as YYYY-MM-DD
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 9.h, left: 8.w, right: 8.w),
        child: Container(
          height: height * 0.06,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Thực hiện hành động lưu
              print("Lưu dữ liệu");
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
      body: Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24.h,
            ),
            // Dropdowns and Date Picker
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: DropdownWidget(
                    hintText: 'Cơ Sở',
                    labelText: 'Cơ sở',
                    icon: Icon(Icons.stadium_outlined),
                    options: options,
                    value: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10.sp),
                Expanded(
                  flex: 1,
                  child: DropdownWidget(
                    hintText: 'Ca học',
                    labelText: 'Ca học',
                    icon: Icon(Icons.schedule),
                    options: options,
                    value: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.sp),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: DropdownWidget(
                    hintText: 'Huấn luyện viên',
                    labelText: 'Huấn luyện viên',
                    icon: Icon(Icons.person_2_outlined),
                    options: options,
                    value: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10.sp),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50.h,
                    child: TextFormField(
                      controller: controller.dateController,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      onTap: () {
                        _selectDate(context);
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
                            _selectDate(context);
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
                        hintStyle:
                            TextStyle(color: Colors.black26, fontSize: 11.sp),
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
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Attendance Table
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              constraints: BoxConstraints(
                maxHeight: height * .6, // Giới hạn chiều cao của bảng
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 16.0,
                    dataRowHeight: 50.h, // Giảm chiều cao hàng
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
                      DataColumn(label: Text('Điểm danh')),
                    ],
                    rows: students.map((student) {
                      return DataRow(
                        cells: [
                          DataCell(Text('${student['stt']}')),
                          DataCell(Text(student['id'])),
                          DataCell(Container(
                            width: 130.w,
                            child: Text(
                              student['name'],
                              softWrap: true,
                              maxLines: null,
                            ),
                          )),
                          DataCell(
                            Checkbox(
                              value: student['checked'],
                              onChanged: (bool? value) {
                                setState(() {
                                  student['checked'] = value;
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
