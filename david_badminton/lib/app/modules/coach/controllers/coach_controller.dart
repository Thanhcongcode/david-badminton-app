import 'package:david_badminton/model/coach.dart';
import 'package:get/get.dart';
import 'package:david_badminton/api/api.dart';
import 'package:david_badminton/model/student.dart';

class CoachController extends GetxController {
  RxList<Coach> coaches = <Coach>[].obs; // Danh sách sinh viên

  RxBool isSelecting = false.obs; // Trạng thái chế độ chọn
  RxBool isSelectAll = false.obs; // Trạng thái chọn tất cả
  RxMap<int, RxList<bool>> pageCheckboxStates =
      <int, RxList<bool>>{}.obs; // Trạng thái checkbox cho từng trang
  var selectedCoaches = <Coach>[].obs; // Danh sách sinh viên đã chọn

  RxBool isLoading = true.obs; // Trạng thái đang tải dữ liệu

  RxBool isAscendingId = true.obs; // Trạng thái sắp xếp theo ID
  RxBool isAscendingName = true.obs; // Trạng thái sắp xếp theo Tên
  RxBool isAscendingAddress = true.obs; // Trạng thái sắp xếp theo Địa chỉ

  @override
  void onInit() {
    super.onInit();
    loadAllCoaches();
  }

  void sortById() {
    bool ascending = !isAscendingId.value;
    isAscendingId.value = ascending;
    coaches.sort(
        (a, b) => ascending ? a.id.compareTo(b.id) : b.id.compareTo(a.id));
    updatePageIndex(currentPage); // Cập nhật lại chỉ số trang hiện tại
  }

  void sortByName() {
    bool ascending = !isAscendingName.value;
    isAscendingName.value = ascending;
    coaches.sort((a, b) =>
        ascending ? a.name.compareTo(b.name) : b.name.compareTo(a.name));
    updatePageIndex(currentPage);
  }

  void sortByAddress() {
    bool ascending = !isAscendingAddress.value;
    isAscendingAddress.value = ascending;
    coaches.sort((a, b) => ascending
        ? a.address!.compareTo(b.address!)
        : b.address!.compareTo(a.address!));
    updatePageIndex(currentPage);
  }

//    void loadCoaches() async {
//   try {
//     List<Coach> coachList = await Api.getAllCoaches(1,1);
//     isLoading.value = false;
//     coaches.value = coachList;
//     updatePageIndex(0); // Khởi tạo trạng thái checkbox cho trang đầu tiên
//   } catch (e) {
//     print('Error loading students: $e');
//     isLoading.value = false;
//   }
// }

  void loadAllCoaches() async {
    List<Coach> allCoaches = [];
    try {
      isLoading.value = true; // Bắt đầu loading

      // Gọi API với page = 1 để lấy totalCount
      var firstResponse = await Api.getAllCoaches(
          1, 1); // Gọi API để lấy totalCount, chỉ cần 1 record

      // Lấy totalCount để làm pageSize
      int totalCount = firstResponse.totalCount ?? 0;

      // Gọi lại API với pageSize là totalCount để lấy toàn bộ học viên
      var coachData = await Api.getAllCoaches(1, totalCount);

      allCoaches.addAll(coachData.coaches!);

      coaches.value = allCoaches; // Cập nhật danh sách học viên
      print('Total coaches loaded: ${coaches.length}');
    } catch (e) {
      print('Error loading coaches: $e');
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
      selectedCoaches.clear();
    } else {
      updateSelectedStudents();
    }
  }

  void updateSelectedStudents() {
    selectedCoaches.clear();
    for (int i = 0; i < coaches.length; i++) {
      int pageIndex = i ~/ rowsPerPage;
      int rowIndex = i % rowsPerPage;
      if (pageCheckboxStates.containsKey(pageIndex) &&
          pageCheckboxStates[pageIndex]?[rowIndex] == true) {
        selectedCoaches.add(coaches[i]);
      }
    }
  }

  var _currentPage = 0.obs;
  var _rowsPerPage = 20.obs;

  int get currentPage => _currentPage.value;
  set currentPage(int page) => _currentPage.value = page;

  int get rowsPerPage => _rowsPerPage.value;
  set rowsPerPage(int rows) => _rowsPerPage.value = rows;

  List<Coach> get paginatedCoaches {
    final startIndex = currentPage * rowsPerPage;
    final endIndex = (startIndex + rowsPerPage < coaches.length)
        ? startIndex + rowsPerPage
        : coaches.length;
    return coaches.sublist(startIndex, endIndex);
  }

  int get totalPages => (coaches.length / rowsPerPage).ceil();
}