// lib/main.dart
import 'package:flutter/material.dart';
import 'Login_Page.dart' ;
import 'Profile_page.dart';
import 'Account_Icon.dart';

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
      // home: ProfilePage(
      //   userName: 'Test User',
      //   account: Account(
      //     Account_Number: '1234567890',
      //     Card_Number: '6037991234567890',
      //     Balance: 2500000, // 2,500,000
      //   ),
      // ),
      home: LoginPage(),
    );
  }
}
