import 'package:david_badminton/app/modules/add_student/controllers/add_student_controller.dart';
import 'package:david_badminton/common/components/text_component.dart';
import 'package:david_badminton/utils/constants/app_color.dart';
import 'package:david_badminton/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class InputField extends StatefulWidget {
  InputField(
      {super.key,
      required this.controller,
      required this.fieldName,
      required this.icon,
      this.isCompulsory = false,
      this.inputType = TextInputType.text,
      this.isDatePicker = false,
      this.isDropdown = false,
      this.options = const [],
      this.readOnly = false,
      this.isDetail = false,
      this.softWrap = false,
      this.maxLines = 1});

  TextEditingController controller;
  String fieldName;
  int maxLines;
  Widget icon;
  bool isCompulsory;
  TextInputType inputType;

  bool isDatePicker;
  bool isDropdown;
  List<String>? options;
  bool readOnly;
  bool isDetail;

  bool softWrap;

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
        widget.controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    if (widget.isDatePicker == true) {
      return SizedBox(
        child: TextFormField(
          validator: widget.isCompulsory
              ? (value) => Validation.validateEmtyText(widget.fieldName, value)
              : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onTap: () {
            widget.readOnly == true ? null : _selectDate(context);
          },
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 18.h, horizontal: 5.w),
            isDense: true,
            prefixIcon: IconButton(
              icon: widget.icon,
              iconSize: 26.sp,
              onPressed: () {
                widget.readOnly == true ? null : _selectDate(context);
              },
            ),
            floatingLabelStyle: const TextStyle(
              color: AppColor.primaryBlue,
            ),
            label: widget.isCompulsory == true
                ? Text.rich(
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
                              color: Colors.red), // Định dạng văn bản phần đầu
                        ),
                      ],
                    ),
                  )
                : TextComponent(content: widget.fieldName),
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
        child: TextFormField(
          controller: widget.controller,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onTap: () {
            _selectDate(context);
          },
          validator: widget.isCompulsory
              ? (value) => Validation.validateEmtyText(widget.fieldName, value)
              : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 18.h, horizontal: 5.w),
            isDense: true,
            prefixIcon: IconButton(
              icon: widget.icon,
              iconSize: 26.sp,
              onPressed: () {
                widget.readOnly == true ? null : _selectDate(context);
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
    if (widget.isDropdown == true) {
      return DropdownButtonFormField(
        isExpanded: true,
        isDense: true,
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
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 5.w),
          label: widget.isCompulsory == true
              ? Text.rich(
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
                )
              : TextComponent(content: '${widget.fieldName}'),
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
      );
    } else {
//chính thức
      return SizedBox(
        child: TextFormField(
          controller: widget.controller,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          validator: widget.isCompulsory
              ? (value) => Validation.validateEmtyText(widget.fieldName, value)
              : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLines: widget.maxLines != 1 ? null : 1,
          keyboardType: widget.inputType,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 18.h, horizontal: 5.w),
            isDense: true,
            enabled: widget.isDetail ? false : true,

            //contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
            // suffixIcon: widget.suffixIcon,
            prefixIcon: widget.icon,
            floatingLabelStyle: const TextStyle(
              color: AppColor.primaryBlue,
            ),
            label: widget.isCompulsory == true
                ? Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${widget.fieldName} ',
                          style: TextStyle(
                            fontSize: 18.sp,
                          ), // Định dạng văn bản phần đầu
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
                  )
                : Text(
                    widget.fieldName,
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                    softWrap: widget.softWrap,
                  ),
            hintText: widget.isDetail ? widget.fieldName : null,
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
  }
}
