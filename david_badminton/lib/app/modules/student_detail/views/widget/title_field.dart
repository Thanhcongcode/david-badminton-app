import 'package:david_badminton/common/components/text_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleField extends StatelessWidget {
  TitleField({super.key, required this.title});

  String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextComponent(
          content: title,
          size: 16.sp,
          weight: FontWeight.w500,
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }
}
