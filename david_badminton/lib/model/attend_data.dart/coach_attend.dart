

class CoachAttend {
  int id;
  String name;
  List<dynamic> locations;
  List<dynamic> courses;

  CoachAttend(
    this.id,
    this.name,
    this.locations,
    this.courses,
  );

  @override
  String toString() {
    return 'Coach Attend{name: $name, id: $id, location: $locations, courses: $courses}';
  }
}