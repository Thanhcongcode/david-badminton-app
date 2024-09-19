import 'package:david_badminton/app/modules/coach/controllers/coach_controller.dart';
import 'package:get/get.dart';

class CoachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoachController>(
      () => CoachController(),
    );
  }
}
