import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static Future<Map<String, dynamic>> getUserData(int userId) async {
    final response = await http
        .get(Uri.parse('https://api-akira.antarticdonkeys.com/users/$userId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  static Future<void> deleteUser(int userId) async {
    final response = await http.delete(
      Uri.parse('https://api-akira.antarticdonkeys.com/users/$userId'),
    );

    if (response.statusCode == 204) {
      print('User deleted successfully');
    } else {
      throw Exception('Failed to delete user: ${response.statusCode}');
    }
  }

  static Future<void> updateUser(
      int userId, Map<String, dynamic> updatedUserData) async {
    final response = await http.put(
      Uri.parse('https://api-akira.antarticdonkeys.com/users/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedUserData),
    );

    if (response.statusCode == 200) {
      print('User updated successfully');
    } else {
      throw Exception('Failed to update user: ${response.statusCode}');
    }
  }
}
