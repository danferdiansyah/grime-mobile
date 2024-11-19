import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:grime/screens/menu.dart';
import 'package:grime/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => CookieRequest(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Grime',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF05e500),
                primary: const Color(0xFF05e500),
                secondary: const Color(0xFF05e500),
                background: const Color(0xFF0c0c0c),
              ),
              scaffoldBackgroundColor: const Color(0xFF0c0c0c),
              useMaterial3: true,
            ),
            home: const LoginPage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grime'),
      ),
      body: const Center(
        child: Text('Welcome to Grime!'),
      ),
    );
  }
}