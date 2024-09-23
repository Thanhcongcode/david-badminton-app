import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:david_badminton/model/student.dart';

class StudentDetailController extends GetxController {
  // Biến để lưu thông tin của học sinh hiện tại
  late Student student;
  RxBool isEdit = false.obs;

  TextEditingController stdName = TextEditingController();
  TextEditingController stdPhoneNumber = TextEditingController();
  TextEditingController stdAddress = TextEditingController();
  TextEditingController stdDob = TextEditingController();
  TextEditingController stdnumberId = TextEditingController();
  TextEditingController stdGender = TextEditingController();
  TextEditingController stdCourseName = TextEditingController();
  TextEditingController stdCoachName = TextEditingController();
  TextEditingController stdLocationName = TextEditingController();
  TextEditingController stdShift = TextEditingController();
  TextEditingController stdAvatar = TextEditingController();
  TextEditingController stdDescription = TextEditingController();

  TextEditingController stdTuitionFee = TextEditingController();
  TextEditingController stdStatus = TextEditingController();
  TextEditingController stdCreateAt = TextEditingController();
  TextEditingController stdHealthStatus = TextEditingController();
  TextEditingController stdHeight = TextEditingController();
  TextEditingController stdWeight = TextEditingController();

  TextEditingController stdGuardianName = TextEditingController();
  TextEditingController stdGuardianGender = TextEditingController();
  TextEditingController stdGuardianRelation = TextEditingController();
  TextEditingController stdGuardianPhone = TextEditingController();
  TextEditingController stdGuardianNote = TextEditingController();
  //ngay bat dau, mo ta, ten ng giuam ho, quan hge, gioi tinh, inej thoai, hji chu, thogn tin suc khoe, chieu cao, can nang

  @override
  void onInit() {
    super.onInit();
    // Nhận thông tin học sinh từ argument khi điều hướng
    student = Get.arguments as Student;
    getShiftName(student.shift);
    setStudentStatusToTextController();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toggleEdit() {
    isEdit.value = !isEdit.value;
  }

  RxBool selectedGender = true.obs;
  RxBool selectedGuardianGender = true.obs;

  RxInt selectedShift = 0.obs;
  RxInt selectedStatus = 0.obs; // Không sử dụng nullable

  RxInt selectedCourseId = 0.obs;
  RxInt? selectedCoachId;
  RxInt? selectedLocationId;

  final RxList<String> classSessions = <String>[
    "Ca 1: (8:00 - 10:00)",
    "Ca 2: (10:00 - 12:00)",
    "Ca 3: (14:00 - 16:00)",
    "Ca 4: (15:00 - 17:00)",
    "Ca 5: (16:00 - 18:00)",
    "Ca 6: (18:00 - 20:00)",
    "Ca 7: (20:00 - 22:00)",
  ].obs;
  // Status options
  final Map<String, int> statusOptions = {
    'Còn học': 0,
    'Nghỉ học': 1,
    'Tạm nghỉ': 2,
  };

  String? getStatusString(int status) {
return statusOptions.entries
        .firstWhere(
          (entry) => entry.value == status,
          orElse: () =>
              MapEntry('Unknown', -1), // Giá trị mặc định nếu không tìm thấy
        )
        .key;
  }

  void setStudentStatusToTextController() {
    final int statusValue =
        student.status; // Giá trị status kiểu int
    final String? statusString =
        getStatusString(statusValue); // Lấy chuỗi tương ứng

    if (statusString != null) {
      stdStatus.text =
          statusString; // Gán chuỗi vào TextEditingController
    }
  }

  // Phương thức để chuyển đổi số nguyên thành tên ca học
  String getShiftName(int shift) {
    if (shift >= 0 && shift < classSessions.length) {
      return classSessions[shift];
    } else {
      return 'Ca học không hợp lệ';
    }
  }

  // Danh sách giá trị tương ứng với các ca học
}