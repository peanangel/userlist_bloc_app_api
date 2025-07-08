import 'dart:convert';
import 'package:userlist_bloc_app_api/common/exceptoions/api_exception.dart';
import 'package:userlist_bloc_app_api/models/user.dart';
import 'package:http/http.dart' as http;

class UserDetailRepository {
  final String _baseUrl = 'https://jsonplaceholder.typicode.com/users';

  Future<User> fetchUserDetail(int userId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$userId'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> userJson = json.decode(response.body);
        return User.fromJson(userJson);
      } else if (response.statusCode == 404) {
        throw ApiException('User not found with ID: $userId', statusCode: 404);
      } else if (response.statusCode == 403) {
        throw ApiException(
          'Access Denied: You do not have permission to access this resource.',
          statusCode: 403,
        );
      } else if (response.statusCode == 500) {
        throw ApiException(
          'Server Error: Please try again later.',
          statusCode: 500,
        );
      } else {
        // (จัดการ ApiException เหมือนเดิม)
        throw ApiException(
          'Failed to load users: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      // <<< ปรับปรุงการจัดการ Exception ตรงนี้ >>>
      if (e is http.ClientException) {
        // ข้อผิดพลาดที่เกิดจากปัญหาเครือข่าย เช่น ไม่มีอินเทอร์เน็ต
        throw ApiException(
          'Network Error: Please check your internet connection. ${e.message}',
        );
      }
      // ถ้าเป็น ApiException ที่เรา throw มาเอง ก็ rethrow ไปเลย
      if (e is ApiException) {
        rethrow;
      }
      // ข้อผิดพลาดอื่นๆ ที่ไม่ได้ระบุประเภท
      throw ApiException(
        'An unexpected error occurred while fetching user detail: $e',
      );
    }
  }
}
