import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchContainer extends StatelessWidget {
  SearchContainer(
      {super.key,
      required this.searchBarWidth,
      required this.text,
      this.focusNode});

  final double searchBarWidth;
  final String text;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: CupertinoSearchTextField(
        autofocus: false,
        placeholder: 'Tìm kiếm...',
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        focusNode: focusNode,
      ),
    );
  }
}
