import 'package:akira_mobile/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:akira_mobile/services/product_service.dart';
import 'package:akira_mobile/screens/product_model.dart';
import 'package:akira_mobile/screens/product_detail.dart';

import 'package:fluttertoast/fluttertoast.dart';
import '../services/cart_service.dart';
import 'cart_model.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Product> _searchResults = [];
  bool _isLoading = false;
  String _selectedProductType = 'All';
  final Map<String, dynamic> userData = UserDataProvider.userData;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    _searchProducts(_searchController.text);
  }

  Future<void> _searchProducts(String query) async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<Product> results = await ProductService().fetchSearchProducts(query);
      setState(() {
        if (_selectedProductType == 'All') {
          _searchResults = results;
        } else {
          _searchResults = results
              .where((product) => product.category == _selectedProductType)
              .toList();
        }
      });
    } catch (e) {
      print('Error searching products: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Buscar producto',
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            _searchProducts(value);
          },
        ),
      ),
      body: Column(
        children: [
          _buildProductTypeFilter(),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
                    itemCount: _searchResults.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (context, index) {
                      final product = _searchResults[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailScreen(product: product),
                            ),
                          );
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.network(
                                  product.image,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.name,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'S/. ${product.price}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.red[900], // Precio en rojo
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    CartItem item = CartItem(
                                      id: product.id,
                                      quantity: 1,
                                      userId: userData[
                                          'userId'], // Asegúrate de tener acceso a userData
                                      nameCategory: product.nameCategory,
                                      name: product.name,
                                      price: product.price,
                                      color: product.color,
                                      category: product.category,
                                      description: product.description,
                                      image: product.image,
                                      productId: product.id,
                                    );
                                    CartService().addToCart(item);
                                    Fluttertoast.showToast(
                                      msg: "Producto agregado al carrito",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red[900]!),
                                  ),
                                  child: Text(
                                    'Agregar al carrito',
                                    style: TextStyle(
                                      color: Colors.white, // Texto blanco
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductTypeFilter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildFilterButton('All', 'Todos'),
          _buildFilterButton('Anime', 'Anime'),
          _buildFilterButton('KPOP', 'KPOP'),
          _buildFilterButton('Lectura', 'Lectura'),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String type, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        label: Text(label),
        selected: _selectedProductType == type,
        onSelected: (bool selected) {
          setState(() {
            _selectedProductType = selected ? type : 'All';
            _searchProducts(_searchController.text);
          });
        },
      ),
    );
  }
}
