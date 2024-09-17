import 'package:david_badminton/app/modules/student_list/controllers/student_controller.dart';
import 'package:get/get.dart';

class CustomerDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentController>(
      () => StudentController(),
    );
  }
}