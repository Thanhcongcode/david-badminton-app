import 'dart:math';
import 'package:uuid/uuid.dart';

// Hàm sinh số ID ngẫu nhiên
String generateRandomId() {
  final uuid = Uuid();
  return uuid.v4(); // Sinh UUID ngẫu nhiên
}

// Nếu bạn muốn tạo số ngẫu nhiên đơn giản hơn, sử dụng hàm này
String generateRandomNumberId() {
  final random = Random();
  return random.nextInt(1000000).toString().padLeft(6, '0'); // Sinh số ngẫu nhiên từ 000000 đến 999999
}
