

class LocationAttend {
  int id;
  String name;
  double latitude;
  double longitude;
  List<dynamic> coaches;
  List<dynamic> courses;

  LocationAttend(
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.coaches,
    this.courses,
  );

  @override
  String toString() {
    return 'Location{name: $name, id: $id, latitude: $latitude, longitude: $longitude, coaches: $coaches, courses: $courses}';
  }
}