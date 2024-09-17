import 'package:david_badminton/model/student.dart';

class StudentData {
  int? totalCount;
  int? totalPages;
  int? currentPage;
  int? pageSize;
  List<Student> students;

  StudentData({
    this.totalCount,
    this.totalPages,
    this.currentPage,
    this.pageSize,
    required this.students,
  });
}