import 'package:david_badminton/app/modules/student_list/controllers/student_controller.dart';

class StudentData {
  int? totalCount;
  int? totalPages;
  int? currentPage;
  int? pageSize;
  List<Student>? students;
  String? message;
  int? statusCode;

  StudentData(
    this.currentPage,
    this.message,
    this.pageSize,
    this.statusCode,
    this.students,
    this.totalCount,
    this.totalPages,
  );
}