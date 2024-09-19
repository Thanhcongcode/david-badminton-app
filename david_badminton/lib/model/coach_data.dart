import 'package:david_badminton/model/coach.dart';

class CoachData {
  int? totalCount;
  int? totalPages;
  int? currentPage;
  int? pageSize;
  List<Coach>? coaches;

  CoachData({
    required this.currentPage,
    required this.pageSize,
    required this.coaches,
    required this.totalCount,
    required this.totalPages,
  });
}