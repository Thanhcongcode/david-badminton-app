import 'package:david_badminton/app/modules/login/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/logos/logo.png',
                  height: 300.h,
                  width: 200.w,
                ),

                SizedBox(height: 16.h),

                // Welcome Text
                Text(
                  'Chào mừng bạn đến với David Education',
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 16.h),

                // Prompt Text
                Text(
                  'Vui lòng nhấn mũi tên để chuyển hướng đăng nhập',
                  style: TextStyle(fontSize: 16.sp),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 30.h),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => LoginScreen());
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        side: BorderSide(color: Colors.black, width: 0.5),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        backgroundColor: Colors.white),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/logos/keycloak.png',
                          height: 26.sp,
                          width: 26.sp,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Đăng nhập sử dụng Keycloak',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
