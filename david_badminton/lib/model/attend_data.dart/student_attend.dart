class StudentAttend {
  int id;
  String name;
  String coachName;
  int shift;
  bool isPresent;

  StudentAttend(
    this.id,
    this.name,
    this.coachName,
    this.shift,
    this.isPresent,
  );

  @override
  String toString() {
    return 'Student{name: $name, id: $id, coachName: $coachName, shift: $shift, isPresent: $isPresent}';
  }

   // Giúp sao chép đối tượng với giá trị isPresent được cập nhật
  StudentAttend copyWith({bool? isPresent}) {
    return StudentAttend(
      id,
      name,
      coachName,
      shift,
      isPresent ?? this.isPresent,
    );
  }
}