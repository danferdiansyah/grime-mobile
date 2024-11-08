import 'package:flutter/material.dart';
import 'package:grime/screens/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grime',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF05e500), // New green color
          primary: const Color(0xFF05e500),
          secondary: const Color(0xFF05e500),
          background: const Color(0xFF0c0c0c), // Background color as black
        ),
        scaffoldBackgroundColor: const Color(0xFF0c0c0c), // Ensure all pages have black background
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
