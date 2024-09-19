import 'package:david_badminton/model/coach.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:david_badminton/model/student.dart';

class CoachDetailController extends GetxController {
  // Biến để lưu thông tin của học sinh hiện tại
  late Coach coaches;
  RxBool isEdit = false.obs;

  TextEditingController hlvName = TextEditingController();
  TextEditingController hlvPhone = TextEditingController();
  TextEditingController hlvAdress = TextEditingController();
  TextEditingController hlvDob = TextEditingController();
  TextEditingController hlvDescription = TextEditingController();
  TextEditingController hlvGender = TextEditingController();

  TextEditingController example = TextEditingController();

  

  @override
  void onInit() {
    super.onInit();
    // Nhận thông tin học sinh từ argument khi điều hướng
    coaches = Get.arguments as Coach;
    
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toggleEdit() {
    isEdit.value = !isEdit.value;
  }

  final RxList<String> classSessions = <String>[
    "Ca 1: (8:00 - 10:00)",
    "Ca 2: (10:00 - 12:00)",
    "Ca 3: (14:00 - 16:00)",
    "Ca 4: (15:00 - 17:00)",
    "Ca 5: (16:00 - 18:00)",
    "Ca 6: (18:00 - 20:00)",
    "Ca 7: (20:00 - 22:00)",
  ].obs;

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