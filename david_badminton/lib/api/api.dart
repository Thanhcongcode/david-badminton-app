import 'dart:convert';
import 'package:david_badminton/app/modules/student_list/controllers/student_controller.dart';
import 'package:david_badminton/model/student_data.dart';
import 'package:http/http.dart' as http;
import 'package:david_badminton/app/modules/home/views/home_screen.dart';
import 'package:david_badminton/model/auth.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final storage = FlutterSecureStorage();

class Api {
  static Future<void> postLoginApi(Auth auth) async {
    final url = Uri.parse(
        'https://sso.ewarrantysystem.com/realms/david-badminton/protocol/openid-connect/token');
    try {
      // final Map<String, dynamic> userData = auth.toJson();
      // final String jsonBody = jsonEncode(userData);

      final Map<String, String> userData = {
        'client_id': auth.client_id,
        'client_secret': auth.client_secret,
        'grant_type': auth.grant_type,
        'username': auth.username,
        'password': auth.password,
      };

      final http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: userData,
      );

      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('login successful: ${response.body}');
        print(responseData["access_token"]);

        final token = responseData['access_token'];
        await storage.write(key: 'access_token', value: token); //luuw token

        Get.to(() => HomeScreen());
      } else {
        print('Loi loi loiiii');
        print(response.statusCode);
        print('Error: ${response.request}');
        print('Error details: ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  static getStudents() async {
    List<StudentData> studentData = [];
    List<Student> students = [];

    var url = Uri.parse(
        'https://api.davidbadminton.com/students?page=1&pageSize=2&seach=');

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        print('Token is null');
        return;
      }

      final http.Response response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        data['data'].forEach(
          (value) => {
            value["students"].forEach((item) => {
                  students.add(
                    Student(
                      id: item['id'],
                      name: item['name'],
                      details: item['details'],
                      type: item['type'],
                      birthDate: item['birthDate'],
                      phoneNumber: item['phoneNumber'],
                      coach: item['coach'],
                      status: item['status'],
                      fee: item['fee'],
                      result: item['result'],
                    ),
                  ),
                }),
            studentData.add(
              StudentData(
                value["currentPage"],
                value["message"],
                value["pageSize"],
                value["statusCode"],
                students,
                value["totalCount"],
                value["totalPages"],
              ),
            ),
            students = []
          },
        );
        return studentData;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
