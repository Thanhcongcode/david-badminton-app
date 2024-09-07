import 'package:david_badminton/app/modules/add_student/controller/add_student_controller.dart';
import 'package:david_badminton/common/components/text_component.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconly/iconly.dart';

class InputField extends StatefulWidget {
  InputField({
    super.key,
    required this.controller,
    required this.fieldName,
    required this.icon,
    this.isCompulsory = false,
    this.inputType = TextInputType.text,
    this.suffixIcon = const SizedBox.shrink(),
    this.isDatePicker = false,
    this.isDropdown = false,
    this.options = const [],
  });

  TextEditingController controller;
  String fieldName;
  Widget icon;
  bool isCompulsory;
  TextInputType inputType;
  Widget suffixIcon;
  bool isDatePicker;
  bool isDropdown;
  List<String>? options;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final controller = Get.put(AddStudentController());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        controller.stdDOB.text = '${pickedDate.toLocal()}'
            .split(' ')[0]; // Format the date as YYYY-MM-DD
      });
    }
  }

  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    if (widget.isCompulsory != true) {
      return SizedBox(
        height: 55.h,
        child: TextFormField(
          controller: widget.controller,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Vui lòng nhập ${fieldName}';
          //   }
          //   return null;
          // },
          keyboardType: widget.inputType,
          decoration: InputDecoration(
            //contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
            // suffixIcon: widget.suffixIcon,
            prefixIcon: widget.icon,
            floatingLabelStyle: const TextStyle(
              color: AppColor.primaryBlue,
            ),
            label: TextComponent(
              content: widget.fieldName,
              size: 18.sp,
            ),
            hintText: widget.fieldName,
            hintStyle: const TextStyle(
              color: Colors.black26,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black26, // Default border color
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.grey // Default border color
                      ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.primaryBlue),
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Colors.white,
          ),
        ),
      );
    }
    if (widget.isDatePicker == true && widget.isCompulsory == true) {
      return SizedBox(
        height: 55.h,
        child: TextFormField(
          controller: controller.stdDOB,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onTap: () {
            _selectDate(context);
          },
          readOnly: true,
          decoration: InputDecoration(
            prefixIcon: IconButton(
              icon: widget.icon,
              iconSize: 26.sp,
              onPressed: () {
                _selectDate(context);
              },
            ),
            floatingLabelStyle: const TextStyle(
              color: AppColor.primaryBlue,
            ),
            label: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${widget.fieldName} ',
                    style: TextStyle(
                        fontSize: 16.sp), // Định dạng văn bản phần đầu
                  ),
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.red, // Đổi màu dấu sao thành màu đỏ
                    ),
                  ),
                ],
              ),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black26, // Default border color
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.grey // Default border color
                      ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.primaryBlue),
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Colors.white,
          ),
        ),
      );
    }
    if (widget.isDropdown == true && widget.isCompulsory == true) {
      return SizedBox(
        height: 55.h,
        child: DropdownButtonFormField(
          isExpanded: true,
          hint: TextComponent(
            content: widget.fieldName,
            size: 16.sp,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          value: _selectedValue,
          items: widget.options!.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: TextComponent(
                content: value,
                size: 16.sp,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            );
          }).toList(),
          onChanged: (_) {},
          icon: Icon(
            IconlyLight.arrow_down_2,
            size: 26.sp,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
            label: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${widget.fieldName} ',
                    style: TextStyle(
                        fontSize: 18.sp), // Định dạng văn bản phần đầu
                  ),
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.red, // Đổi màu dấu sao thành màu đỏ
                    ),
                  ),
                ],
              ),
            ),
            prefixIcon: widget.icon,
            floatingLabelStyle: const TextStyle(
              color: AppColor.primaryBlue,
            ),
            hintStyle: const TextStyle(color: Colors.black26),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black26, // Default border color
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.grey // Default border color
                      ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.primaryBlue),
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Colors.white,
          ),
        ),
      );
    }
    if (widget.isCompulsory == true) {
      return SizedBox(
        height: 55.h,
        child: TextFormField(
          controller: widget.controller,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Vui lòng nhập ${fieldName}';
          //   }
          //   return null;
          // },
          keyboardType: widget.inputType,
          decoration: InputDecoration(
            prefixIcon: widget.icon,
            floatingLabelStyle: const TextStyle(
              color: AppColor.primaryBlue,
            ),
            label: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${widget.fieldName} ',
                    style: TextStyle(
                        fontSize: 18.sp), // Định dạng văn bản phần đầu
                  ),
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.red, // Đổi màu dấu sao thành màu đỏ
                    ),
                  ),
                ],
              ),
            ),
            hintText: '${widget.fieldName} (bắt buộc)',
            hintStyle: TextStyle(color: Colors.black26, fontSize: 16.sp),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black26, // Default border color
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.grey // Default border color
                      ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.primaryBlue),
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Colors.white,
          ),
        ),
      );
    } else {
      return Text('ko có j hết');
    }
  }
}
