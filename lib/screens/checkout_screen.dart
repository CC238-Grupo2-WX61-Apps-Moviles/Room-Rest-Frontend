import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  final Map<String, dynamic> userData;
  final Map<String, dynamic> shippingData;
  final double total;

  const CheckoutScreen({required this.userData, required this.shippingData, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckOut'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            const Text(
              'Dirección de Entrega',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text('${userData['name']} ${userData['surname']} +51 ${userData['numberCellphone']}'),
            Text('${shippingData['address']}'),
            Text('${shippingData['district']}, ${shippingData['province']}, Perú'),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                // Acción para modificar la dirección
              },
              child: const Text(
                '+ Modificar dirección',
                style: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Método de Pago',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text('**** **** **** ${shippingData['linkedCard'].substring(shippingData['linkedCard'].length - 4)}'),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                // Acción para modificar el método de pago
              },
              child: const Text(
                '+ Modificar método de pago',
                style: TextStyle(color: Colors.red),
              ),
            ),
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
                  const Text(
                    'Resumen',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal'),
                      Text('S/ ${total - 30.00}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Gastos de envío'),
                      Text('S/ 30.00'),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total a pagar',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'S/ $total',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Acción para ir a Checkout
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFAA1D1D),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Pagar',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               //
              ],
            ),
          ],
        ),
      ),
    );
  }
}
