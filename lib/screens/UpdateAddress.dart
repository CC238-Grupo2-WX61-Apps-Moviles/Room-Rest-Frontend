import 'package:flutter/material.dart';
import 'package:akira_mobile/screens/home.dart';
import 'package:akira_mobile/services/shipping_service.dart';

import 'login.dart';

class UpdateAddressScreen extends StatefulWidget {
  UpdateAddressScreen({Key? key}) : super(key: key);

  @override
  _UpdateAddressScreenState createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  late Future<Map<String, dynamic>> _futureShippingData;

  final Map<String, dynamic> userData = UserDataProvider.userData;

  @override
  void initState() {
    super.initState();
    _futureShippingData = ShippingService.getShippingData(userData['userId']);
  }

  void updateAddress(BuildContext context) async {
    try {
      final shippingData = {
        'shippingId': userData['userId'],
        'address': addressController.text,
        'district': districtController.text,
        'province': provinceController.text,
        'paymentMethod': 'No payment method',
        'linkedCard': 'No linked Card',
      };

      await ShippingService.updateShippingData(userData['userId'], shippingData);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      print('Failed to update address: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color customColor1 = Color.fromRGBO(230, 230, 230, 1);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, dynamic>>(
          future: _futureShippingData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final shippingData = snapshot.data!;
              addressController.text = shippingData['address'] ?? '';
              districtController.text = shippingData['district'] ?? '';
              provinceController.text = shippingData['province'] ?? '';

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
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
                                    'Actualizar Dirección',
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
                                        controller: addressController,
                                        decoration: InputDecoration(
                                          hintText: 'Dirección',
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
                                        controller: districtController,
                                        decoration: InputDecoration(
                                          hintText: 'Distrito',
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
                                        controller: provinceController,
                                        decoration: InputDecoration(
                                          hintText: 'Provincia',
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
                                      updateAddress(context);
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
                                      'Actualizar',
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
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}