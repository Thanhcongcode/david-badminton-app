import 'package:david_badminton/common/components/text_component.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:david_badminton/utils/device/app_device.dart';
import 'package:flutter/material.dart';
import 'package:david_badminton/common/widgets/custom_shape/containers/search_container.dart';

class AppBarCommon extends StatelessWidget implements PreferredSizeWidget {
  AppBarCommon({
    super.key,
    required this.title,
    this.automaticallyImplyLeading = true,
    this.actions = const [],
    this.onSearchChanged,
  });

  final String title;
  final bool automaticallyImplyLeading;
  final List<Widget> actions;
  final Function(String)? onSearchChanged; // Callback for search input

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
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
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      AppDevice.getAppBarHeight() + 50); // Adjust height for SearchContainer
}
