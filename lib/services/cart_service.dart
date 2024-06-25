import 'dart:convert';
import 'package:http/http.dart' as http;

import '../screens/cart_model.dart';

class CartService {
  final String baseUrl = 'https://api-akira.antarticdonkeys.com/cart';

  Future<void> addToCart(CartItem item) async {
    final url = Uri.parse(baseUrl);

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(
          'Failed to add product to cart with status code: ${response.statusCode}');
    }
  }

  Future<List<CartItem>> getCartItems(int userId) async {
    final url = Uri.parse('$baseUrl?userId=$userId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<CartItem> items =
          body.map((dynamic item) => CartItem.fromJson(item)).toList();
      return items;
    } else {
      throw Exception(
          'Failed to load cart items with status code: ${response.statusCode}');
    }
  }

  Future<void> clearCart(int userId) async {
    final cartItems = await getCartItems(userId);
    for (var item in cartItems) {
      await deleteCart(item.id);
    }
  }

  Future<void> deleteCart(int cartId) async {
    final url = Uri.parse('$baseUrl/$cartId');

    final response = await http.delete(url);

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception(
          'Failed to delete cart item with status code: ${response.statusCode}');
    }
  }
}
