import 'package:david_badminton/app/modules/attendance/controllers/attendance_controller.dart';
import 'package:david_badminton/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:david_badminton/common/widgets/custom_shape/containers/primary_header_container.dart';
import 'package:david_badminton/app/modules/home/views/widget/home_app_bar.dart';
import 'package:david_badminton/common/widgets/custom_shape/containers/search_container.dart';
import 'package:david_badminton/app/modules/home/views/widget/function/branch_management.dart';
import 'package:david_badminton/app/modules/home/views/widget/function/human_management.dart';
import 'package:david_badminton/app/modules/home/views/widget/function/tuition_fee.dart';
import 'package:david_badminton/common/widgets/texts/section_heading.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceController = Get.put(AttendanceController());
    final controller = Get.put(HomeController());
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final double searchBarWidth = width * 0.8;
    final double searchBarHeight = 48.h;
    final double headerHeight = height * 0.25; // PrimaryHeaderContainer height

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: headerHeight,
              //pinned: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: PrimaryHeaderContainer(
                  child: Column(
                    children: [
                      HomeAppBar(),
                    ],
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(searchBarHeight),
                child: Container(
                  width: searchBarWidth,
                  height: searchBarHeight,
                  margin: EdgeInsets.symmetric(
                      horizontal: (width - searchBarWidth) / 2),
                  child: SearchContainer(
                    searchBarWidth: searchBarWidth,
                    text: 'Tìm kiếm...',
                    focusNode: controller.searchFocusNode,
                  ),
                ),
              ),
              automaticallyImplyLeading: false, // Remove the back button
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 24.w),
                      child: SectionHeading(
                        title: 'QUẢN LÝ NHÂN SỰ',
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // Phần chức năng
                    HumanManagement(),

                    SizedBox(height: 24.h),

                    // Phần cơ sở
                    Padding(
                      padding: EdgeInsets.only(left: 24.w),
                      child: SectionHeading(title: 'CƠ SỞ'),
                    ),
                    SizedBox(height: 16.h),
                    BranchManagement(),

                    SizedBox(height: 24.h),
                    Padding(
                      padding: EdgeInsets.only(left: 24.w),
                      child: SectionHeading(title: 'HỌC PHÍ'),
                    ),
                    SizedBox(height: 16.h),
                    TuitionFee(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
