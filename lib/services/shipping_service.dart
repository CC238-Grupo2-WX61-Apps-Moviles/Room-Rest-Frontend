import 'dart:convert';
import 'package:http/http.dart' as http;

class ShippingService{

  static Future<Map<String, dynamic>> getShippingData(int userId) async {
    final response = await http.get(Uri.parse('http://antarticdonkeys.com/shipping/$userId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load shipping data');
    }
  }

  static Future<Map<String, dynamic>> createDefaultShippingData() async {
    final url = Uri.parse('http://antarticdonkeys.com/shipping');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'address': 'No address',
        'district': 'No district',
        'province': 'No province',
        'paymentMethod': 'No payment method',
        'linkedCard': 'No linked card',
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create default shipping data with status code: ${response.statusCode}');
    }
  }

}