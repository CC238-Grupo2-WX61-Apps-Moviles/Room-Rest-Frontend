import 'dart:convert';
import 'package:akira_mobile/screens/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {

    final String baseUrl = 'http://antarticdonkeys.com/products';

    Future<List<Product>> fetchProducts() async {
        final response = await http.get(Uri.parse(baseUrl));

        if (response.statusCode == 200) {
            List<dynamic> body = jsonDecode(response.body);
            List<Product> products = body.map((dynamic item) => Product.fromJson(item)).toList();
            return products;
        } else {
            throw Exception('Failed to load products');
        }
    }

    Future<List<Product>> fetchKpopProducts() async {
        final response = await http.get(Uri.parse('$baseUrl/kpop'));

        if (response.statusCode == 200) {
            List<dynamic> body = jsonDecode(response.body);
            List<Product> products = body.map((dynamic item) => Product.fromJson(item)).toList();
            return products;
        } else {
            throw Exception('Failed to load Kpop products');
        }
    }

    Future<List<Product>> fetchAnimeProducts() async {
        final response = await http.get(Uri.parse('$baseUrl/anime'));

        if (response.statusCode == 200) {
            List<dynamic> body = jsonDecode(response.body);
            List<Product> products = body.map((dynamic item) => Product.fromJson(item)).toList();
            return products;
        } else {
            throw Exception('Failed to load Anime products');
        }
    }

    Future<List<Product>> fetchLecturaProducts() async {
        final response = await http.get(Uri.parse('$baseUrl/lectura'));

        if (response.statusCode == 200) {
            List<dynamic> body = jsonDecode(response.body);
            List<Product> products = body.map((dynamic item) => Product.fromJson(item)).toList();
            return products;
        } else {
            throw Exception('Failed to load Lectura products');
        }
    }
    
}