import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/shipping_service.dart';
import 'processingshipping.dart';

class CheckoutScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  final Map<String, dynamic> shippingData;
  final double total;

  const CheckoutScreen({
    required this.userData,
    required this.shippingData,
    required this.total,
  });

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
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
            Text(
                '${widget.userData['name']} ${widget.userData['surname']} +51 ${widget.userData['numberCellphone']}'),
            Text('${widget.shippingData['address']}'),
            Text(
                '${widget.shippingData['district']}, ${widget.shippingData['province']}, Perú'),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () async {
                final newShippingData = await showDialog<Map<String, dynamic>>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Modificar Dirección'),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              initialValue: widget.shippingData['address'],
                              decoration:
                                  InputDecoration(labelText: 'Dirección'),
                              onChanged: (value) {
                                widget.shippingData['address'] = value;
                              },
                            ),
                            TextFormField(
                              initialValue: widget.shippingData['district'],
                              decoration:
                                  InputDecoration(labelText: 'Distrito'),
                              onChanged: (value) {
                                widget.shippingData['district'] = value;
                              },
                            ),
                            TextFormField(
                              initialValue: widget.shippingData['province'],
                              decoration:
                                  InputDecoration(labelText: 'Provincia'),
                              onChanged: (value) {
                                widget.shippingData['province'] = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context, widget.shippingData);
                          },
                          child: Text('Guardar'),
                        ),
                      ],
                    );
                  },
                );

                if (newShippingData != null) {
                  try {
                    await ShippingService.updateShippingData(
                      widget.shippingData['shippingId'],
                      newShippingData,
                    );

                    setState(() {
                      widget.shippingData['address'] =
                          newShippingData['address'];
                      widget.shippingData['district'] =
                          newShippingData['district'];
                      widget.shippingData['province'] =
                          newShippingData['province'];
                    });
                  } catch (e) {
                    print('Error updating shipping data: $e');
                  }
                }
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
            Text(
                '**** **** **** ${widget.shippingData['linkedCard'].substring(widget.shippingData['linkedCard'].length - 4)}'),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () async {
                final newPaymentData = await showDialog<Map<String, dynamic>>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Modificar Método de Pago'),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              initialValue: widget.shippingData['linkedCard'],
                              decoration: InputDecoration(
                                  labelText: 'Número de Tarjeta'),
                              onChanged: (value) {
                                widget.shippingData['linkedCard'] = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context, widget.shippingData);
                          },
                          child: Text('Guardar'),
                        ),
                      ],
                    );
                  },
                );

                if (newPaymentData != null) {
                  try {
                    await ShippingService.updateShippingData(
                      widget.shippingData['shippingId'],
                      newPaymentData,
                    );

                    setState(() {
                      widget.shippingData['linkedCard'] =
                          newPaymentData['linkedCard'];
                    });
                  } catch (e) {
                    print('Error updating payment data: $e');
                  }
                }
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
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal'),
                      Text('S/ ${widget.total - 30.00}'),
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
                        'S/ ${widget.total}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await ShippingService.createOrder(
                          widget.userData['email'],
                          widget.shippingData['address'],
                          '${widget.userData['name']} ${widget.userData['surname']}',
                          widget.total,
                          widget.userData['userId'],
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProcessingPaymentScreen(),
                          ),
                        );
                      } catch (e) {
                        print('Error creating order: $e');
                      }
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
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}
