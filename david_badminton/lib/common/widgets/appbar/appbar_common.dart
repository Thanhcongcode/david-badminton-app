import 'package:david_badminton/common/components/text_component.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:david_badminton/utils/device/app_device.dart';
import 'package:flutter/material.dart';

class AppBarCommon extends StatelessWidget implements PreferredSizeWidget {
  AppBarCommon(
      {super.key,
      required this.title,
      this.automaticallyImplyLeading = true,
      this.actions = const []});
  String title;
  bool automaticallyImplyLeading;
  List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: TextComponent(
        content: title,
        color: Colors.white,
        isTitle: true,
      ),
      backgroundColor: AppColor.secondaryBlue,
      centerTitle: true,
      actions: actions,
      iconTheme: IconThemeData(color: Colors.white),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppDevice.getAppBarHeight());
}
