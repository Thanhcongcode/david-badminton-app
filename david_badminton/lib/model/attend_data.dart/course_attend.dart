

class CourseAttend {
  int id;
  String name;
  List<dynamic> locations;
  List<dynamic> coaches;

  CourseAttend(
    this.id,
    this.name,
    this.coaches,
    this.locations,
  );
  @override
  String toString() {
    return 'Location{name: $name, id: $id, locations: $locations, coaches: $coaches}';
  }
}