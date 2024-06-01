import 'package:flutter/material.dart';
import 'cart.dart'; 
import 'account.dart'; 
import 'search.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabTapped;
  final BuildContext context; 

  const CustomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabTapped,
    required this.context, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: const BoxDecoration(color:  Color.fromARGB(255, 236, 236, 236)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildNavBarItem('assets/homeIcon.png', 'Inicio', 0),
            buildNavBarItem('assets/homeIcon.png', 'Buscar', 1), // Nuevo ícono
            buildNavBarItem('assets/carIcon.png', 'Carrito', 2),
            buildNavBarItem('assets/accountIcon.png', 'Cuenta', 3),
          ],
        ),
      ),
    );
  }

  Expanded buildNavBarItem(String iconPath, String text, int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
        if (index == 1) { 
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchScreen()),
          );
        } else if  (index == 2) {
            
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          } else if (index == 3) {
         
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AccountScreen()),
            );
          } else {
            onTabTapped(index);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              height: 24,
            ),
            const SizedBox(height: 4.0),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: selectedIndex == index ? const Color.fromARGB(255, 175, 35, 35) : const Color(0xFF6A6A6A),
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 0.11,
                letterSpacing: 0.50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
