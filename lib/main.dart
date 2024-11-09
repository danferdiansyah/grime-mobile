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
          seedColor: const Color(0xFF05e500), // Main green color
          primary: const Color(0xFF05e500),
          secondary: const Color(0xFF05e500),
          background: const Color(0xFF0c0c0c), // Main black background
        ),
        scaffoldBackgroundColor: const Color(0xFF0c0c0c), 
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
