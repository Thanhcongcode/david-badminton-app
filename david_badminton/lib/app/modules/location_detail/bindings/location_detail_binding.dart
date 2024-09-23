import 'package:david_badminton/app/modules/location_detail/controllers/location_detail_controller.dart';
import 'package:get/get.dart';

class LocationDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationDetailController>(() => LocationDetailController());
  }
}