import 'package:david_badminton/app/modules/add_coach/controllers/add_coach_controller.dart';

import 'package:get/get.dart';

class AddCoachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCoachController>(
      () => AddCoachController(),
    );
  }
}
