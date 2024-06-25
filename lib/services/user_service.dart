import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static Future<Map<String, dynamic>> getUserData(int userId) async {
    final response = await http
        .get(Uri.parse('https://akira-api-vidqtyxpba-uc.a.run.app/users/$userId'));

    if (response.statusCode == 200) {
      String decodedResponse = utf8.decode(response.bodyBytes);
      return jsonDecode(decodedResponse);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  static Future<void> deleteUser(int userId) async {
    final response = await http.delete(
      Uri.parse('https://akira-api-vidqtyxpba-uc.a.run.app/users/$userId'),
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
      Uri.parse('https://akira-api-vidqtyxpba-uc.a.run.app/users/$userId'),
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
