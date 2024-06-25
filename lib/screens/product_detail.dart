import 'package:flutter/material.dart';
import 'package:akira_mobile/screens/product_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/cart_service.dart';
import 'cart_model.dart';
import 'login.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  final Map<String, dynamic> userData = UserDataProvider.userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.red[900],
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          product.image,
                          height: 400.0,
                          width: 400.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'S/. ${product.price}',
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.red[900],
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              'Coleccionable',
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20.0),
                            ElevatedButton.icon(
                              onPressed: () {
                                CartItem item = CartItem(
                                  id: product.id,
                                  quantity: 1,
                                  userId: userData['userId'],
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
                                    backgroundColor: Colors.red[900],
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                              icon: const Icon(Icons.add_shopping_cart),
                              label: const Text('Agregar al carrito'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[900],
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                textStyle: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          product.image,
                          height: 300.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'S/. ${product.price}',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Coleccionable',
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton.icon(
                        onPressed: () {
                          CartItem item = CartItem(
                            id: product.id,
                            quantity: 1,
                            userId: userData['userId'],
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
                              backgroundColor: Colors.red[900],
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text('Agregar al carrito'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[900],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          textStyle: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
