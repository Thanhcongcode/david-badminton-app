import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextComponent extends StatelessWidget {
  TextComponent(
      {super.key,
      this.isTitle = false,
      required this.content,
      this.size = 16,
      this.weight = FontWeight.normal,
      this.decoration = TextDecoration.none,
      this.color = Colors.black,
      this.fontStyle = FontStyle.normal,
      this.textAlign = TextAlign.left,
      this.softWrap = false,
      this.maxLines,
      this.overflow});

  bool isTitle;
  String content;
  double size;
  FontWeight weight;
  TextDecoration decoration;
  Color color;
  FontStyle fontStyle;
  TextAlign textAlign;
  bool softWrap;
  int? maxLines;
  TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    if (isTitle == false) {
      return Text(
        content,
        style: TextStyle(
            fontSize: size,
            fontWeight: weight,
            decoration: decoration,
            color: color),
        textAlign: textAlign,
        softWrap: softWrap,
        maxLines: maxLines,
        overflow: overflow,
      );
    } else {
      return Text(
        content,
        style: TextStyle(
          fontSize: 24.sp,
          color: color,
          fontStyle: fontStyle,
          decoration: decoration,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
}
