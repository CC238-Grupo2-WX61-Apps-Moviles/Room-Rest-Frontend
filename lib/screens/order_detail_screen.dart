import 'package:flutter/material.dart';
import '../services/shipping_service.dart';
import 'login.dart';

class OrderDetailScreen extends StatefulWidget {
  final int orderId;

  const OrderDetailScreen({required this.orderId});

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  List<Map<String, dynamic>>? orderDetails;
  Map<String, dynamic> userData = UserDataProvider.userData;

  @override
  void initState() {
    super.initState();
    fetchOrderDetails();
  }

  Future<void> fetchOrderDetails() async {
    try {
      final data = await ShippingService.getOrderDetails(userData['userId']);
      setState(() {
        orderDetails = data.cast<Map<String, dynamic>>();
      });
    } catch (e) {
      print('Failed to fetch order details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (orderDetails == null || orderDetails!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Envío en Curso'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Envíos en Curso'),
      ),
      body: ListView.builder(
        itemCount: orderDetails!.length,
        itemBuilder: (context, index) {
          final orderDetail = orderDetails![index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Email'),
                          Text(orderDetail['email']),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Contacto'),
                          Text(orderDetail['contact']),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Direccio  de Entrega'),
                          Text(orderDetail['address']),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Precio Total Pagado'),
                          Text('S/. ${orderDetail['totalPrice']}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}