class Student {
  double? defaultTuitionFee = 1000000.00;
  int? shift;
  int? status;
  String? courseName;
  String? healthStatus;
  double? height;
  double? weight;
  int? id;
  String? avatar;
  String? name;
  DateTime? dob;
  String? phoneNumber;
  bool? gender;
  String? address;
  String? numberId;
  DateTime? dateRange;
  String? issuedBy;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  Student(
    this.address,
    this.avatar,
    this.courseName,
    this.createdAt,
    this.dateRange,
    this.defaultTuitionFee,
    this.description,
    this.dob,
    this.gender,
    this.healthStatus,
    this.height,
    this.id,
    this.issuedBy,
    this.name,
    this.numberId,
    this.phoneNumber,
    this.shift,
    this.status,
    this.updatedAt,
    this.weight,
  );
}