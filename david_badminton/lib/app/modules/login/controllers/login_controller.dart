import 'package:david_badminton/api/api.dart';
import 'package:david_badminton/model/auth.dart';
import 'package:david_badminton/navigation_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'dart:io';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final hidePassword = true.obs;
  final isLoading = false.obs;
  final userName = TextEditingController();
  final passwordController = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userName.dispose();
    passwordController.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  void showLoading() {
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: true,
    );
  }

  void hideLoading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  void login() async {
    if (loginFormKey.currentState!.validate()) {
      isLoading.value = true;
      //showLoading();
      Auth auth = Auth(
        client_id: 'david-badminton',
        client_secret: 'cKsOV4TijqHbSqnPrv5aIvb5mIBBd8bv',
        grant_type: 'password',
        username: userName.value.text,
        password: passwordController.value.text,
      );

      try {
        await Api.postLoginApi(auth);

        //hideLoading();
        isLoading.value = false;
        Get.to(() => NavigationMenu());
      } catch (e) {
        //hideLoading();
        isLoading.value = false;
        showLoginErrorDialog('Sai mật khẩu hoặc thông tin không hợp lệ.');
      }
    }
  }

  // void showCustomFlushbar(String message) {
  //   Flushbar(
  //     flushbarPosition: FlushbarPosition.TOP,
  //     // margin: EdgeInsets.only(top: 50.h),

  //     message: message,
  //     duration: Duration(seconds: 3), // Thời gian hiển thị
  //     backgroundColor: Colors.black.withOpacity(0.8),

  //     messageText: Text(
  //       message,
  //       style: TextStyle(
  //         color: Colors.white,
  //         fontSize: 16,
  //       ),
  //       textAlign: TextAlign.center,
  //     ),
  //   )..show(Get.context!);
  // }

  void showLoginErrorDialog(String message) {
    if (Platform.isIOS) {
      Get.dialog(
        CupertinoAlertDialog(
          title: Text('Lỗi đăng nhập'),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: Text('Ok'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      );
    } else if (Platform.isAndroid) {
      Get.dialog(AlertDialog(
        title: Text('Lỗi đăng nhập'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Ok'),
          )
        ],
      ));
    }
  }
}
