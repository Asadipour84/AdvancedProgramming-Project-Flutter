// lib/main.dart
import 'package:flutter/material.dart';
import 'Login_Page.dart' ;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank Login',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 175, 51, 51),
      ),
      debugShowCheckedModeBanner: false,
      home: Login_Page(),
    );
  }
}
