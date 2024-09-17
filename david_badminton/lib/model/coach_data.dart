import 'package:david_badminton/model/coach.dart';

class CoachData {
  int? totalCount;
  int? totalPages;
  int? currentPage;
  int? pageSize;
  List<Coach>? coaches;
  String? message;
  int? statusCode;

  CoachData(
    this.currentPage,
    this.message,
    this.pageSize,
    this.statusCode,
    this.coaches,
    this.totalCount,
    this.totalPages,
  );
}