import 'package:david_badminton/common/components/text_component.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class DropdownWidget extends StatelessWidget {
  DropdownWidget({
    super.key,
    required this.options,
    this.isDense = true,
    this.isExpanded = true,
    this.value,
    required this.hintText,
    required this.onChanged,
    required this.labelText,
    required this.icon,
  });
  // : _selectedValue = selectedValue;

  //final String? _selectedValue;

  bool isExpanded;
  bool isDense;
  String hintText;
  void Function(int) onChanged;
  final int? value;
  String labelText;
  Widget icon;
  List<dynamic> options;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: isExpanded,
      isDense: isDense,
      hint: TextComponent(
        content: hintText,
        size: 15.sp,
        overflow: TextOverflow.ellipsis,
      ),
      value: value,
      items: options.map((option) {
        return DropdownMenuItem<int>(
          value: option.id,
          child: TextComponent(
            content: option.name,
            size: 15.sp,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        if (newValue != null) {
          onChanged(newValue); // Truyền giá trị mới vào hàm onChanged
        }
      },
      icon: Icon(
        IconlyLight.arrow_down_2,
        size: 26.sp,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5),
        label: TextComponent(
          content: labelText,
          size: 18.sp,
        ),
        prefixIcon: icon,
        floatingLabelStyle: const TextStyle(
          color: AppColor.primaryOrange,
        ),
        hintStyle: const TextStyle(
          color: Colors.black26,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black26, // Default border color
          ),
          borderRadius: BorderRadius.circular(10.sp),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Colors.grey // Default border color
                  ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.primaryOrange),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey,
      ),
    );
  }
}