import 'package:akira_mobile/screens/home.dart';
import 'package:flutter/material.dart';

class ProcessingPaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', height: 150),
              const SizedBox(height: 30.0),
              const Text(
                '¡Su compra ha sido procesada con éxito!',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Gracias por comprar en AKIRA',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),              
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false,
                  );
                },
                child: const Text('Volver a inicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
