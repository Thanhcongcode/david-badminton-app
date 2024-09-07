import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchContainer extends StatelessWidget {
  SearchContainer({
    super.key,
    required this.searchBarWidth,
    required this.text,
  });

  final double searchBarWidth;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: searchBarWidth,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: text,
          border: InputBorder.none,
          icon: Icon(Icons.search),
        ),
      ),
    );
  }
}
