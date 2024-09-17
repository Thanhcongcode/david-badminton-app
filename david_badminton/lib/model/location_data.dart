import 'package:david_badminton/model/location.dart';

class LocationData {
  int? totalCount;
  int? totalPages;
  int? currentPage;
  int? pageSize;
  List<Location>? branches;
  String? message;
  int? statusCode;

  LocationData(
    this.currentPage,
    this.message,
    this.pageSize,
    this.statusCode,
    this.branches,
    this.totalCount,
    this.totalPages,
  );
}