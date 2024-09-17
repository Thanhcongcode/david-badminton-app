import 'package:david_badminton/app/modules/add_student/controllers/add_student_controller.dart';
import 'package:get/get.dart';

class AddStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddStudentController>(
      () => AddStudentController(),
    );
  }
}
