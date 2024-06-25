import 'package:akira_mobile/screens/login.dart';
import 'package:akira_mobile/screens/singin.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/shipping_service.dart';

class SingIn2Screen extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  SingIn2Screen({
    Key? key,
    required this.nameController,
    required this.surnameController,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();

  @override
  State<SingIn2Screen> createState() => _SingIn2ScreenState();
}

class _SingIn2ScreenState extends State<SingIn2Screen> {
  String? selectedPaymentMethod;
  bool _acceptedTerms = false;

  void _showTermsAndConditions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Términos y Condiciones'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bienvenido a Akira, tu destino para el mejor merchandising de Kpop, anime y manga en Perú. Al utilizar nuestro sitio web, aceptas cumplir con los siguientes términos y condiciones:\n',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '• Los productos ofrecidos en nuestro sitio web están destinados únicamente para uso personal.\n'
                  '• No nos hacemos responsables de los daños causados por un uso indebido de los productos.\n'
                  '• El uso de nuestra plataforma implica la aceptación de nuestra política de privacidad y seguridad.\n'
                  '• Reservamos el derecho de cambiar los términos y condiciones en cualquier momento sin previo aviso.\n',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Gracias por elegir Akira para satisfacer tus necesidades de merchandising asiático. ¡Disfruta de tu experiencia de compra!',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color customColor1 = Color.fromRGBO(230, 230, 230, 1);

    bool _isFormValid() {
      return _acceptedTerms;
    }

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
                    MaterialPageRoute(builder: (context) => SingInScreen()),
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
                                  controller: widget.phoneController,
                                  decoration: InputDecoration(
                                    hintText: 'Teléfono',
                                    hintStyle: const TextStyle(
                                      color: Color(0xFFA1A1A1),
                                      fontSize: 15,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.07,
                                      letterSpacing: 0.50,
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(0, 158, 158, 158)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(0, 158, 158, 158)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
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
                                InputDecorator(
                                  decoration: InputDecoration(
                                    hintText: 'Método de Pago',
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(0, 158, 158, 158)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(0, 230, 13, 13)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
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
                                  child: Stack(
                                    children: [
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: widget.paymentMethodController
                                                  .text.isEmpty
                                              ? null
                                              : widget
                                                  .paymentMethodController.text,
                                          hint: const Text('Método de Pago'),
                                          isDense: true,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              widget.paymentMethodController
                                                  .text = newValue!;
                                            });
                                          },
                                          items: <String>[
                                            'Crédito/Débito',
                                            'Billetera Electrónica'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      Positioned(
                                        top: 100.0,
                                        left: 13.0,
                                        child: Image.asset(
                                          'assets/passwordicon.png',
                                          height: 10.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _acceptedTerms,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _acceptedTerms = value!;
                                        });
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: _showTermsAndConditions,
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: const Text(
                                          'Aceptar términos y condiciones',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                128, 128, 128, 0.8),
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                                ElevatedButton(
                                  onPressed: _isFormValid()
                                      ? () async {
                                          try {
                                            final registerResponse =
                                                await AuthService.register(
                                              widget.nameController.text,
                                              widget.surnameController.text,
                                              widget.emailController.text,
                                              widget.passwordController.text,
                                              widget.phoneController.text,
                                              widget
                                                  .paymentMethodController.text,
                                            );

                                            print(registerResponse);
                                            if (registerResponse['status'] ==
                                                'SUCCESS') {
                                              try {
                                                final shippingResponse =
                                                    await ShippingService
                                                        .createDefaultShippingData();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginScreen(),
                                                  ),
                                                );
                                              } catch (e) {
                                                print(
                                                    'Excepción durante la creación de datos de envío: $e');
                                              }
                                            } else {
                                              print(
                                                  'Error de registro: ${registerResponse['message']}');
                                            }
                                          } catch (e) {
                                            print(
                                                'Excepción durante el registro: $e');
                                          }
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 173, 15, 15),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    minimumSize: const Size(double.infinity, 0),
                                  ),
                                  child: const Text(
                                    'Registrarse',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
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
