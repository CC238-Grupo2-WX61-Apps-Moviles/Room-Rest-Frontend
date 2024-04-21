import 'package:flutter/material.dart';
import 'start.dart';
import 'navbar.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _selectedTabIndex = 0;

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
                        Image.asset(
                          'assets/logo.png',
                          height: 230,
                        ),
                        const SizedBox(height: 40.0),
                        const Text(
                          'Categories',
                          style: TextStyle(
                            color: Color.fromARGB(255, 58, 58, 58),
                            fontSize: 14.0,
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
    });
  }
}
