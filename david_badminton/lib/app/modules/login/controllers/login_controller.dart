import 'package:david_badminton/api/api.dart';
import 'package:david_badminton/model/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final hidePassword = true.obs;

  final userName = TextEditingController();
  final passwordController = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  void login() {
    Auth auth = Auth(
        client_id: 'david-badminton',
        client_secret: 'cKsOV4TijqHbSqnPrv5aIvb5mIBBd8bv',
        grant_type: 'password',
        username: userName.value.text,
        password: passwordController.value.text);
    Api.postLoginApi(auth);
  }
}
