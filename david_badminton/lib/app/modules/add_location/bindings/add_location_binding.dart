import 'package:david_badminton/app/modules/add_location/controllers/add_location_controller.dart';

import 'package:get/get.dart';

class AddCoachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddLocationController>(
      () => AddLocationController(),
    );
  }
}
