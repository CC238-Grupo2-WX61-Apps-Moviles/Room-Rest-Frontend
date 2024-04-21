import 'package:flutter/material.dart';
import 'package:akira_mobile/screens/start.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AKIRA',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 88, 88, 88),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const StartScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}