import 'package:akira_mobile/services/shipping_service.dart';
import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import 'checkout_screen.dart';
import 'cart_model.dart';
import 'login.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<CartItem>> futureCartItems;
  Map<String, dynamic> userData = UserDataProvider.userData;
  Map<String, dynamic>? shippingData;

  @override
  void initState() {
    super.initState();
    futureCartItems = CartService().getCartItems(userData['userId']);
    fetchShippingData();
  }

  Future<void> fetchShippingData() async {
    try {
      final data = await ShippingService.getShippingData(userData['userId']);
      setState(() {
        shippingData = data;
      });
      print('Shipping data: $shippingData');
    } catch (e) {
      print('Failed to fetch shipping data: $e');
    }
  }

  Future<void> deleteCartItem(int cartId) async {
    await CartService().deleteCart(cartId);
    setState(() {
      futureCartItems = CartService().getCartItems(userData['userId']);
    });
  }

  Future<void> clearCart() async {
    await CartService().clearCart(userData['userId']);
    setState(() {
      futureCartItems = CartService().getCartItems(userData['userId']);
    });
  }

  double calculateTotal(List<CartItem> cartItems) {
    double subtotal = 0;
    cartItems.forEach((item) {
      subtotal += item.price * item.quantity;
    });
    double shipping = 5.00;
    double total = subtotal + shipping;
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CartItem>>(
      future: futureCartItems,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CartItem> cartItems = snapshot.data!;
          double subtotal = 0;
          cartItems.forEach((item) {
            subtotal += item.price * item.quantity;
          });
          double shipping = 5.00;
          double total = subtotal + shipping;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Carrito'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  ...cartItems
                      .map((item) => CartItemWidget(
                            item: item,
                            onDelete: deleteCartItem,
                            onQuantityChanged: () => setState(() {}),
                          ))
                      .toList(),
                  const SizedBox(height: 20.0),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Resumen de Compra',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal: \$${subtotal.toStringAsFixed(2)}'),
                            Text(
                                'Gastos de Envío: \$${shipping.toStringAsFixed(2)}'),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        const Divider(),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total a Pagar:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${total.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: shippingData == null
                                ? null
                                : () async {
                                    await clearCart();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CheckoutScreen(
                                          userData: userData,
                                          shippingData: shippingData!,
                                          total: total,
                                        ),
                                      ),
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFAA1D1D),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                'Ir al Checkout',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

class CartItemWidget extends StatefulWidget {
  final CartItem item;
  final Function(int) onDelete;
  final Function() onQuantityChanged;

  const CartItemWidget({
    required this.item,
    required this.onDelete,
    required this.onQuantityChanged,
  });

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(widget.item.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item.nameCategory,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                '\$${(widget.item.price * widget.item.quantity).toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  const Text('Cantidad:'),
                  const SizedBox(width: 10.0),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (widget.item.quantity > 1) {
                          widget.item.quantity--;
                          widget.onQuantityChanged();
                        }
                      });
                    },
                  ),
                  Text('${widget.item.quantity}'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        widget.item.quantity++;
                        widget.onQuantityChanged();
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await widget.onDelete(widget.item.id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
