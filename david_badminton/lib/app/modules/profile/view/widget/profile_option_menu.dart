import 'package:david_badminton/common/components/text_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class ProfileOptionComponent extends StatelessWidget {
  ProfileOptionComponent(
      {super.key, required this.text, required this.icon, required this.onTap});

  String text;
  Widget icon;
  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: const Color.fromARGB(255, 128, 128, 128),
                    offset: Offset(1, 3),
                    blurRadius: 4,
                    blurStyle: BlurStyle.outer)
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    icon,
                    SizedBox(
                      width: 10.w,
                    ),
                    TextComponent(
                      content: text,
                      size: 25.sp,
                    ),
                  ],
                ),
                Icon(
                  IconlyLight.arrow_right_2,
                  size: 26.sp,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
