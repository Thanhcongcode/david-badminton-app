import 'package:david_badminton/app/modules/student_detail/controller/student_detail_controller.dart';
import 'package:get/get.dart';

class StudentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentDetailController>(() => StudentDetailController());
  }
}