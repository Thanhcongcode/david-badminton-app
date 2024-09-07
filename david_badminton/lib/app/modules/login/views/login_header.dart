import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:david_badminton/utils/constants/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 200.h,
          width: 150.w,
          child: Image.asset(
            'assets/logos/logo.png',
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Thông tin đăng nhập',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
