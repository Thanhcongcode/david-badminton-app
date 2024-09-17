// import 'package:david_badminton/app/modules/student_detail/views/student_detail.dart';
// import 'package:david_badminton/model/student.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:david_badminton/app/modules/student_list/controllers/student_controller.dart';

// class StudentDataSource extends DataTableSource {
//   final List<Student> students;
//   final StudentLisController controller = Get.find<StudentListController>();

//   StudentDataSource(this.students);

//   @override
//   DataRow? getRow(int index) {
//     if (index >= students.length) return null;
//     final student = students[index];
//     int pageIndex = index ~/ controller.rowsPerPage;
//     int rowIndex = index % controller.rowsPerPage;

//     return DataRow(
//       cells: [
//         if (controller.isSelecting.value)
//           DataCell(
//             Obx(() => Checkbox(
//                   value: controller.pageCheckboxStates[pageIndex]?[rowIndex] ??
//                       false,
//                   onChanged: (value) {
//                     controller.toggleCheckbox(index);
//                   },
//                 )),
//           ),
//         DataCell(Text('${student.id}')),
//         DataCell(Text(student.name ?? 'N/A')),
//       ],
//       onSelectChanged: ((selected) {
//         if (selected ?? false) {
//           Get.to(() => StudentDetail(), arguments: student);
//         }
//       }),
//     );
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => students.length;

//   @override
//   int get selectedRowCount => controller.selectedStudents.length;

//   @override
//   void selectAll(bool checked) {
//     if (checked) {
//       controller.toggleSelectAll();
//     } else {
//       controller.pageCheckboxStates[controller.currentPageIndex] =
//           List.generate(controller.rowsPerPage, (index) => false).obs;
//       controller.updateSelectedStudents();
//     }
//   }
// }
