import 'package:get/get.dart';

class StudentController extends GetxController {
  // Danh sách tất cả sinh viên
  RxList<Student> students = <Student>[].obs;

  // Danh sách sinh viên sau khi tìm kiếm
  RxList<Student> filteredStudents = <Student>[].obs;

  // Danh sách sinh viên được hiển thị hiện tại
  RxList<Student> displayedStudents = <Student>[].obs;

  // Chuỗi tìm kiếm
  RxString searchQuery = ''.obs;

  // Trạng thái khi có thể chọn nhiều mục
  var isSelecting = false.obs;
  var selectedStudents = <Student>[].obs;

  void toggleSelectionMode() {
    isSelecting.value = !isSelecting.value;
    print('selection mode');
    if (!isSelecting.value) {
      selectedStudents.clear(); // Xóa lựa chọn khi thoát chế độ chọn
    }
  }

  void toggleStudentSelection(Student student) {
    if (selectedStudents.contains(student)) {
      selectedStudents.remove(student);
    } else {
      selectedStudents.add(student);
    }
  }

  void clearSelection() {
    selectedStudents.clear();
    isSelecting.value = false;
  }

  // Thông tin phân trang
  int _pageSize = 50;
  int currentPage = 0;

  @override
  void onInit() {
    super.onInit();
    _loadStudents();
  }

  void _loadStudents() {
    // Tải dữ liệu sinh viên từ nguồn dữ liệu (có thể là API, cơ sở dữ liệu, v.v.)
    // Dữ liệu mẫu:
    students.value = List.generate(
      1000,
      (index) => Student(
        id: index + 1,
        name: 'Nguyễn Gia Thị ${index + 1}',
        details: 'Ca sáng 2 -4 -6',
        type: 'Sinh viên',
        birthDate: '01/01/2002',
        phoneNumber: '0963267182',
        coach: 'Nguyễn Anh',
        status: 'Đang học',
        fee: '5,000,000 VND',
        result: 'Chưa đặt',
      ),
    );
    filteredStudents.value = students;
    _updateDisplayedStudents();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    _filterStudents();
    _updateDisplayedStudents();
  }

  void _filterStudents() {
    if (searchQuery.value.isEmpty) {
      filteredStudents.value = students;
    } else {
      filteredStudents.value = students.where((student) {
        return student.name.contains(searchQuery.value);
      }).toList();
    }
    _updateDisplayedStudents();
  }

  void _updateDisplayedStudents() {
    int startIndex = currentPage * _pageSize;
    int endIndex = startIndex + _pageSize;
    if (endIndex > filteredStudents.length) {
      endIndex = filteredStudents.length;
    }
    displayedStudents.value = filteredStudents.sublist(startIndex, endIndex);
    update(); // Cập nhật trạng thái để giao diện biết sự thay đổi
  }

  void nextPage() {
    if ((currentPage + 1) * _pageSize < filteredStudents.length) {
      currentPage++;
      _updateDisplayedStudents();
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      currentPage--;
      _updateDisplayedStudents();
    }
  }
int get totalPages => (filteredStudents.length / _pageSize).ceil();

  String get displayRange {
    int startIndex = currentPage * _pageSize + 1;
    int endIndex = (currentPage + 1) * _pageSize;
    if (endIndex > filteredStudents.length) {
      endIndex = filteredStudents.length;
    }
    return 'Hiển thị từ $startIndex đến $endIndex trong tổng số ${filteredStudents.length}';
  }
}

class Student {
  final int id;
  final String name;
  final String details;
  final String type;
  final String birthDate;
  final String phoneNumber;
  final String coach;
  final String status;
  final String fee;
  final String result;

  Student({
    required this.id,
    required this.name,
    required this.details,
    required this.type,
    required this.birthDate,
    required this.phoneNumber,
    required this.coach,
    required this.status,
    required this.fee,
    required this.result,
  });
}