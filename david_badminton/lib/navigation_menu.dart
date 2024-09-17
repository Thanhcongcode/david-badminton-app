import 'package:david_badminton/app/modules/home/views/home_screen.dart';
import 'package:david_badminton/app/modules/profile/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
        bottomNavigationBar: Obx(
          () => NavigationBar(
            height: 80.h,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            destinations: [
              NavigationDestination(
                  icon: Icon(Icons.home_outlined), label: 'Trang chủ'),
              NavigationDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  label: 'Bảng điều khiển'),
              NavigationDestination(
                  icon: Icon(Icons.person_2_outlined), label: 'Người dùng'),
            ],
          ),
        ),
        body: Obx(
          () => controller.screens[controller.selectedIndex.value],
        ));
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    HomeScreen(),
    Container(
      color: Colors.blue,
    ),
    ProfileScreen(),
  ];
}
