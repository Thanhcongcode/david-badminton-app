// // import 'package:david_badminton/api/api.dart';

// // import 'package:david_badminton/model/student.dart';
// // import 'package:flutter/material.dart';

// // class StudentListScreen extends StatefulWidget {
// //   @override
// //   _StudentListScreenState createState() => _StudentListScreenState();
// // }

// // class _StudentListScreenState extends State<StudentListScreen> {
// //   Future<List<Student>>? _studentsFuture;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _studentsFuture = Api.getStudents(); // Gọi hàm getStudents để lấy dữ liệu
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Danh sách học sinh'),
// //       ),
// //       body: FutureBuilder<List<Student>>(
// //         future: _studentsFuture,
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           } else if (snapshot.hasError) {
// //             return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
// //           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
// //             return Center(child: Text('Không có dữ liệu học sinh.'));
// //           } else {
// //             final students = snapshot.data!;
// //             return ListView.builder(
// //               itemCount: students.length,
// //               itemBuilder: (context, index) {
// //                 final student = students[index];
// //                 return ListTile(
// //                   leading: student.avatar != null
// //                       ? Image.network(student.avatar!)
// //                       : Icon(Icons.person),
// //                   title: Text(student.name ?? 'No Name'),
// //                   subtitle: Text(student.issuedBy ?? 'No DOB'),
// //                   trailing: Text(student.phoneNumber ?? 'No Phone'),
// //                 );
// //               },
// //             );
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }

// import 'package:david_badminton/api/api.dart';
// import 'package:david_badminton/app/modules/add_student/views/add_student.dart';
// import 'package:david_badminton/app/modules/student_list/view/widget/student_data_source.dart';
// import 'package:david_badminton/model/student.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:data_table_2/data_table_2.dart';
// import 'package:david_badminton/app/modules/student_list/controllers/student_controller.dart';
// import 'package:david_badminton/common/components/text_component.dart';
// import 'package:david_badminton/common/widgets/custom_shape/containers/search_container.dart';
// import 'package:david_badminton/utils/constants/app_color.dart';
// import 'package:iconly/iconly.dart';

// class StudentManagement extends StatefulWidget {
//   StudentManagement({super.key});

//   @override
//   State<StudentManagement> createState() => _StudentManagementState();
// }

// class _StudentManagementState extends State<StudentManagement> {
//   late Future<List<Student>> _studentsFuture;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _studentsFuture = Api.getStudents();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: TextComponent(
//           content: 'Danh sách học viên',
//           color: Colors.white,
//           isTitle: true,
//         ),
//         iconTheme: IconThemeData(color: Colors.white),
//         centerTitle: true,
//         backgroundColor: AppColor.secondaryBlue,
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
//         child: GetBuilder<StudentListController>(
//           init: StudentListController(),
//           builder: (controller) => Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 5,
//                     child: SearchContainer(
//                       searchBarWidth: double.infinity,
//                       text: 'Tìm kiếm...',
//                     ),
//                   ),
//                   SizedBox(width: 8.w),
//                   Expanded(
//                     flex: 1,
//                     child: Icon(Icons.filter),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 30.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       SizedBox(
//                         height: 40.h,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Get.to(AddStudent());
//                           },
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 IconlyBold.plus,
//                                 color: Colors.green,
//                                 size: 18.sp,
//                               ),
//                               SizedBox(width: 5.sp),
//                               TextComponent(
//                                 content: 'Thêm mới',
//                                 size: 14.sp,
//                                 color: Colors.green,
//                                 weight: FontWeight.bold,
//                               ),
//                             ],
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               side: BorderSide(width: 0.2),
//                             ),
//                             backgroundColor: Colors.white,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Obx(
//                         () {
//                           return SizedBox(
//                             height: 40.h,
//                             child: controller.isSelecting.value
//                                 ? ElevatedButton(
//                                     onPressed: () {},
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Icon(
//                                           IconlyBold.delete,
//                                           color: Colors.red,
//                                           size: 18.sp,
//                                         ),
//                                         SizedBox(width: 5.sp),
//                                         TextComponent(
//                                           content: 'Xóa',
//                                           size: 14.sp,
//                                           color: Colors.red,
//                                           weight: FontWeight.bold,
//                                         ),
//                                       ],
//                                     ),
//                                     style: ElevatedButton.styleFrom(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(5),
//                                         side: BorderSide(width: 0.2),
//                                       ),
//                                       backgroundColor: Colors.white,
//                                     ),
//                                   )
//                                 : null,
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                   Obx(
//                     () {
//                       return ElevatedButton(
//                         onPressed: () {
//                           controller.toggleSelectionMode();
//                         },
//                         child: controller.isSelecting.value
//                             ? TextComponent(
//                                 content: 'Hủy',
//                               )
//                             : TextComponent(
//                                 content: 'Chọn',
//                                 size: 16,
//                               ),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white.withOpacity(0.7),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: 8.sp),
//               Expanded(
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: SizedBox(
//                     width: 400.w, // Điều chỉnh kích thước theo nhu cầu của bạn
//                     child: FutureBuilder<List<Student>>(
//                       future: _studentsFuture,
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return Center(child: CircularProgressIndicator());
//                         } else if (snapshot.hasError) {
//                           return Center(
//                               child: Text('Error: ${snapshot.error}'));
//                         } else if (!snapshot.hasData ||
//                             snapshot.data!.isEmpty) {
//                           return Center(child: Text('No Data Available'));
//                         } else {
//                           final students = snapshot.data!;
//                           final dataSource = StudentDataSource(students);
//                           return Obx(() {
//                             final isSelecting = controller.isSelecting.value;
//                             return PaginatedDataTable2(
//                               header: Text('Students'),
//                               columns: [
//                                 if (controller.isSelecting.value)
//                                   DataColumn2(
//                                     label: Checkbox(
//                                       value: controller.isSelectAll.value,
//                                       onChanged: (value) {
//                                         controller.toggleSelectAll();
//                                       },
//                                     ),
//                                     size: ColumnSize.S,
//                                   ),
//                                 DataColumn2(
//                                   label: Text('ID'),
//                                   size: ColumnSize.S,
//                                 ),
//                                 DataColumn2(
//                                   label: Text('Tên'),
//                                   size: ColumnSize.L,
//                                 ),
//                               ],
//                               source: dataSource,
//                               rowsPerPage: 10,
//                             );
//                           });
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




// // class LoginForm extends StatelessWidget {
// //   const LoginForm({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final controller = Get.put(LoginController());
// //     return Form(
// //       key: controller.loginFormKey,
// //       child: Column(
// //         children: [
// //           SizedBox(
// //             width: double.infinity,
// //             height: 56.h,
// //             child: TextFormField(
// //               onTapOutside: (event) {
// //                 FocusManager.instance.primaryFocus?.unfocus();
// //               },
// //               controller: controller.userName,
// //               keyboardType: TextInputType.text,
// //               validator: (value) => Validation.validateUserName(value),
// //               decoration: InputDecoration(
// //                 prefixIcon: Icon(IconlyLight.user_1, size: 24.sp),
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(10),
// //                   borderSide: const BorderSide(color: Colors.black26),
// //                 ),
// //                 hintText: 'Tên đăng nhập',
// //                 label: Text('Tên đăng nhập'),
// //                 floatingLabelStyle: TextStyle(color: AppColor.primaryOrange),
// //                 hintStyle: const TextStyle(color: Colors.grey),
// //                 enabledBorder: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(10),
// //                   borderSide: BorderSide(color: Colors.grey),
// //                 ),
// //                 focusedBorder: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(10),
// //                   borderSide: BorderSide(color: AppColor.primaryOrange),
// //                 ),
// //                 fillColor: Colors.white,
// //               ),
// //             ),
// //           ),
// //           SizedBox(height: 24.h),
// //           Obx(
// //             () => SizedBox(
// //               width: double.infinity,
// //               height: 56.h,
// //               child: TextFormField(
// //                 onTapOutside: (event) {
// //                   FocusManager.instance.primaryFocus?.unfocus();
// //                 },
// //                 controller: controller.passwordController,
// //                 keyboardType: TextInputType.text,
// //                 obscureText: controller.hidePassword.value,
// //                 obscuringCharacter: '*',
// //                 decoration: InputDecoration(
// //                   prefixIcon: Icon(IconlyLight.lock),
// //                   suffixIcon: IconButton(
// //                     onPressed: () {
// //                       controller.hidePassword.value =
// //                           !controller.hidePassword.value;
// //                     },
// //                     icon: controller.hidePassword.value
// //                         ? Icon(Icons.visibility_off)
// //                         : Icon(Icons.visibility),
// //                   ),
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(10),
// //                     borderSide: const BorderSide(color: Colors.black26),
// //                   ),
// //                   hintText: 'Mật khẩu',
// //                   label: Text('Mật khẩu'),
// //                   floatingLabelStyle: TextStyle(color: AppColor.primaryOrange),
// //                   hintStyle: const TextStyle(color: Colors.grey),
// //                   enabledBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(10),
// //                     borderSide: BorderSide(color: Colors.grey),
// //                   ),
// //                   focusedBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(10),
// //                     borderSide: BorderSide(color: AppColor.primaryOrange),
// //                   ),
// //                   fillColor: Colors.white,
// //                 ),
// //               ),
// //             ),
// //           ),
// //           SizedBox(height: 12.h),
// //           Align(
// //             alignment: Alignment.bottomRight,
// //             child: GestureDetector(
// //               onTap: () {},
// //               child: Text(
// //                 'Quên mật khẩu?',
// //                 style: TextStyle(
// //                   fontSize: 14.sp,
// //                   fontWeight: FontWeight.w700,
// //                   color: AppColor.primaryBlue,
// //                 ),
// //               ),
// //             ),
// //           ),
// //           SizedBox(height: AppSize.spaceBtwSections.h),
// //           Obx(
// //             () => controller.isLoading.value
// //                 ? CircularProgressIndicator()  // Hiển thị loading
// //                 : SizedBox(
// //                     height: 52.h,
// //                     width: double.infinity,
// //                     child: ElevatedButton(
// //                       onPressed: () {
// //                         if (controller.loginFormKey.currentState!.validate()) {
// //                           controller.login();  // Thực hiện đăng nhập
// //                         }
// //                       },
// //                       child: Text('Đăng nhập'),
// //                       style: ElevatedButton.styleFrom(
// //                         elevation: 0,
// //                         foregroundColor: Colors.white,
// //                         backgroundColor: AppColor.primaryBlue,
// //                         disabledForegroundColor: Colors.grey,
// //                         disabledBackgroundColor: Colors.grey,
// //                         side: BorderSide(color: AppColor.primaryBlue),
// //                         textStyle: TextStyle(
// //                           fontSize: 18.sp,
// //                           fontWeight: FontWeight.w600,
// //                         ),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(8),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //           ),
// //           SizedBox(height: AppSize.spaceBtwSections.h),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Text(
// //                 'Bạn chưa có tài khoản?',
// //                 style: TextStyle(fontSize: 16.sp),
// //               ),
// //               GestureDetector(
// //                 child: Text(
// //                   ' Đăng ký',
// //                   style: TextStyle(
// //                     color: Color(0xff468585),
// //                     fontWeight: FontWeight.bold,
// //                     fontSize: 16.sp,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           SizedBox(height: 16.h),
// //           TextButton(
// //             onPressed: () {},
// //             child: Text(
// //               'Hướng dẫn sử dụng',
// //               style: TextStyle(color: AppColor.primaryOrange, fontSize: 16.sp),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }





// // class LoginForm extends StatelessWidget {
// //   const LoginForm({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final controller = Get.put(LoginController());
// //     return Form(
// //       key: controller.loginFormKey,
// //       child: Column(
// //         children: [
// //           SizedBox(
// //             width: double.infinity,
// //             height: 56.h,
// //             child: TextFormField(
// //               onTapOutside: (event) {
// //                 FocusManager.instance.primaryFocus?.unfocus();
// //               },
// //               controller: controller.userName,
// //               keyboardType: TextInputType.text,
// //               validator: (value) => Validation.validateUserName(value),
// //               decoration: InputDecoration(
// //                 prefixIcon: Icon(IconlyLight.user_1, size: 24.sp),
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(10),
// //                   borderSide: const BorderSide(color: Colors.black26),
// //                 ),
// //                 hintText: 'Tên đăng nhập',
// //                 label: Text('Tên đăng nhập'),
// //                 floatingLabelStyle: TextStyle(color: AppColor.primaryOrange),
// //                 hintStyle: const TextStyle(color: Colors.grey),
// //                 enabledBorder: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(10),
// //                   borderSide: BorderSide(color: Colors.grey),
// //                 ),
// //                 focusedBorder: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(10),
// //                   borderSide: BorderSide(color: AppColor.primaryOrange),
// //                 ),
// //                 fillColor: Colors.white,
// //               ),
// //             ),
// //           ),
// //           SizedBox(height: 24.h),
// //           Obx(
// //             () => SizedBox(
// //               width: double.infinity,
// //               height: 56.h,
// //               child: TextFormField(
// //                 onTapOutside: (event) {
// //                   FocusManager.instance.primaryFocus?.unfocus();
// //                 },
// //                 controller: controller.passwordController,
// //                 keyboardType: TextInputType.text,
// //                 obscureText: controller.hidePassword.value,
// //                 obscuringCharacter: '*',
// //                 decoration: InputDecoration(
// //                   prefixIcon: Icon(IconlyLight.lock),
// //                   suffixIcon: IconButton(
// //                     onPressed: () {
// //                       controller.hidePassword.value =
// //                           !controller.hidePassword.value;
// //                     },
// //                     icon: controller.hidePassword.value
// //                         ? Icon(Icons.visibility_off)
// //                         : Icon(Icons.visibility),
// //                   ),
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(10),
// //                     borderSide: const BorderSide(color: Colors.black26),
// //                   ),
// //                   hintText: 'Mật khẩu',
// //                   label: Text('Mật khẩu'),
// //                   floatingLabelStyle: TextStyle(color: AppColor.primaryOrange),
// //                   hintStyle: const TextStyle(color: Colors.grey),
// //                   enabledBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(10),
// //                     borderSide: BorderSide(color: Colors.grey),
// //                   ),
// //                   focusedBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(10),
// //                     borderSide: BorderSide(color: AppColor.primaryOrange),
// //                   ),
// //                   fillColor: Colors.white,
// //                 ),
// //               ),
// //             ),
// //           ),
// //           SizedBox(height: 12.h),
// //           Align(
// //             alignment: Alignment.bottomRight,
// //             child: GestureDetector(
// //               onTap: () {},
// //               child: Text(
// //                 'Quên mật khẩu?',
// //                 style: TextStyle(
// //                   fontSize: 14.sp,
// //                   fontWeight: FontWeight.w700,
// //                   color: AppColor.primaryBlue,
// //                 ),
// //               ),
// //             ),
// //           ),
// //           SizedBox(height: AppSize.spaceBtwSections.h),
// //           Obx(
// //             () => controller.isLoading.value
// //                 ? CircularProgressIndicator()  // Hiển thị loading
// //                 : SizedBox(
// //                     height: 52.h,
// //                     width: double.infinity,
// //                     child: ElevatedButton(
// //                       onPressed: () {
// //                         if (controller.loginFormKey.currentState!.validate()) {
// //                           controller.login();  // Thực hiện đăng nhập
// //                         }
// //                       },
// //                       child: Text('Đăng nhập'),
// //                       style: ElevatedButton.styleFrom(
// //                         elevation: 0,
// //                         foregroundColor: Colors.white,
// //                         backgroundColor: AppColor.primaryBlue,
// //                         disabledForegroundColor: Colors.grey,
// //                         disabledBackgroundColor: Colors.grey,
// //                         side: BorderSide(color: AppColor.primaryBlue),
// //                         textStyle: TextStyle(
// //                           fontSize: 18.sp,
// //                           fontWeight: FontWeight.w600,
// //                         ),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(8),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //           ),
// //           SizedBox(height: AppSize.spaceBtwSections.h),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Text(
// //                 'Bạn chưa có tài khoản?',
// //                 style: TextStyle(fontSize: 16.sp),
// //               ),
// //               GestureDetector(
// //                 child: Text(
// //                   ' Đăng ký',
// //                   style: TextStyle(
// //                     color: Color(0xff468585),
// //                     fontWeight: FontWeight.bold,
// //                     fontSize: 16.sp,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           SizedBox(height: 16.h),
// //           TextButton(
// //             onPressed: () {},
// //             child: Text(
// //               'Hướng dẫn sử dụng',
// //               style: TextStyle(color: AppColor.primaryOrange, fontSize: 16.sp),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
