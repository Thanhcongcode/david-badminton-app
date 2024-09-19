import 'package:david_badminton/model/location.dart';

class LocationData {
  int? totalCount;
  int? totalPages;
  int? currentPage;
  int? pageSize;
  List<Location>? locations;

  LocationData({
    required this.currentPage,
    required this.pageSize,
    required this.locations,
    required this.totalCount,
    required this.totalPages,
  });
}
