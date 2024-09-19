import 'package:david_badminton/app/modules/home/views/home_screen.dart';
import 'package:david_badminton/app/modules/login/controllers/login_controller.dart';
import 'package:david_badminton/navigation_menu.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:david_badminton/utils/constants/app_size.dart';
import 'package:david_badminton/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: TextFormField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: controller.userName,
              keyboardType: TextInputType.text,
              validator: (value) => Validation.validateUserName(value),
              // onChanged: (value) {
              //   controller.loginFormKey.currentState!.validate();
              // },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 18.h, horizontal: 5.w),
                  isDense: true,
                  prefixIcon: Icon(
                    IconlyLight.user_1,
                    size: 24.sp,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black26),
                  ),
                  hintText: 'Tên đăng nhập',
                  label: Text(
                    'Tên đăng nhập',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  floatingLabelStyle: TextStyle(color: AppColor.primaryOrange),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16.sp),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColor.primaryOrange),
                  ),
                  fillColor: Colors.white),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),

          //mat khau
          Obx(
            () => SizedBox(
              width: double.infinity,
              child: TextFormField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                controller: controller.passwordController,
                keyboardType: TextInputType.text,
                obscureText: controller.hidePassword.value,
                obscuringCharacter: '*',
                validator: (value) =>
                    Validation.validateEmtyText('Mật khẩu', value),
                //
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 18.h, horizontal: 5.w),
                    isDense: true,
                    prefixIcon: Icon(IconlyLight.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.hidePassword.value =
                            !controller.hidePassword.value;
                      },
                      icon: controller.hidePassword.value
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black26),
                    ),
                    hintText: 'Mật khẩu',
                    label: Text(
                      'Mật khẩu',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    floatingLabelStyle:
                        TextStyle(color: AppColor.primaryOrange),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16.sp),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColor.primaryOrange),
                    ),
                    fillColor: Colors.white),
              ),
            ),
          ),

          SizedBox(height: 12.h),

          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {},
              child: Text(
                'Quên mật khẩu?',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColor.primaryBlue),
              ),
            ),
          ),

          SizedBox(
            height: AppSize.spaceBtwSections.h,
          ),

          Obx(() => SizedBox(
                height: 52.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                          if (controller.loginFormKey.currentState!
                              .validate()) {
                            controller.login();
                          }
                        },
                  child: controller.isLoading.value
                      ? SizedBox(
                          height: 24.w,
                          width: 24.w,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Text('Đăng nhập'),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    foregroundColor: Colors.white,
                    backgroundColor: AppColor.primaryBlue,
                    disabledForegroundColor: Colors.grey,
                    disabledBackgroundColor: AppColor.primaryBlue,
                    side: BorderSide(
                      color: AppColor.primaryBlue,
                    ),
                    textStyle: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              )),
          SizedBox(
            height: AppSize.spaceBtwSections.h,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bạn chưa có tài khoản?',
                style: TextStyle(fontSize: 16.sp),
              ),
              GestureDetector(
                //onTap: () => Get.to(RegisterScreen()),
                child: Text(
                  ' Đăng ký',
                  style: TextStyle(
                    color: Color(0xff468585),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 16.h,
          ),

          TextButton(
            onPressed: () {},
            child: Text(
              'Hướng dẫn sử dụng',
              style: TextStyle(color: AppColor.primaryOrange, fontSize: 16.sp),
            ),
          ),
        ],
      ),
    );
  }
}
