import 'package:david_badminton/app/modules/profile/controller/profile_controller.dart';
import 'package:david_badminton/app/modules/profile/view/widget/profile_option_menu.dart';
import 'package:david_badminton/common/components/text_component.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColor.secondaryBlue,
        title: TextComponent(
          content: 'Hồ sơ',
          isTitle: true,
          color: Colors.white,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Icon(
              IconlyLight.edit_square,
              size: 26.sp,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 30.h),

          ProfileOptionComponent(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => UpdateInfo(name: userName),
              //   ),
              // );
            },
            text: 'Chỉnh sửa thông tin',
            icon: Icon(
              IconlyLight.info_circle,
              size: 30.sp,
            ),
          ),

          ProfileOptionComponent(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => AboutusScreen()),
              // );
            },
            text: 'Về chúng tôi',
            icon: Icon(
              IconlyLight.more_circle,
              size: 30.sp,
            ),
          ),
          ProfileOptionComponent(
              text: 'Đăng xuất',
              icon: Icon(
                IconlyLight.logout,
                size: 30,
              ),
              onTap: () {
                controller.logout();
              })
          // const SizedBox(height: 30),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          //   child: ElevatedButton(
          //     onPressed: () async {
          //       // await Api.signOut(context);
          //     },
          //     child: TextComponent(
          //       content: 'Đăng xuất',
          //       color: Colors.white,
          //       size: 25,
          //     ),
          //     style: ElevatedButton.styleFrom(
          //       fixedSize: Size(double.infinity, 50),
          //       backgroundColor: Theme.of(context).colorScheme.primary,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
