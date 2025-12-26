import 'package:flutter/material.dart';
import 'Account_Icon.dart';
class AccountPage extends StatelessWidget {
  final Account account;
  const AccountPage({super.key, required this.account});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Account Information', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 175, 51, 51),
        // backgroundColor: EditProfilePage.kAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _infoBox('Account Number', account.Account_Number),
              const SizedBox(height: 14),
              _infoBox('Card Number', account.Card_Number),
              const SizedBox(height: 14),
              _infoBox('Balance', '${account.Balance} \$'),
            ],
          ),
        ),
      ),
    );
  }
  Widget _infoBox(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 157, 17, 17),
        borderRadius: BorderRadius.circular(12), 
        border: Border.all(
            color: const Color.fromARGB(255, 200, 50, 50), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        '$title: $value',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 240, 240, 240),
        ),
      ),
    );
  }
}