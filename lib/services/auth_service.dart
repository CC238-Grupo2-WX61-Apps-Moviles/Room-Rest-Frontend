import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
    static Future<Map<String, dynamic>> login(String email, String password) async {
        final url = Uri.parse('http://antarticdonkeys.com/login?email=$email&password=$password');
        final response = await http.get(url);

        if (response.statusCode == 200) {
            return jsonDecode(response.body);
        } else {
            throw Exception('Failed to login');
        }
    }
}
