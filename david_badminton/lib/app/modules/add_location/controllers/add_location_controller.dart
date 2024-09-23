import 'dart:math';

import 'package:david_badminton/api/api.dart';
import 'package:david_badminton/model/coach.dart';
import 'package:david_badminton/model/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

final storage = FlutterSecureStorage();

class AddLocationController extends GetxController {
  var coachNumberIdController = TextEditingController();

  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var dobController = TextEditingController();
  var description = TextEditingController();

  GlobalKey<FormState> addLocationFormKey = GlobalKey<FormState>();

  String generateRandomNumberId() {
    final random = Random();
    return random
        .nextInt(1000000)
        .toString()
        .padLeft(6, '0'); // Sinh số ngẫu nhiên từ 000000 đến 999999
  }

// Dropdown values and controllers
  RxBool selectedGender = true.obs;
  RxInt selectedShift = 0.obs;
  RxInt selectedStatus = 0.obs;
  var selectedCourseId = Rxn<int>();
  var selectedCoachId = Rxn<int>();
  var selectedLocationId = Rxn<int>();

  // Gender options
  final Map<String, bool> genderOptions = {
    'Nam': true,
    'Nữ': false,
  };

  // Shift options
  final Map<String, int> shiftOptions = {
    "Ca 1: (8:00 - 10:00)": 0,
    "Ca 2: (10:00 - 12:00)": 1,
    "Ca 3: (14:00 - 16:00)": 2,
    "Ca 4: (15:00 - 17:00)": 3,
    "Ca 5: (16:00 - 18:00)": 4,
    "Ca 6: (18:00 - 20:00)": 5,
    "Ca 7: (20:00 - 22:00)": 6,
  };

  // Status options
  final Map<String, int> statusOptions = {
    'Còn học': 0,
    'Nghỉ học': 1,
    'Tạm nghỉ': 2,
  };

  // DropdownButton widgets
  DropdownButton<bool> genderDropdown() {
    return DropdownButton<bool>(
      value: selectedGender.value,
      onChanged: (bool? newValue) {
        if (newValue != null) {
          selectedGender.value = newValue;
        }
      },
      items: genderOptions.entries.map<DropdownMenuItem<bool>>((entry) {
        return DropdownMenuItem<bool>(
          value: entry.value,
          child: Text(entry.key),
        );
      }).toList(),
    );
  }

  DropdownButton<int> shiftDropdown() {
    return DropdownButton<int>(
      value: selectedShift.value,
      onChanged: (int? newValue) {
        if (newValue != null) {
          selectedShift.value = newValue;
        }
      },
      items: shiftOptions.entries.map<DropdownMenuItem<int>>((entry) {
        return DropdownMenuItem<int>(
          value: entry.value,
          child: Text(entry.key),
        );
      }).toList(),
    );
  }

  String convertToIsoDate(String date) {
    print('Start date before conversion: $date');

    // Định dạng đầu vào của ngày
    DateFormat inputFormat = DateFormat("yyyy-MM-dd");

    // Định dạng đầu ra của ngày giờ ISO 8601
    DateFormat outputFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ");

    try {
      // Chuyển từ chuỗi ngày sang DateTime
      DateTime parsedDate = inputFormat.parse(date);
      // Chuyển từ DateTime sang chuỗi ISO 8601
      String isoDate =
          outputFormat.format(parsedDate.toUtc()); // Đổi sang UTC nếu cần thiết
      return isoDate;
    } catch (e) {
      print('Error parsing date: $e');
      return ''; // Trả về chuỗi rỗng nếu có lỗi
    }
  }

  DropdownButton<int> statusDropdown() {
    return DropdownButton<int>(
      value: selectedStatus.value,
      onChanged: (int? newValue) {
        if (newValue != null) {
          selectedStatus.value = newValue;
        }
      },
      items: statusOptions.entries.map<DropdownMenuItem<int>>((entry) {
        return DropdownMenuItem<int>(
          value: entry.value,
          child: Text(entry.key),
        );
      }).toList(),
    );
  }
}
