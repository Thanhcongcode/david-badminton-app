import 'dart:math';

import 'package:david_badminton/api/api.dart';
import 'package:david_badminton/app/modules/student_list/controllers/student_controller.dart';
import 'package:david_badminton/app/modules/student_list/view/student_management.dart';
import 'package:david_badminton/model/coach.dart';
import 'package:david_badminton/model/location.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

final storage = FlutterSecureStorage();

class AddStudentController extends GetxController {
  TextEditingController stdName = TextEditingController();
  TextEditingController stdPhone = TextEditingController();
  TextEditingController stdAddress = TextEditingController();
  TextEditingController stdDOB = TextEditingController();
  TextEditingController stdGender = TextEditingController();

  TextEditingController stdCourseId =
      TextEditingController(); // ID của khóa học
  TextEditingController courseLocationId =
      TextEditingController(); // ID của địa điểm
  TextEditingController courseCoachId =
      TextEditingController(); // ID của huấn luyện viên
  TextEditingController stdShift = TextEditingController();
  TextEditingController stdTuition =
      TextEditingController(); // Học phí khóa học
  TextEditingController stdDateRange = TextEditingController();
  TextEditingController stdStatus = TextEditingController();
  TextEditingController stdDescription = TextEditingController();
  var stdStartDay = TextEditingController();

  TextEditingController stdRelativeName = TextEditingController();
  TextEditingController stdRelationship = TextEditingController();
  TextEditingController stdRelativeGender = TextEditingController();
  TextEditingController stdRelativePhone = TextEditingController();
  TextEditingController stdNote = TextEditingController();

  TextEditingController stdHealthStatus = TextEditingController();
  TextEditingController stdHeight = TextEditingController();
  TextEditingController stdWeight = TextEditingController();
  final stdAvatar = TextEditingController();

  RxBool isLoading = false.obs;

  RxList<Coach> coaches = <Coach>[].obs;
  RxList<Location> locations = <Location>[].obs; // Danh sách chi nhánh\

  void loadAllCoaches() async {
    List<Coach> allCoaches = [];
    try {
      // Bắt đầu loading

      // Gọi API với page = 1 để lấy totalCount
      var firstResponse = await Api.getAllCoaches(
          1, 1); // Gọi API để lấy totalCount, chỉ cần 1 record

      // Lấy totalCount để làm pageSize
      int totalCount = firstResponse.totalCount ?? 0;

      // Gọi lại API với pageSize là totalCount để lấy toàn bộ học viên
      var coachData = await Api.getAllCoaches(1, totalCount);

      allCoaches.addAll(coachData.coaches!);

      coaches.value = allCoaches; // Cập nhật danh sách học viên
      print('Total coaches loaded: ${coaches.length}');
    } catch (e) {
      print('Error loading coaches: $e');
    } finally {}
  }

  void loadAllLocations() async {
    List<Location> allLocations = [];
    try {
      // Gọi API với page = 1 để lấy totalCount
      var firstResponse = await Api.getAllLocations(
          1, 1); // Gọi API để lấy totalCount, chỉ cần 1 record

      // Lấy totalCount để làm pageSize
      int totalCount = firstResponse.totalCount ?? 0;

      // Gọi lại API với pageSize là totalCount để lấy toàn bộ học viên
      var loactionData = await Api.getAllLocations(1, totalCount);

      allLocations.addAll(loactionData.locations!);

      locations.value = allLocations; // Cập nhật danh sách học viên
      print('Total locations loaded: ${locations.length}');
    } catch (e) {
      print('Error loading locations: $e');
    } finally {}
  }

  String generateRandomNumberId() {
    final random = Random();
    return random
        .nextInt(1000000)
        .toString()
        .padLeft(6, '0'); // Sinh số ngẫu nhiên từ 000000 đến 999999
  }

// Dropdown values and controllers
  RxBool selectedGender = true.obs;
  RxInt selectedShift = 0.obs;
  RxInt selectedStatus = 0.obs;
  var selectedCourseId = Rxn<int>();
  var selectedCoachId = Rxn<int>();
  var selectedLocationId = Rxn<int>();

  // Gender options
  final Map<String, bool> genderOptions = {
    'Nam': true,
    'Nữ': false,
  };

  @override
  void onInit() async {
    super.onInit();
    loadAllCoaches();
    loadAllLocations();
  }

  // Shift options
  final Map<String, int> shiftOptions = {
    "Ca 1: (8:00 - 10:00)": 0,
    "Ca 2: (10:00 - 12:00)": 1,
    "Ca 3: (14:00 - 16:00)": 2,
    "Ca 4: (15:00 - 17:00)": 3,
    "Ca 5: (16:00 - 18:00)": 4,
    "Ca 6: (18:00 - 20:00)": 5,
    "Ca 7: (20:00 - 22:00)": 6,
  };

  // Status options
  final Map<String, int> statusOptions = {
    'Còn học': 0,
    'Nghỉ học': 1,
    'Tạm nghỉ': 2,
  };

  // DropdownButton widgets
  DropdownButton<bool> genderDropdown() {
    return DropdownButton<bool>(
      value: selectedGender.value,
      onChanged: (bool? newValue) {
        if (newValue != null) {
          selectedGender.value = newValue;
        }
      },
      items: genderOptions.entries.map<DropdownMenuItem<bool>>((entry) {
        return DropdownMenuItem<bool>(
          value: entry.value,
          child: Text(entry.key),
        );
      }).toList(),
    );
  }

  DropdownButton<int> shiftDropdown() {
    return DropdownButton<int>(
      value: selectedShift.value,
      onChanged: (int? newValue) {
        if (newValue != null) {
          selectedShift.value = newValue;
        }
      },
      items: shiftOptions.entries.map<DropdownMenuItem<int>>((entry) {
        return DropdownMenuItem<int>(
          value: entry.value,
          child: Text(entry.key),
        );
      }).toList(),
    );
  }

  String convertToIsoDate(String date) {
    print('Start date before conversion: $date');

    // Định dạng đầu vào của ngày
    DateFormat inputFormat = DateFormat("yyyy-MM-dd");
// Định dạng đầu ra của ngày giờ ISO 8601
    DateFormat outputFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ");

    try {
      // Chuyển từ chuỗi ngày sang DateTime
      DateTime parsedDate = inputFormat.parse(date);
      // Chuyển từ DateTime sang chuỗi ISO 8601
      String isoDate =
          outputFormat.format(parsedDate.toUtc()); // Đổi sang UTC nếu cần thiết
      return isoDate;
    } catch (e) {
      print('Error parsing date: $e');
      return ''; // Trả về chuỗi rỗng nếu có lỗi
    }
  }

  DropdownButton<int> statusDropdown() {
    return DropdownButton<int>(
      value: selectedStatus.value,
      onChanged: (int? newValue) {
        if (newValue != null) {
          selectedStatus.value = newValue;
        }
      },
      items: statusOptions.entries.map<DropdownMenuItem<int>>((entry) {
        return DropdownMenuItem<int>(
          value: entry.value,
          child: Text(entry.key),
        );
      }).toList(),
    );
  }

  void customSnackBar(BuildContext context, String title, String message,
      {bool isSuccess = true}) {
    final Color backgroundColor =
        isSuccess ? Color.fromARGB(255, 223, 248, 230) : Color(0xfffaefeb);
    final Color iconColor = isSuccess ? Colors.white : Colors.white;
    final IconData icon = isSuccess ? Icons.check : Icons.error;
    final Color borderColor = isSuccess ? Color(0xfff5ede7) : Color(0xfff5ede7);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Làm cho snackbar trong suốt
        content: Container(
          width: double.infinity,
          height: 70.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(15),
            color: backgroundColor,
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: isSuccess ? Color(0xff79de88) : Color(0xfff45257),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 26.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        message,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                child: Icon(
                  Icons.close,
                  color: Colors.grey,
                  size: 18.sp,
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 4),
      ),
    );
  }

  Future<void> createStudent(BuildContext context) async {
    final sub = await storage.read(key: 'sub');

    String startDate = stdStartDay.text;
    // if (startDate.isEmpty) {
    //   Get.snackbar('Lỗi', 'Ngày bắt đầu không được để trống');
    //   return;
    // }

    String isoStartDate = convertToIsoDate(startDate);
    if (isoStartDate.isEmpty) {
      customSnackBar(context, 'Lỗi', 'Ngày bắt đầu không hợp lệ',
          isSuccess: false);
      return;
    }

    isLoading.value = true;

    try {
      final response = await Api.postStudent(
        avatar: 'https://example.com/avatar.png',
        name: stdName.text,
        dob: stdDOB.text,
        phoneNumber: stdPhone.text.trim(),
        gender: selectedGender.value,
        address: stdAddress.text,
        numberId: generateRandomNumberId(),
        dateRange: '2024-09-16',
        issuedBy: 'Test Issued By',
        description: stdDescription.text,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        createdById: sub.toString(),
        shift: selectedShift.value,
        defaultTuitionFee: double.tryParse(stdTuition.text) ?? 0.0,
        status: 0,
        healthStatus: stdHealthStatus.text,
        height: double.tryParse(stdHeight.text) ?? 0.0,
        weight: double.tryParse(stdWeight.text) ?? 0.0,
        parents: [
          {
            'name': stdRelativeName.text,
            'phoneNumber': stdRelativePhone.text,
            'relationship': stdRelationship.text,
            'note': stdNote.text,
          },
        ],
        startDate: convertToIsoDate(stdStartDay.text),
        endDate: '2024-09-16T08:51:09.236Z',
      );

      if (response['success']) {
        final StudentController studentController = Get.find();
        await studentController.loadAllStudents();
        Get.back();
        //Get.snackbar('Thành công', response['message'], );
        // customSnackBar(context, 'Thành công', response['message'],
        //     isSuccess: true);
        customSnackBar(
            context, 'Thành công', 'Học viên đã được tạo thành công!',
            isSuccess: true);
      } else {
        // Hiển thị thông điệp lỗi từ server
        // Get.snackbar('Lỗi', response['message']);
        customSnackBar(context, 'Lỗi', 'Dữ liệu không hợp lệ',
            isSuccess: false);
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Có lỗi xảy ra khi tạo sinh viên: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
