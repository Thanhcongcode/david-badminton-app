import 'package:david_badminton/model/location.dart';
import 'package:get/get.dart';
import 'package:david_badminton/api/api.dart';
import 'package:david_badminton/model/student.dart';

class LocationController extends GetxController {
  RxList<Location> locations = <Location>[].obs; // Danh sách chi nhánh\

  RxBool isSelecting = false.obs; // Trạng thái chế độ chọn
  RxBool isSelectAll = false.obs; // Trạng thái chọn tất cả

  RxMap<int, RxList<bool>> pageCheckboxStates =
      <int, RxList<bool>>{}.obs; // Trạng thái checkbox cho từng trang

  var selectedBranches = <Location>[].obs; // Danh sách sinh viên đã chọn

  RxBool isLoading = true.obs; // Trạng thái đang tải dữ liệu

  // Thêm thuộc tính sắp xếp
  RxBool isAscendingId = true.obs; // Trạng thái sắp xếp theo ID
  RxBool isAscendingName = true.obs; // Trạng thái sắp xếp theo Tên
  RxBool isAscendingAddress = true.obs; // Trạng thái sắp xếp theo Địa chỉ

  RxInt totalLocations = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadAllLocations();
  }

  void sortById() {
    bool ascending = !isAscendingId.value;
    isAscendingId.value = ascending;
    locations.sort(
        (a, b) => ascending ? a.id!.compareTo(b.id!) : b.id!.compareTo(a.id!));
    updatePageIndex(currentPage); // Cập nhật lại chỉ số trang hiện tại
  }

  void sortByName() {
    bool ascending = !isAscendingName.value;
    isAscendingName.value = ascending;
    locations.sort((a, b) =>
        ascending ? a.name!.compareTo(b.name!) : b.name!.compareTo(a.name!));
    updatePageIndex(currentPage);
  }

  void sortByAddress() {
    bool ascending = !isAscendingAddress.value;
    isAscendingAddress.value = ascending;
    locations.sort((a, b) => ascending
        ? a.address!.compareTo(b.address!)
        : b.address!.compareTo(a.address!));
    updatePageIndex(currentPage);
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

  void loadAllLocations() async {
    List<Location> allLocations = [];
    try {
      isLoading.value = true; // Bắt đầu loading

      // Gọi API với page = 1 để lấy totalCount
      var firstResponse = await Api.getAllLocations(
          1, 1); // Gọi API để lấy totalCount, chỉ cần 1 record

      // Lấy totalCount để làm pageSize
      int totalCount = firstResponse.totalCount ?? 0;
      totalLocations.value = totalCount;

      // Gọi lại API với pageSize là totalCount để lấy toàn bộ học viên
      var loactionData = await Api.getAllLocations(1, totalCount);

      allLocations.addAll(loactionData.locations!);

      allLocations.sort((a, b) => a.id.compareTo(b.id));
locations.value = allLocations; // Cập nhật danh sách học viên
      print('Total locations loaded: ${locations.length}');
    } catch (e) {
print('Error loading locations: $e');
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
    updateSelectedBranches();
  }

  void toggleSelectAll() {
    bool newValue = !isSelectAll.value;
    isSelectAll.value = newValue;
    if (pageCheckboxStates.containsKey(currentPage)) {
      pageCheckboxStates[currentPage] =
          List.generate(rowsPerPage, (index) => newValue).obs;
    }
    updateSelectedBranches();
  }

  void toggleSelectionMode() {
    isSelecting.value = !isSelecting.value;
    if (!isSelecting.value) {
      selectedBranches.clear();
    } else {
      updateSelectedBranches();
    }
  }

  void updateSelectedBranches() {
    selectedBranches.clear();
    for (int i = 0; i < locations.length; i++) {
      int pageIndex = i ~/ rowsPerPage;
      int rowIndex = i % rowsPerPage;
      if (pageCheckboxStates.containsKey(pageIndex) &&
          pageCheckboxStates[pageIndex]?[rowIndex] == true) {
        selectedBranches.add(locations[i]);
      }
    }
  }

  var _currentPage = 0.obs;
  var _rowsPerPage = 20.obs;

  RxInt selectedRowsPerPage = 10.obs;

  int get currentPage => _currentPage.value;
  set currentPage(int page) => _currentPage.value = page;

  int get rowsPerPage => _rowsPerPage.value;
  set rowsPerPage(int rows) => _rowsPerPage.value = rows;

  List<Location> get paginatedCoaches {
    final startIndex = currentPage * selectedRowsPerPage.value;
    final endIndex = (startIndex + selectedRowsPerPage.value < locations.length)
        ? startIndex + selectedRowsPerPage.value
        : locations.length;
    return locations.sublist(startIndex, endIndex);
  }

  int get totalPages => (locations.length / selectedRowsPerPage.value).ceil();
}