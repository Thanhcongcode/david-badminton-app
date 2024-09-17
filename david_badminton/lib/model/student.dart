///import 'dart:ffi';

class Student {
  double defaultTuitionFee;
  int shift;
  int status;
  String courseName;
  String locationName;
  String coachName;
  String healthStatus;
  double height;
  double weight;
  int id;
  String avatar;
  String name;
  String dob;
  String phoneNumber;
  bool gender;
  String address;
  String numberId; // Đổi từ double sang String
  String dateRange;
  String issuedBy;
  String description;
  String createdAt;
  String updatedAt;

  Student(
    this.defaultTuitionFee,
    this.shift,
    this.status,
    this.courseName,
    this.locationName,
    this.coachName,
    this.healthStatus,
    this.height,
    this.weight,
    this.id,
    this.avatar,
    this.name,
    this.dob,
    this.phoneNumber,
    this.gender,
    this.address,
    this.numberId,
    this.dateRange,
    this.issuedBy,
    this.description,
    this.createdAt,
    this.updatedAt,
  );
}
