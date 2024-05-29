import 'package:flutter/material.dart';
import 'package:akira_mobile/services/product_service.dart';
import 'package:akira_mobile/screens/product_model.dart';

class ProductProvider with ChangeNotifier {
    
    List<Product> _products = [];
    List<Product> _kpopProducts = [];
    List<Product> _animeProducts = [];
    List<Product> _lecturaProducts = [];
    bool _isLoading = false;
    String? _errorMessage;

    List<Product> get products => _products;
    List<Product> get kpopProducts => _kpopProducts;
    List<Product> get animeProducts => _animeProducts;
    List<Product> get lecturaProducts => _lecturaProducts;
    bool get isLoading => _isLoading;
    String? get errorMessage => _errorMessage;

    Future<void> fetchProducts() async {
        _isLoading = true;
        _errorMessage = null; 
        notifyListeners();

        try {
            _products = await ProductService().fetchProducts();
            _kpopProducts = await ProductService().fetchKpopProducts();
            _animeProducts = await ProductService().fetchAnimeProducts();
            _lecturaProducts = await ProductService().fetchLecturaProducts();
        } catch (e) {
            _errorMessage = 'Failed to load products: $e';
            print('Error fetching products: $e');
        }
        _isLoading = false;
        notifyListeners();
    }
}