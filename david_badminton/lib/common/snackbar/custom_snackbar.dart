// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:david_badminton/common/components/text_component.dart';
// import 'package:david_badminton/utils/constants/app_color.dart';

// class CustomSnackBar extends StatelessWidget {
//   final String title;
//   final String message;
//   final Color backgroundColor;

//   const CustomSnackBar({
//     Key? key,
//     required this.title,
//     required this.message,
//     required this.backgroundColor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SnackBar(
      
//       content: Container(
//         width: double.infinity,
//         height: 70.h,
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: backgroundColor.withAlpha(20),
//           border: Border.all(color: backgroundColor.withAlpha(90), width: 2),
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 40.w,
//               height: 40.h,
//               decoration: BoxDecoration(
//                 color: backgroundColor,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Icon(
//                 backgroundColor == Colors.greenAccent ? Icons.check : Icons.error,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(width: 16.w),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 8.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     TextComponent(
//                       content: title,
//                       color: Colors.black,
//                       weight: FontWeight.bold,
//                       size: 14.sp,
//                     ),
//                     TextComponent(
//                       content: message,
//                       size: 12.sp,
//                       color: Colors.black.withOpacity(.5),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
//               child: Container(
//                 width: 40.w,
//                 height: 40.h,
//                 decoration: BoxDecoration(
//                   color: backgroundColor,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Icon(
//                   Icons.close,
//                   color: Colors.black.withOpacity(.8),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
