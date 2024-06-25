import 'package:flutter/material.dart';
import '../services/shipping_service.dart';

class OrderDetailScreen extends StatefulWidget {
  final int orderId;

  const OrderDetailScreen({required this.orderId});

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  Map<String, dynamic>? orderDetail;

  @override
  void initState() {
    super.initState();
    fetchOrderDetail();
  }

  Future<void> fetchOrderDetail() async {
    try {
      final data = await ShippingService.getOrderDetail(widget.orderId);
      setState(() {
        orderDetail = data;
      });
    } catch (e) {
      print('Failed to fetch order detail: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (orderDetail == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Envío en Curso'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Envío en Curso "${orderDetail!['id']}"'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...orderDetail!['items'].map<Widget>((item) {
              return ListTile(
                leading: Image.network(item['imageUrl'], height: 50),
                title: Text(item['name']),
                subtitle: Text('S/. ${item['price']}'),
                trailing: Text('Cantidad: ${item['quantity']}'),
              );
            }).toList(),
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
                      Text('N° Tracking'),
                      Text(orderDetail!['id'].toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Precio Total Pagado'),
                      Text('S/. ${orderDetail!['totalPrice']}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Estado del envío'),
                      Text(orderDetail!['status']),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
