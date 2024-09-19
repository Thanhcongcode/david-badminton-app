import 'package:david_badminton/model/coach.dart';
import 'package:david_badminton/model/location.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:david_badminton/model/student.dart';

class LocationDetailController extends GetxController {
  // Biến để lưu thông tin của học sinh hiện tại
  late Location location;
  RxBool isEdit = false.obs;

  TextEditingController example = TextEditingController();
  TextEditingController locationName = TextEditingController();
  TextEditingController locationAddress = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Nhận thông tin học sinh từ argument khi điều hướng
    location = Get.arguments as Location;
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toggleEdit() {
    isEdit.value = !isEdit.value;
  }

  // Danh sách giá trị tương ứng với các ca học
}