import 'dart:convert';

import 'package:david_badminton/model/attend_data.dart/coach_attend.dart';
import 'package:david_badminton/model/attend_data.dart/course_attend.dart';
import 'package:david_badminton/model/attend_data.dart/location_attend.dart';
import 'package:david_badminton/model/attend_data.dart/student_attend.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:david_badminton/model/auth.dart';
import 'package:david_badminton/model/coach.dart';
import 'package:david_badminton/model/coach_data.dart';
import 'package:david_badminton/model/location.dart';
import 'package:david_badminton/model/location_data.dart';
import 'package:david_badminton/model/student.dart';
import 'package:david_badminton/model/student_data.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

final storage = FlutterSecureStorage();

class Api {
  static const _loginUrl =
      'https://sso.ewarrantysystem.com/realms/david-badminton/protocol/openid-connect/token';
  static const _refreshTokenUrl =
      'https://sso.ewarrantysystem.com/realms/david-badminton/protocol/openid-connect/token';

  static Future<void> postLoginApi(Auth auth) async {
    final url = Uri.parse(_loginUrl);
    try {
      final Map<String, String> userData = {
        'client_id': auth.client_id,
        'client_secret': auth.client_secret,
        'grant_type': auth.grant_type,
        'username': auth.username,
        'password': auth.password,
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
        body: userData,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final String accessToken = responseData['access_token'];
        final String refreshToken = responseData['refresh_token'];

        Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
        String sub = decodedToken['sub'];

        await storage.write(key: 'sub', value: sub);

        await storage.write(key: 'access_token', value: accessToken);
        await storage.write(key: 'refresh_token', value: refreshToken);

        return;
      } else {
        throw Exception('Sai tên đăng nhập hoặc mật khẩu');
      }
    } catch (e) {
      throw Exception('Lỗi đăng nhập: $e');
    }
  }

  static Future<void> logout() async {
    try {
      await storage.delete(key: 'access_token');
      await storage.delete(key: 'refresh_token');
      print('Đăng xuất thành công');
    } catch (e) {
      throw Exception('Lỗi đăng xuất: $e');
    }
  }

  static Future<void> refreshToken() async {
    final url = Uri.parse(_refreshTokenUrl);

    try {
      final String? refreshToken = await storage.read(key: 'refresh_token');
      if (refreshToken == null) {
        throw Exception('Refresh token is null');
      }

      final Map<String, String> body = {
        'client_id':
            'david-badminton', // Thay thế bằng client ID thực tế của bạn
        'client_secret':
            'cKsOV4TijqHbSqnPrv5aIvb5mIBBd8bv', // Thay thế bằng client secret thực tế của bạn
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
        body: body,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final String newAccessToken = responseData['access_token'];
        final String newRefreshToken = responseData['refresh_token'];

        await storage.write(key: 'access_token', value: newAccessToken);
        await storage.write(key: 'refresh_token', value: newRefreshToken);

        print('Tokens refreshed successfully');
      } else {
        throw Exception(
            'Failed to refresh token: ${responseData['error_description']}');
      }
    } catch (e) {
      throw Exception('Error refreshing token: $e');
    }
  }

  // static Future<List<Student>> getStudents() async {
  //   List<StudentData> studentData = [];
  //   List<Student> students = [];

  //   var url = Uri.parse(
  //       'https://api.davidbadminton.com/students?page=1&pageSize=4&seach=');

  //   try {
  //     String? token = await storage.read(key: 'access_token');

  //     if (token == null) {
  //       print('Token is null. Trying to refresh token.');
  //       await refreshToken();
  //       token = await storage.read(key: 'access_token');
  //     }

  //     final http.Response response =
  //         await http.get(url, headers: {'Authorization': 'Bearer ${token}'});

  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);

  //       var dataContent = data['data'];

  //       // int? totalCount = dataContent['totalCount'];
  //       // int? totalPages = dataContent['totalPages'];
  //       // int? pageSize = dataContent['pageSize'];
  //       // int? currentPage = dataContent['currentPage'];
  //       // String? message = dataContent['message'];
  //       // int? statusCode = dataContent['statusCode'];
  //       // studentData.add(StudentData(currentPage, message, pageSize, statusCode,
  //       //     students, totalCount, totalPages));

  //       dataContent['students'].forEach((item) => {
  //             students.add(Student(
  //               (item['defaultTuitionFee'] is int)
  //                   ? (item['defaultTuitionFee'] as int).toDouble()
  //                   : (item['defaultTuitionFee'] as double?) ??
  //                       0.0, // Giá trị mặc định là 0.0
  //               item['shift'] ?? 0, // Giá trị mặc định cho shift
  //               item['status'] ?? 0, // Giá trị mặc định cho status
  //               item['courseName'] ?? '', // Giá trị mặc định là chuỗi rỗng
  //               item['locationName'] ?? '', // Giá trị mặc định là chuỗi rỗng
  //               item['coachName'] ?? '', // Giá trị mặc định là chuỗi rỗng
  //               item['healthStatus'] ?? '', // Giá trị mặc định là chuỗi rỗng
  //               (item['height'] is int)
  //                   ? (item['height'] as int).toDouble()
  //                   : (item['height'] as double?) ??
  //                       0.0, // Giá trị mặc định là 0.0
  //               (item['weight'] is int)
  //                   ? (item['weight'] as int).toDouble()
  //                   : (item['weight'] as double?) ??
  //                       0.0, // Giá trị mặc định là 0.0
  //               item['id'] ?? 0, // Giá trị mặc định là 0
  //               item['avatar'] ?? '', // Giá trị mặc định là chuỗi rỗng
  //               item['name'] ?? '', // Giá trị mặc định là chuỗi rỗng
  //               item['dob'] ?? '', // Giá trị mặc định là chuỗi rỗng
  //               item['phoneNumber'] ?? '', // Giá trị mặc định là chuỗi rỗng
  //               item['gender'] ?? false, // Giá trị mặc định là false
  //               item['address'] ?? '', // Giá trị mặc định là chuỗi rỗng
  //               item['numberId'] ?? '', // Giá trị mặc định là chuỗi rỗng
  //               item['dateRange'] ?? '', // Giá trị mặc định là chuỗi rỗng
  //               item['issuedBy'] ?? '', // Giá trị mặc định là chuỗi rỗng
  //               item['description'] ?? '', // Giá trị mặc định là chuỗi rỗng
  //               item['createdAt'] ?? '', // Giá trị mặc định là chuỗi rỗng
  //               item['updatedAt'] ?? '', // Giá trị mặc định là chuỗi rỗng
  //             ))
  //           });
  //       return students;
  //     } else {
  //       if (response.statusCode == 401) {
  //         await refreshToken();
  //         return await getStudents();
  //       } else {
  //         throw Exception('Failed to load students: ${response.reasonPhrase}');
  //       }
  //     }
  //   } catch (e) {
  //     throw Exception("error ${e}");
  //   }
  // }

  static Future<StudentData> getAllStudents(int page,
      [int pageSize = 10]) async {
    List<Student> students = [];
    var url = Uri.parse(
        'https://api.davidbadminton.com/students?page=$page&pageSize=$pageSize&search=');

    try {
      final token = await storage.read(key: 'access_token');

      if (token == null) {
        print('Token is null');
      }

      final http.Response response =
          await http.get(url, headers: {'Authorization': 'Bearer ${token}'});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var dataContent = data['data'];

        int? totalCount = dataContent['totalCount'];
        int? totalPages = dataContent['totalPages'];
        int? pageSize = dataContent['pageSize'];
        int? currentPage = dataContent['currentPage'];

        students = (dataContent['students'] as List)
            .map((item) => Student(
                  // Initialize Student object
                  (item['defaultTuitionFee'] is int)
                      ? (item['defaultTuitionFee'] as int).toDouble()
                      : (item['defaultTuitionFee'] as double?) ?? 0.0,
                  item['shift'] ?? 0,
                  item['status'] ?? 0,
                  item['courseName'] ?? '',
                  item['locationName'] ?? '',
                  item['coachName'] ?? '',
                  item['healthStatus'] ?? '',
                  (item['height'] is int)
                      ? (item['height'] as int).toDouble()
                      : (item['height'] as double?) ?? 0.0,
                  (item['weight'] is int)
                      ? (item['weight'] as int).toDouble()
                      : (item['weight'] as double?) ?? 0.0,
                  item['id'] ?? 0,
                  item['avatar'] ?? '',
                  item['name'] ?? '',
                  item['dob'] ?? '',
                  item['phoneNumber'] ?? '',
                  item['gender'] ?? false,
                  item['address'] ?? '',
                  item['numberId'] ?? '',
                  item['dateRange'] ?? '',
                  item['issuedBy'] ?? '',
                  item['description'] ?? '',
                  item['createdAt'] ?? '',
                  item['updatedAt'] ?? '',
                ))
            .toList();

        // Return initial data with totalCount, then you can call again with totalCount as pageSize
        return StudentData(
            currentPage: currentPage,
            pageSize: pageSize,
            students: students,
            totalCount: totalCount,
            totalPages: totalPages);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  static Future<List<Coach>> getCoaches() async {
    List<CoachData> coachData = [];
    List<Coach> coaches = [];

    var url = Uri.parse(
        'https://api.davidbadminton.com/coaches?page=1&pageSize=4&seach=');

    try {
      String? token = await storage.read(key: 'access_token');

      if (token == null) {
        print('Token is null. Trying to refresh token.');
        await refreshToken();
        token = await storage.read(key: 'access_token');
      }

      final http.Response response =
          await http.get(url, headers: {'Authorization': 'Bearer ${token}'});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var dataContent = data['data'];

        int? totalCount = dataContent['totalCount'];
        int? totalPages = dataContent['totalPages'];
        int? pageSize = dataContent['pageSize'];
        int? currentPage = dataContent['currentPage'];
        String? message = dataContent['message'];
        int? statusCode = dataContent['statusCode'];
        coachData.add(CoachData(currentPage, message, pageSize, statusCode,
            coaches, totalCount, totalPages));

        dataContent['coaches'].forEach((item) => {
              coaches.add(Coach(
                item['id'] ?? '',
                item['avatar'] ?? '',
                item['name'] ?? '',
                item['dob'] ?? '',
                item['phoneNumber'] ?? '',
                item['gender'] ?? '',
                item['address'] ?? '',
                item['numberId'] ?? '',
                item['dateRange'] ?? '',
                item['issuedBy'] ?? '',
                item['description'] ?? '',
                item['createdAt'] ?? '',
                item['updatedAt'] ?? '',
              ))
            });

        return coaches;
      } else {
        if (response.statusCode == 401) {
          // Unauthorized
          await refreshToken();
          return await getCoaches(); // Retry after refreshing token
        }
        return [];
      }
    } catch (e) {
      throw Exception("error ${e}");
    }
  }

  static Future<List<Location>> getLocations() async {
    List<LocationData> branchData = [];
    List<Location> branches = [];

    var url = Uri.parse(
        'https://api.davidbadminton.com/locations?page=1&pageSize=4&seach=');

    try {
      String? token = await storage.read(key: 'access_token');

      if (token == null) {
        print('Token is null. Trying to refresh token.');
        await refreshToken();
        token = await storage.read(key: 'access_token');
      }

      final http.Response response =
          await http.get(url, headers: {'Authorization': 'Bearer ${token}'});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        var dataContent = data['data'];

        int? totalCount = dataContent['totalCount'];
        int? totalPages = dataContent['totalPages'];
        int? pageSize = dataContent['pageSize'];
        int? currentPage = dataContent['currentPage'];
        String? message = dataContent['message'];
        int? statusCode = dataContent['statusCode'];
        branchData.add(LocationData(currentPage, message, pageSize, statusCode,
            branches, totalCount, totalPages));

        dataContent['locations'].forEach((item) => {
              branches.add(Location(item['id'], item['name'], item['address'],
                  item['createdAt'], item['updatedAt']))
            });
        return branches;
      } else {
        if (response.statusCode == 401) {
          await refreshToken();
          return await getLocations();
        }
        return [];
      }
    } catch (e) {
      throw Exception("error ${e}");
    }
  }

  static Future<Map<String, dynamic>> getAttendData() async {
    final url =
        Uri.parse('https://api.davidbadminton.com/attendances/ingredients');
    List<LocationAttend> locations = [];
    List<CoachAttend> coaches = [];
    List<CourseAttend> courses = [];

    try {
      final token = await storage.read(key: 'access_token');

      if (token == null) {
        print('Token is null');
      }
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer ${token}'});

      if (response.statusCode == 200) {
        // Parse the JSON response
        final data = json.decode(response.body);
        final dataContent = data['data'];

        final locationsData = dataContent['locations'];
        final coachesData = dataContent['coaches'];
        final coursesData = dataContent['courses'];

        locationsData.forEach((item) => {
              locations.add(
                LocationAttend(
                  item['id'],
                  item['name'],
                  item['latitude'],
                  item['longitude'],
                  item['coaches'],
                  item['courses'],
                ),
              ),
            });

        coachesData.forEach((item) => {
              coaches.add(
                CoachAttend(
                  item['id'],
                  item['name'],
                  locations,
                  courses,
                ),
              ),
            });

        coursesData.forEach((item) => {
              courses.add(
                CourseAttend(
                  item['id'],
                  item['name'],
                  coaches,
                  locations,
                ),
              ),
            });

        return {
          'locations': locations,
          'courses': courses,
          'coaches': coaches,
        };
      } else {
        throw Exception('Failed to load data nè');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<StudentAttend>> getStudentAttendList({
    required int locationId,
    required int courseId,
    required int coachId,
    required int shift,
    required DateTime createdAt,
  }) async {
    final url = Uri.parse(
        'https://api.davidbadminton.com/attendances/ingredients?locationId=$locationId&courseId=$courseId&coachId=$coachId&shift=$shift&createdAt=$createdAt');

    final List<StudentAttend> students = [];

    try {
      final token = await storage.read(key: 'access_token');

      if (token == null) {
        throw Exception('Token is null');
      }

      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        // Parse the JSON response
        final data = json.decode(response.body);
        final dataContent = data['data'];
        final studentData = dataContent['students'];

        studentData.forEach((item) => {
              students.add(
                StudentAttend(
                  item['id'],
                  item['name'],
                  item['coachName'],
                  item['shift'],
                  item['isPresent'],
                ),
              ),
            });

        print(students);
        return students;
      } else {
        throw Exception('Failed to load students');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> postSaveAttendance({
    required String createdAt,
    required int shift,
    required int coachId,
    required int courseId,
    required int locationId,
    required Position position,
    required List<int> studentIds,
  }) async {
    final url = Uri.parse('https://api.davidbadminton.com/attendances');
    try {
      // Lấy token từ shared preferences
      final token = await storage.read(key: 'access_token');
      final sub = await storage.read(key: 'sub');

      // Tạo JSON body
      final body = jsonEncode({
        'authorId': sub,
        'createdAt': createdAt,
        'shift': shift,
        'coachId': coachId,
        'courseId': courseId,
        'locationId': locationId,
        'latitude': position.latitude,
        'longitude': position.longitude,
        'studentIds': studentIds,
      });

      // Gửi request POST
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      // Kiểm tra phản hồi từ server
      if (response.statusCode == 200) {
        print('Attendance saved successfully');
        // Xử lý thành công nếu cần
      } else {
        print(response.body);
        print(response.statusCode);
        print('Failed to save attendance: ${response.reasonPhrase}');
        // Xử lý lỗi nếu cần
      }
    } catch (e) {
      print('Error: $e');
      // Xử lý lỗi nếu cần
    }
  }

  static Future<void> postStudent({
    required String avatar,
    required String name,
    required String dob,
    required String phoneNumber,
    required bool gender,
    required String address,
    required String numberId,
    required String dateRange,
    required String issuedBy,
    required String description,
    required String createdAt,
    required String updatedAt,
    required String createdById,
    required int shift,
    required double defaultTuitionFee,
    required int status,
    required String healthStatus,
    required double height,
    required double weight,
    // required int courseId,
    // required int locationId,
    // required int coachId,
    required List<Map<String, dynamic>> parents,
    required String startDate,
    required String endDate,
  }) async {
    final url = Uri.parse('https://api.davidbadminton.com/students');
    try {
      String? token = await storage.read(key: 'access_token');

      if (token == null) {
        print('Token is null. Trying to refresh token.');
        await refreshToken();
        token = await storage.read(key: 'access_token');
      }

      final body = jsonEncode({
        'avatar': avatar,
        'name': name,
        'dob': dob,
        'phoneNumber': phoneNumber,
        'gender': gender,
        'address': address,
        'numberId': numberId,
        'dateRange': dateRange,
        'issuedBy': issuedBy,
        'description': description,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'createdById': createdById,
        'shift': shift,
        'defaultTuitionFee': defaultTuitionFee,
        'status': status,
        'healthStatus': healthStatus,
        'height': height,
        'weight': weight,
        // 'course': {
        //   // 'courseId': courseId,
        //   // 'locationId': locationId,
        //   // 'coachId': coachId,
        // },
        'parents': parents,
        'startDate': startDate,
        'endDate': endDate,
      });

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Student data posted successfully');
      } else {
        if (response.statusCode == 401) {
          await refreshToken();
          return postStudent(
            avatar: avatar,
            name: name,
            dob: dob,
            phoneNumber: phoneNumber,
            gender: gender,
            address: address,
            numberId: numberId,
            dateRange: dateRange,
            issuedBy: issuedBy,
            description: description,
            createdAt: createdAt,
            updatedAt: updatedAt,
            createdById: createdById,
            shift: shift,
            defaultTuitionFee: defaultTuitionFee,
            status: status,
            healthStatus: healthStatus,
            height: height,
            weight: weight,
            // courseId: courseId,
            // locationId: locationId,
            // coachId: coachId,
            parents: parents,
            startDate: startDate,
            endDate: endDate,
          );
        }
        print('Failed to post student data: ${response.statusCode}');
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
