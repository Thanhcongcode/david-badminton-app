import 'package:david_badminton/app/modules/welcome/views/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  
  await requestLocationPermission();

}


Future<void> requestLocationPermission() async {
  // Kiểm tra quyền truy cập vị trí
  var status = await Permission.location.status;

  if (!status.isGranted) {
    // Nếu quyền chưa được cấp, yêu cầu cấp quyền
    status = await Permission.location.request();
  }

  if (status.isGranted) {
    print("Location permission granted");
    // Quyền đã được cấp, bạn có thể tiếp tục với các chức năng liên quan đến vị trí
  } else {
    print("Location permission denied");
    // Quyền bị từ chối, bạn có thể hướng dẫn người dùng hoặc xử lý trường hợp không có quyền
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(411, 843), //360,800    411,843 man hinh
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return GetMaterialApp(
            //initialRoute: AppPages.INITIAL,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              useMaterial3: true,
            ),
            builder: (context, child) {
              final mediaQueryData = MediaQuery.of(context);
              // ignore: deprecated_member_use
              final scale = mediaQueryData.textScaleFactor.clamp(0.8, 1.0);
              // ignore: deprecated_member_use
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
                  child: child!);
            },
            home: WelcomeScreen(),
          );
        });
  }
}
