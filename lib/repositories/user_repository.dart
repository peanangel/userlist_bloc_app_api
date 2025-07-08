// lib/repositories/user_repository.dart (ปรับปรุง)
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:userlist_bloc_app_api/common/exceptoions/api_exception.dart';
import '../models/user.dart';


class UserRepository {
  final String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/users'));

      if (response.statusCode == 200) {
        final List<dynamic> userJson = json.decode(response.body);
        return userJson.map((json) => User.fromJson(json)).toList();
      } else if (response.statusCode == 403) {
        throw ApiException('Access Denied: You do not have permission to access this resource.', statusCode: 403);
      } else if (response.statusCode == 404) {
        throw ApiException('Not Found: The requested resource was not found.', statusCode: 404);
      } else {
        throw ApiException('Failed to load users: ${response.statusCode}', statusCode: response.statusCode);
      }
    } catch (e) {
      if (e is http.ClientException) {
        // ข้อผิดพลาดที่เกิดจากปัญหาเครือข่าย เช่น ไม่มีอินเทอร์เน็ต
        throw ApiException('Network Error: Please check your internet connection. ${e.message}');
      }
      // ข้อผิดพลาดอื่นๆ ที่ไม่ได้ระบุประเภท
      throw ApiException('An unexpected error occurred: $e');
    }
  }
}