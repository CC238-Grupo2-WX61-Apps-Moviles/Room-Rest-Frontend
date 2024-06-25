import 'package:flutter/material.dart';
import 'singin2.dart';
import 'start.dart';

class SingInScreen extends StatefulWidget {
  SingInScreen({Key? key}) : super(key: key);

  @override
  _SingInScreenState createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  bool isButtonEnabled = false;

  List<String> userType = ['Vendedor', 'Fanático'];

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = nameController.text.isNotEmpty &&
          surnameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          typeController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    nameController.addListener(_updateButtonState);
    surnameController.addListener(_updateButtonState);
    emailController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);
    typeController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    typeController.dispose();
    super.dispose();
  }

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
                    MaterialPageRoute(
                        builder: (context) => const StartScreen()),
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
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    hintText: 'Nombre',
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
                                TextField(
                                  controller: surnameController,
                                  decoration: InputDecoration(
                                    hintText: 'Apellido',
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
                                DropdownButtonFormField<String>(
                                  value: typeController.text.isEmpty ? null : typeController.text,
                                  decoration: const InputDecoration(
                                    hintText: 'Tipo de Usuario',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFA1A1A1),
                                      fontSize: 15,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.07,
                                      letterSpacing: 0.50,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(0, 158, 158, 158)),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(0, 158, 158, 158)),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    filled: true,
                                    fillColor: customColor1,
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(13.0),
                                      child: Icon(Icons.person),
                                    ),
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      typeController.text = newValue!;
                                    });
                                  },
                                  items: userType.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),

                                const SizedBox(height: 12.0),
                                TextField(
                                  controller: emailController,
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
                                  controller: passwordController,
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
                              onPressed: isButtonEnabled
                                  ? () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SingIn2Screen(
                                            nameController: nameController,
                                            surnameController:
                                                surnameController,
                                            emailController: emailController,

                                            passwordController:
                                                passwordController,
                                            typeController: typeController,

                                          ),
                                        ),
                                      );
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 173, 15, 15),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18.0),
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
