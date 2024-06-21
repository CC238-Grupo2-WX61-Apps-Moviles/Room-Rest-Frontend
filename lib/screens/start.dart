import 'package:akira_mobile/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:akira_mobile/screens/home.dart'; // Asegúrate de importar HomeScreen
import 'singin.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            child: Card(
              elevation: 0,
              color: const Color.fromARGB(0, 0, 0, 0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          height: 230,
                        ),
                        const SizedBox(height: 1.0),
                        const Text(
                          'Un Proyecto de Lambders',
                          style: TextStyle(
                            color: Color.fromARGB(255, 29, 29, 29),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        ElevatedButton(
                           onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 173, 15, 15),
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            minimumSize: const Size(double.infinity, 0),
                          ),
                          child: const Text(
                            'Iniciar Sesión',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        ElevatedButton(
                          onPressed: () {                    
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SingInScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 201, 201, 201),
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            minimumSize: const Size(double.infinity, 0),
                          ),
                          child: const Text(
                            'Registrarte',
                            style: TextStyle(
                              color: Color.fromARGB(255, 20, 20, 20),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                         const SizedBox(height: 40.0),
                          const Text(
                            'Al continuar, aceptas nuestros',
                            style: TextStyle(
                              color: Color.fromARGB(255, 58, 58, 58),
                              fontSize: 14.0,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const HomeScreen()),
                              );
                            },
                            child: const Text(
                              'términos y condiciones',
                              style: TextStyle(
                                color: Color.fromARGB(255, 58, 58, 58),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
