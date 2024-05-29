import 'package:akira_mobile/screens/singin2.dart';
import 'package:flutter/material.dart';
import 'start.dart';

class SingInScreen extends StatelessWidget {
  const SingInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color customColor1 = Color.fromRGBO(230, 230, 230, 1);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StartScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Image.asset(
                    'assets/returnIcon.png',
                    height: 20.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Center(
              child: SizedBox(
                child: Card(
                  elevation: 0,
                  color: const Color.fromARGB(0, 0, 0, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/logo.png',
                            height: 180,
                          ),
                          const SizedBox(height: 15.0),
                          const Text(
                            'Registro',
                        style: TextStyle(
                          color: Color.fromARGB(255, 29, 29, 29),
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Nombre Completo',
                              hintStyle: const TextStyle(
                                color: Color(0xFFA1A1A1),
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0.07,
                                letterSpacing: 0.50,
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(0, 158, 158, 158)),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(0, 158, 158, 158)),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              filled: true,
                              fillColor: customColor1,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(10.5),
                                child: Image.asset(
                                  'assets/usericon.png',
                                  height: 10.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Correo',
                              hintStyle: const TextStyle(
                                color: Color(0xFFA1A1A1),
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0.07,
                                letterSpacing: 0.50,
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(0, 158, 158, 158)),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(0, 158, 158, 158)),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              filled: true,
                              fillColor: customColor1,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Image.asset(
                                  'assets/passwordicon.png',
                                  height: 10.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Contraseña',
                              hintStyle: const TextStyle(
                                color: Color(0xFFA1A1A1),
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0.07,
                                letterSpacing: 0.50,
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(0, 158, 158, 158)),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(0, 158, 158, 158)),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              filled: true,
                              fillColor: customColor1,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Image.asset(
                                  'assets/passwordicon.png',
                                  height: 10.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Repita su Contraseña',
                              hintStyle: const TextStyle(
                                color: Color(0xFFA1A1A1),
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0.07,
                                letterSpacing: 0.50,
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(0, 158, 158, 158)),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(0, 158, 158, 158)),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              filled: true,
                              fillColor: customColor1,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Image.asset(
                                  'assets/passwordicon.png',
                                  height: 10.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SingIn2Screen()),
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
                          'Continuar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
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
          ],
        ),
        ),        
      ),
    );
  }
}