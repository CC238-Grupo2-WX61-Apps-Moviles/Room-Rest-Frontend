import 'dart:convert';
import 'package:http/http.dart' as http;

class ShippingService{

  static Future<Map<String, dynamic>> getShippingData(int userId) async {
    final response = await http.get(Uri.parse('https://api-akira.antarticdonkeys.com/shipping/$userId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load shipping data');
    }
  }

  static Future<Map<String, dynamic>> createDefaultShippingData() async {
    final url = Uri.parse('https://api-akira.antarticdonkeys.com/shipping');

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


    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create default shipping data with status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> updateShippingData(int id, Map<String, dynamic> shippingData) async {
    final url = Uri.parse('https://api-akira.antarticdonkeys.com/shipping/$id');

    shippingData['shippingId'] = id;

    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(shippingData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update shipping data with status code: ${response.statusCode}');
    }
  }

  static Future<void> createOrder(String email, String address, String contact, double totalPrice, int userId) async {
    final url = Uri.parse('https://api-akira.antarticdonkeys.com/orders');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'address': address,
        'contact': contact,
        'totalPrice': totalPrice,
        'userId': userId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Order created successfully');
    } else {
      throw Exception('Failed to create order with status code: ${response.statusCode}');
    }
  }

  static Future<List<dynamic>> getOrders(int userId) async {
    final url = Uri.parse('https://api-akira.antarticdonkeys.com/orders?userId=$userId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch orders with status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> getOrderDetail(int orderId) async {
    final url = Uri.parse('https://api-akira.antarticdonkeys.com/orders/$orderId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch order detail with status code: ${response.statusCode}');
    }
  }

}