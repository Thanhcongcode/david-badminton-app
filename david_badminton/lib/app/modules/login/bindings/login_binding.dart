import 'package:david_badminton/app/modules/login/controllers/login_controller.dart';
import 'package:get/get.dart';

class CustomerDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}