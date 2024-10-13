import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FunctionButton extends StatelessWidget {
  const FunctionButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  final VoidCallback onPressed;
  final String label;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 75.h,
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: AppColor.secondaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: SvgPicture.asset(
              icon,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: 90.w, // Điều chỉnh chiều rộng nhãn
            height: 40
                .h, // Chiều cao cố định để đảm bảo tất cả các nhãn có cùng chiều cao
            alignment: Alignment.center, // Canh giữa nội dung
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              maxLines: 3, // Giới hạn số dòng
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
