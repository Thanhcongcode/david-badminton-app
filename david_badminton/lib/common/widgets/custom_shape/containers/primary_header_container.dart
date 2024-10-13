import 'package:david_badminton/common/widgets/custom_shape/containers/circular_container.dart';
import 'package:david_badminton/common/widgets/custom_shape/curved_edges/curved_eadge_widget.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  PrimaryHeaderContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;

    // // Tính chiều cao tự động dựa trên kích thước của nội dung
    // final headerHeight = child != null
    //     ? child is SizedBox
    //         ? (child as SizedBox).height ?? 0
    //         : height * 0.25 // giá trị mặc định nếu không có chiều cao cụ thể
    //     : height * 0.25;

    return CurvedEdgeWidget(
      child: Container(
        color: AppColor.secondaryBlue,
        padding: EdgeInsets.all(0),
        child: Stack(
          //có sizebox bao cái stack height = headerheight
          children: [
            Positioned(
              top: -75.h,
              right: -100.w,
              child: CircularContainer(
                height: 200.h,
                width: 200.h,
                radius: 200.sp,
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100.h,
              right: -100.w,
              child: CircularContainer(
                height: 200.h,
                width: 200.h,
                radius: 200.sp,
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
