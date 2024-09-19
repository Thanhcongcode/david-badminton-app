import 'dart:io';

import 'package:david_badminton/api/api.dart';
import 'package:david_badminton/model/attend_data.dart/coach_attend.dart';
import 'package:david_badminton/model/attend_data.dart/course_attend.dart';
import 'package:david_badminton/model/attend_data.dart/location_attend.dart';
import 'package:david_badminton/model/attend_data.dart/student_attend.dart';
import 'package:david_badminton/model/location.dart';
import 'package:david_badminton/model/coach.dart';
import 'package:david_badminton/model/student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

final storage = FlutterSecureStorage();

class AttendanceController extends GetxController {
  var dateController = TextEditingController();

  var selectedBranchId = Rxn<int>();
  var selectedShiftId = Rxn<int>();
  var selectedCoachId = Rxn<int>();
  var selectedCourseId = Rxn<int>();

  RxBool showTable = false.obs;

  RxBool isSearchEnabled = false.obs; // Thay đổi trạng thái của nút tìm kiếm

  //cái này mới nè
  Rx<Future<void>> fetchAttendDataFuture = Rx(Future.value());

  // RxLists để lưu dữ liệu từ API
  RxList<LocationAttend> locations = <LocationAttend>[].obs;
  RxList<CoachAttend> coaches = <CoachAttend>[].obs;
  RxList<CourseAttend> courses = <CourseAttend>[].obs;

  RxList<StudentAttend> attendStudent = <StudentAttend>[].obs;

  Future<void> fetchAttendData() async {
    try {
      final attendData = await Api.getAttendData();

      // Cập nhật các biến Rx với dữ liệu trả về từ API
      locations.value = attendData['locations'];
      coaches.value = attendData['coaches'];
      courses.value = attendData['courses'];

      for (var student in attendStudent) {
        student.isPresent = await getStudentAttendance(student.id);
      }

      print(locations);
      print(coaches);
      print(courses);
    } catch (e) {
      print('Error fetching attend data: $e');
    }
  }

  Future<void> searchStudents() async {
    if (selectedBranchId.value == null ||
        selectedCourseId.value == null ||
        selectedCoachId.value == null ||
        selectedShiftId.value == null ||
        dateController.text.isEmpty) {
      print('All fields must be selected');
      return;
    }

    try {
      // Đảm bảo định dạng ngày khớp với chuỗi trong dateController.text
      final selectedDate = DateFormat('yyyy-MM-dd').parse(dateController.text);
      print("Date string: ${dateController.text}");
      print("Parsed date: $selectedDate");

      final students = await Api.getStudentAttendList(
        locationId: selectedBranchId.value!,
        courseId: selectedCourseId.value!,
        coachId: selectedCoachId.value!,
        shift: selectedShiftId.value!,
        createdAt: selectedDate,
);

      for (var student in attendStudent) {
        student.isPresent = await getStudentAttendance(student.id);
      }

      // Cập nhật danh sách học sinh
      attendStudent.value = students;
      updateShowTable(); // Hiển thị bảng điểm danh sau khi tìm kiếm
    } catch (e) {
      print('Error fetching students: $e');
    }
  }

  //lưu trạng thái isPresent của học viên
  Future<void> saveStudentAttendance(int studentId, bool isPresent) async {
    await storage.write(key: 'student_$studentId', value: isPresent.toString());
  }

  //đọc trạng thái isPresent của học viên
  Future<bool> getStudentAttendance(int studentId) async {
    final value = await storage.read(key: 'student_$studentId');
    return value == 'true'; // Chuyển đổi từ String về bool
  }

  //Cập nhật trạng thái khi checkbox thay đổi:
  void updateStudentAttendance(int studentId, bool isPresent) async {
    final index =
        attendStudent.indexWhere((student) => student.id == studentId);
    if (index != -1) {
      attendStudent[index].isPresent = isPresent;
      await saveStudentAttendance(
          studentId, isPresent); // Lưu trạng thái vào FlutterSecureStorage
      attendStudent.refresh(); // Cập nhật giao diện
    }
  }

  // Chuyển đổi định dạng ngày từ dd/MM/yyyy sang ISO8601
  String convertToIsoDate(String date) {
    DateFormat inputFormat = DateFormat('yyyy/MM/dd'); // Định dạng gốc
    DateTime parsedDate =
        inputFormat.parse(date); // Chuyển từ string sang DateTime
    String isoDate = parsedDate.toIso8601String(); // Chuyển thành ISO8601
    return isoDate;
  }

  Future<void> saveAttendance(BuildContext context) async {
    if (selectedBranchId.value == null ||
        selectedCourseId.value == null ||
        selectedCoachId.value == null ||
        selectedShiftId.value == null) {
      print('All fields must be selected');
      return;
    }

    List<int> studentIds = attendStudent
        .where((student) => student.isPresent)
        .map((student) => student.id)
        .toList();
    // Debug print
    print('Selected student IDs: $studentIds');

    if (studentIds.isEmpty) {
      print('No students selected');
      return;
    }

    try {
      // Lấy geolocation
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Lấy user ID từ access token (giả sử bạn đã có hàm để lấy user ID)

      // Gọi hàm saveAttendance từ lớp API
      await Api.postSaveAttendance(
        createdAt: convertToIsoDate(dateController.text),
        shift: selectedShiftId.value!,
        coachId: selectedCoachId.value!,
        courseId: selectedCourseId.value!,
        locationId: selectedBranchId.value!,
        position: position,
        studentIds: studentIds,
      );
      showAttendanceSuccessDialog(context);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
void onInit() async {
    super.onInit();
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    print(dateController.text);

    fetchAttendData();
  }

  void updateSearchButtonState() {
    isSearchEnabled.value = selectedBranchId.value != null &&
        selectedShiftId.value != null &&
        selectedCoachId.value != null &&
        selectedCourseId.value != null;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void updateShowTable() {
    showTable.value = !showTable.value;
  }

  void updateBranch(int? branchId) {
    selectedBranchId.value = branchId;
    print(selectedBranchId);
    updateSearchButtonState();
  }

  void updateShift(int? shiftId) {
    selectedShiftId.value = shiftId;
    updateSearchButtonState();
    print(selectedShiftId);
  }

  void updateCourse(int? courseId) {
    selectedCourseId.value = courseId;
    updateSearchButtonState();
    print(selectedCourseId);
  }
  // Cập nhật giá trị đã chọn

  void updateCoach(int? coachId) {
    selectedCoachId.value = coachId;
    updateSearchButtonState();
    print(selectedCoachId);
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      dateController.text = '${pickedDate.toLocal()}'
          .split(' ')[0]; // Format the date as YYYY-MM-DD
    }
  }

  // Danh sách học sinh

  final RxList<String> classSessions = <String>[
    "Ca 1: (8:00 - 10:00)",
    "Ca 2: (10:00 - 12:00)",
    "Ca 3: (14:00 - 16:00)",
    "Ca 4: (15:00 - 17:00)",
    "Ca 5: (16:00 - 18:00)",
    "Ca 6: (18:00 - 20:00)",
    "Ca 7: (20:00 - 22:00)",
  ].obs;

  // Danh sách giá trị tương ứng với các ca học
  final RxList<int> classSessionValues = List.generate(7, (index) => index).obs;

  // Trang hiện tại và số lượng hàng mỗi trang
  var _currentPage = 0.obs;
  var _rowsPerPage = 10.obs;

  int get currentPage => _currentPage.value;
  set currentPage(int page) => _currentPage.value = page;

  int get rowsPerPage => _rowsPerPage.value;
  set rowsPerPage(int rows) => _rowsPerPage.value = rows;

  List<StudentAttend> get paginatedStudents {
    final startIndex = currentPage * rowsPerPage;
    final endIndex = (startIndex + rowsPerPage < attendStudent.length)
        ? startIndex + rowsPerPage
        : attendStudent.length;
    return attendStudent.sublist(startIndex, endIndex);
  }

  int get totalPages => (attendStudent.length / rowsPerPage).ceil();
  void showAttendanceSuccessDialog(BuildContext context) {
    if (Platform.isAndroid) {
      // Hiển thị AlertDialog cho Android
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thành công'),
content: const Text('Điểm danh đã được lưu thành công.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else if (Platform.isIOS) {
      // Hiển thị CupertinoAlertDialog cho iOS
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Thành công'),
            content: const Text('Điểm danh đã được lưu thành công.'),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}