import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('http://antarticdonkeys.com/login?email=$email&password=$password');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to login with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to login due to network error');
    }
  }

  static Future<Map<String, dynamic>> getUserData(int userId) async {
    final response = await http.get(Uri.parse('http://antarticdonkeys.com/users/$userId'));

    if (response.statusCode == 200 ) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }
  static Future<Map<String, dynamic>> register(String name, String surname, String email, String password, String numberCellphone, String payment) async {
    final url = Uri.parse('http://antarticdonkeys.com/register');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'surname': surname,
        'email': email,
        'password': password,
        'numberCellphone': numberCellphone,
        'payment': payment,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register with status code: ${response.statusCode}');
    }
  }


}
