import 'package:david_badminton/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final IconData prefixIcon;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final bool isRequired;
  final String? Function(T?)? validator;

  const CustomDropdown(
      {Key? key,
      required this.label,
      required this.prefixIcon,
      required this.items,
      required this.value,
      required this.onChanged,
      this.isRequired = false,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      isDense: true,
      isExpanded: true,
      items: items,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 5.w),
        label: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: label,
                style: TextStyle(fontSize: 18.sp),
              ),
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
        prefixIcon: Icon(prefixIcon, size: 26.sp),
        floatingLabelStyle: const TextStyle(color: Colors.blue),
        hintStyle: const TextStyle(color: Colors.black26),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black26),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.white,
      ),
    );
  }
}
