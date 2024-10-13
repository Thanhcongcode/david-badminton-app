import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:david_badminton/utils/device/app_device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {super.key,
      this.title,
      this.transparent = true,
      this.actions,
      this.leadingIcon,
      this.leadingOnPressed,
      this.showBackArrow = false,
      this.centerTitle = false});

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final bool centerTitle;
  final bool transparent;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      iconTheme: IconThemeData(color: Colors.white),
      centerTitle: centerTitle,
      scrolledUnderElevation: 0,
      backgroundColor:
          transparent ? Colors.transparent : AppColor.secondaryBlue,
      surfaceTintColor: Colors.transparent, //size chu 18 w600, icon 24
      automaticallyImplyLeading: false,
      leading: showBackArrow
          ? IconButton(
              onPressed: () => Get.back(),
              icon: Icon(IconlyLight.arrow_left),
            )
          : leadingIcon != null
              ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon))
              : null,
      title: title,
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppDevice.getAppBarHeight());
}
