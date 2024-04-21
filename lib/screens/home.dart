import 'package:flutter/material.dart';
import 'start.dart';
import 'navbar.dart';
import 'categories.dart'; // Importa tus pantallas adicionales
import 'car.dart';
import 'account.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;
  final PageController _pageController = PageController(); // Agrega el controlador de página

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
                        Expanded( // Reemplaza tu contenido actual con el PageView
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: 6, // Ajusta según la cantidad de imágenes
                            onPageChanged: _updateSelectedTab,
                            itemBuilder: (context, index) {
                              return Image.asset(
                                'assets/logo.png',
                                height: 230,
                              );
                            },
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
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedTabIndex,
        onTabTapped: _updateSelectedTab,
      ),
    );
  }

  void _updateSelectedTab(int index) {
    setState(() {
      _selectedTabIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }
}
