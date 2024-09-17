import 'dart:io';

import 'package:david_badminton/api/api.dart';
import 'package:david_badminton/app/modules/login/views/login_screen.dart';
import 'package:david_badminton/navigation_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  void logout() async {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Đăng xuất'),
            content: Text('Bạn có chắc chắn muốn đăng xuất?'),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Hủy'),
                onPressed: () {
                  print("Đã chọn Hủy");
                  Get.back(); // Chỉ đóng dialog
                },
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('Đăng xuất'),
                onPressed: () async {
                  print("Đã chọn Đăng xuất");
                  Get.back(); // Đóng dialog trước khi hiển thị loading

                  // Hiển thị loading
                  Get.dialog(
                    Center(child: CircularProgressIndicator()),
                    barrierDismissible: false,
                  );

                  try {
                    await Api.logout();
                    Get.offAll(() => LoginScreen());
                  } catch (e) {
                    Get.back(); // Đóng loading dialog
                    Get.snackbar('Lỗi', 'Đăng xuất thất bại: $e');
                  }
                },
              ),
            ],
          );
        },
      );
    } else {
      Get.defaultDialog(
        title: 'Đăng xuất',
        middleText: 'Bạn có chắc chắn muốn đăng xuất?',
        textCancel: 'Hủy',
        textConfirm: 'Đăng xuất',
        confirmTextColor: Colors.white,
        
        onConfirm: () async {
          print("Đã chọn Đăng xuất");
          Get.back(); // Đóng dialog trước khi hiển thị loading

          // Hiển thị loading
          Get.dialog(
            Center(child: CircularProgressIndicator()),
            barrierDismissible: false,
          );

          try {
            await Api.logout();
            Get.offAll(() => LoginScreen());
          } catch (e) {
            Get.back(); // Đóng loading dialog
            Get.snackbar('Lỗi', 'Đăng xuất thất bại: $e');
          }
        },
      );
    }
  }
}
