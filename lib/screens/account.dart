import 'package:flutter/material.dart';
import 'package:akira_mobile/screens/order_detail_screen.dart';
import 'package:akira_mobile/screens/UpdateAddress.dart';
import 'package:akira_mobile/screens/start.dart';
import 'checkout_screen.dart';
import '../services/shipping_service.dart';
import '../services/user_service.dart';
import 'login.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Map<String, dynamic>? shippingData;
  Map<String, dynamic> userData = UserDataProvider.userData;
  List<Map<String, dynamic>> orders = [];

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchShippingData();
    fetchOrders();
  }

  Future<void> fetchUserData() async {
    try {
      final data =
          await UserService.getUserData(UserDataProvider.userData['userId']);
      setState(() {
        userData = data;

        print('Fetched user data: $data');
        print('User ID from data: ${data['id']}');
        userData['userId'] = data['id'];
      });
    } catch (e) {
      print('Failed to fetch user data: $e');
    }
  }

  Future<void> fetchShippingData() async {
    try {
      if (userData['userId'] != null) {
        final data = await ShippingService.getShippingData(userData['userId']);
        setState(() {
          shippingData = data;
        });
      } else {
        print('User ID is null, unable to fetch shipping data.');
      }
    } catch (e) {
      print('Failed to fetch shipping data: $e');
    }
  }

  Future<void> fetchOrders() async {
    try {
      if (userData['userId'] != null) {
        final data = await ShippingService.getOrders(userData['userId']);
        setState(() {
          orders = List<Map<String, dynamic>>.from(data);
        });
      } else {
        print('User ID is null, unable to fetch orders.');
      }
    } catch (e) {
      print('Failed to fetch orders: $e');
    }
  }

  Future<void> deleteUser() async {
    try {
      if (userData['userId'] != null) {
        await UserService.deleteUser(userData['userId']);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const StartScreen()),
          (route) => false,
        );
      } else {
        print('User ID is null, unable to delete user.');
      }
    } catch (e) {
      print('Failed to delete user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuenta'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Hola ${userData['name']} (${userData['type']})',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Información Personal',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text('Nombres: ${userData['name']}'),
                    Text('Apellidos: ${userData['surname']}'),
                    Text('Teléfono: ${userData['numberCellphone']}'),
                    Text('Correo: ${userData['email']}'),
                    const SizedBox(height: 8.0),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UpdateInfoScreen(userData: userData),
                          ),
                        ).then((_) {
                          fetchUserData();
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        'Actualizar Información',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dirección',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                        'Dirección: ${shippingData?['address'] ?? 'Cargando...'}'),
                    Text(
                        'Distrito: ${shippingData?['district'] ?? 'Cargando...'}'),
                    Text(
                        'Provincia: ${shippingData?['province'] ?? 'Cargando...'}'),
                    const SizedBox(height: 8.0),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateAddressScreen(),
                          ),
                        ).then((_) {
                          fetchShippingData();
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        'Actualizar Dirección',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Método de Pago',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text('Método: ${userData['payment']}'),
                    Text('Tarjeta: ${shippingData?['linkedCard'] ?? ''}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            if (orders.isNotEmpty)
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Historial de Pedidos',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      ...orders.map((order) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OrderDetailScreen(orderId: order['id']),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Text('Track Nº: ${order['id']}',
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 20.0),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      bool confirmDelete = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Confirmar Eliminación'),
                          content: Text(
                              '¿Estás seguro de que deseas eliminar tu cuenta?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text('Eliminar'),
                            ),
                          ],
                        ),
                      );

                      if (confirmDelete == true) {
                        try {
                          if (userData['userId'] != null) {
                            await UserService.deleteUser(userData['userId']);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const StartScreen()),
                              (route) => false,
                            );
                          } else {
                            print('User ID is null, unable to delete user.');
                          }
                        } catch (e) {
                          print('Failed to delete user: $e');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFAA1D1D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text(
                      'Eliminar Cuenta',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text(
                      'Cambiar Contraseña',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StartScreen()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFAA1D1D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text(
                      'Cerrar Sesión',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
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

class UpdateInfoScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const UpdateInfoScreen({Key? key, required this.userData}) : super(key: key);

  @override
  _UpdateInfoScreenState createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userData['name'];
    _surnameController.text = widget.userData['surname'];
    _phoneController.text = widget.userData['numberCellphone'];
    _emailController.text = widget.userData['email'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar Información'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombres'),
            ),
            TextField(
              controller: _surnameController,
              decoration: const InputDecoration(labelText: 'Apellidos'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Teléfono'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> updatedData = {
                  'name': _nameController.text,
                  'surname': _surnameController.text,
                  'numberCellphone': _phoneController.text,
                  'email': _emailController.text,
                };

                try {
                  await UserService.updateUser(
                      widget.userData['userId'], updatedData);
                  Navigator.pop(context);
                } catch (e) {
                  print('Failed to update user: $e');
                }
              },
              child: const Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
