
import 'package:david_badminton/app/modules/coach_detail/controllers/coach_detail_controller.dart';
import 'package:get/get.dart';

class CoachDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoachDetailController>(() => CoachDetailController());
  }
}