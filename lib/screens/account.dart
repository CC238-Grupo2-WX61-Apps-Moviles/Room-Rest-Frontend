import 'package:flutter/material.dart';
import 'package:akira_mobile/screens/order_detail_screen.dart';
import 'package:akira_mobile/screens/UpdateAddress.dart';
import 'package:akira_mobile/screens/start.dart';
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
        // Asegúrate de que userData['userId'] se establezca correctamente aquí
        // Podrías imprimir para verificar que data contiene 'id' o 'userId'
        print('Fetched user data: $data');
        print(
            'User ID from data: ${data['id']}'); // Asegúrate de que 'id' sea correcto
        userData['userId'] =
            data['id']; // Asignar 'id' desde data a userData['userId']
      });
    } catch (e) {
      print('Failed to fetch user data: $e');
      // Manejar el error según sea necesario, por ejemplo, mostrando un mensaje al usuario.
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
      // Manejar el error según sea necesario.
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
      // Manejar el error según sea necesario.
    }
  }

  Future<void> deleteUser() async {
    try {
      // Verificar que userData['userId'] no sea null antes de eliminar
      if (userData['userId'] != null) {
        await UserService.deleteUser(userData['userId']);
        // Eliminación exitosa, navegar a la pantalla de inicio
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const StartScreen()),
          (route) => false,
        );
      } else {
        print('User ID is null, unable to delete user.');
        // Manejar el caso donde el ID de usuario es nulo.
      }
    } catch (e) {
      print('Failed to delete user: $e');
      // Mostrar un mensaje de error al usuario si es necesario.
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
                'Hola ${userData['name']}',
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
                              builder: (context) => UpdateAddressScreen()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
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
                      // Mostrar un diálogo de confirmación
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

                      // Si el usuario confirma la eliminación
                      if (confirmDelete == true) {
                        try {
                          // Verificar si userData['userId'] no es null antes de eliminar
                          if (userData['userId'] != null) {
                            await UserService.deleteUser(userData['userId']);
                            // Eliminación exitosa, navegar a la pantalla de inicio
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const StartScreen()),
                              (route) => false,
                            );
                          } else {
                            print('User ID is null, unable to delete user.');
                            // Aquí puedes mostrar un mensaje o realizar alguna acción adicional
                          }
                        } catch (e) {
                          // Error al eliminar el usuario
                          print('Failed to delete user: $e');
                          // Mostrar un mensaje de error al usuario si es necesario
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
                    onPressed: () {
                      // Acción para cambiar contraseña
                    },
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
                      backgroundColor:
                          const Color(0xFFAA1D1D), // Color de botón #AA1D1D
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
