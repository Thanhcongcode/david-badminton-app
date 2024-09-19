import 'package:get/get.dart';
import 'package:david_badminton/api/api.dart';
import 'package:david_badminton/model/student.dart';

class StudentController extends GetxController {
  RxList<Student> students = <Student>[].obs; // Danh sách sinh viên

  RxBool isSelecting = false.obs; // Trạng thái chế độ chọn
  RxBool isSelectAll = false.obs; // Trạng thái chọn tất cả
  RxMap<int, RxList<bool>> pageCheckboxStates =
      <int, RxList<bool>>{}.obs; // Trạng thái checkbox cho từng trang
  var selectedStudents = <Student>[].obs; // Danh sách sinh viên đã chọn

  RxBool isLoading = true.obs; // Trạng thái đang tải dữ liệu

  RxBool isAscendingId = false.obs; // Trạng thái sắp xếp theo ID
  RxBool isAscendingName = true.obs; // Trạng thái sắp xếp theo Tên

  @override
  void onInit() {
    super.onInit();
    loadAllStudents();
  }

  void sortById() {
    bool ascending = !isAscendingId.value;
    isAscendingId.value = ascending;
    print(students.length);
    students.sort(
        (a, b) => ascending ? a.id.compareTo(b.id) : b.id.compareTo(a.id));
    updatePageIndex(currentPage); // Cập nhật lại chỉ số trang hiện tại
  }

  void sortByName() {
    bool ascending = !isAscendingName.value;
    isAscendingName.value = ascending;
    students.sort((a, b) =>
        ascending ? a.name.compareTo(b.name) : b.name.compareTo(a.name));
    updatePageIndex(currentPage);
  }

  Future<void> loadAllStudents() async {
    List<Student> allStudents = [];
    try {
      isLoading.value = true; // Bắt đầu loading

      // Gọi API với page = 1 để lấy totalCount
      var firstResponse = await Api.getAllStudents(
          1, 1); // Gọi API để lấy totalCount, chỉ cần 1 record

      // Lấy totalCount để làm pageSize
      int totalCount = firstResponse.totalCount ?? 0;

      // Gọi lại API với pageSize là totalCount để lấy toàn bộ học viên
      var studentData = await Api.getAllStudents(1, totalCount);

      allStudents.addAll(studentData.students);

      // Sắp xếp danh sách sinh viên theo ID giảm dần
      allStudents.sort((a, b) => b.id.compareTo(a.id));

      students.value = allStudents; // Cập nhật danh sách học viên
      print('Total students loaded: ${students.length}');
    } catch (e) {
      print('Error loading students: $e');
    } finally {
      isLoading.value = false; // Kết thúc loading dù có lỗi hay không
    }
  }

  void toggleCheckbox(int index) {
    int pageIndex = index ~/ rowsPerPage;
    int rowIndex = index % rowsPerPage;
    if (pageCheckboxStates.containsKey(pageIndex)) {
      pageCheckboxStates[pageIndex]?[rowIndex] =
          !(pageCheckboxStates[pageIndex]?[rowIndex] ?? false);
    }
    updateSelectedStudents();
  }

  void toggleSelectAll() {
    bool newValue = !isSelectAll.value;
    isSelectAll.value = newValue;
    if (pageCheckboxStates.containsKey(currentPage)) {
      pageCheckboxStates[currentPage] =
          List.generate(rowsPerPage, (index) => newValue).obs;
    }
    updateSelectedStudents();
  }

  void updatePageIndex(int pageIndex) {
    currentPage = pageIndex;
    if (!pageCheckboxStates.containsKey(pageIndex)) {
      pageCheckboxStates[pageIndex] =
          List.generate(rowsPerPage, (index) => false).obs;
    }
    isSelectAll.value =
        pageCheckboxStates[pageIndex]!.every((checked) => checked);
  }

  void toggleSelectionMode() {
    isSelecting.value = !isSelecting.value;
    if (!isSelecting.value) {
      selectedStudents.clear();
    } else {
      updateSelectedStudents();
    }
  }

  void updateSelectedStudents() {
    selectedStudents.clear();
    for (int i = 0; i < students.length; i++) {
      int pageIndex = i ~/ rowsPerPage;
      int rowIndex = i % rowsPerPage;
      if (pageCheckboxStates.containsKey(pageIndex) &&
          pageCheckboxStates[pageIndex]?[rowIndex] == true) {
        selectedStudents.add(students[i]);
      }
    }
  }

  final RxList<String> classSessions = <String>[
    "Ca 1: (8:00 - 10:00)",
    "Ca 2: (10:00 - 12:00)",
    "Ca 3: (14:00 - 16:00)",
    "Ca 4: (15:00 - 17:00)",
    "Ca 5: (16:00 - 18:00)",
    "Ca 6: (18:00 - 20:00)",
    "Ca 7: (20:00 - 22:00)",
  ].obs;

  var _currentPage = 0.obs;
  var _rowsPerPage = 10.obs;

  int get currentPage => _currentPage.value;
  set currentPage(int page) => _currentPage.value = page;

  int get rowsPerPage => _rowsPerPage.value;
  set rowsPerPage(int rows) => _rowsPerPage.value = rows;

  List<Student> get paginatedStudents {
    final startIndex = currentPage * rowsPerPage;
    final endIndex = (startIndex + rowsPerPage < students.length)
        ? startIndex + rowsPerPage
        : students.length;
    return students.sublist(startIndex, endIndex);
  }

  int get totalPages => (students.length / rowsPerPage).ceil();
}
