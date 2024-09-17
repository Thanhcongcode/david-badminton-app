import 'package:david_badminton/app/modules/attendance/controllers/attendance_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class AttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AttendanceController()); // Khởi tạo controller khi cần
  }
}