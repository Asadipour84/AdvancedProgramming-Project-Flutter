import 'package:finalproject/All_Accounts_page.dart';
import 'package:flutter/material.dart';
import 'Account_Icon.dart';
import 'Account_detail_page.dart';

class AccDetailPage extends StatelessWidget {
  final allAccount_type account;

  const AccDetailPage({super.key, required this.account});

  static const Color kAccent = Color.fromARGB(255, 175, 51, 51);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Account Information',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _infoBox('Account Type', account.type),
              const SizedBox(height: 14),
              _infoBox('Account Number', account.accountNumber),
              const SizedBox(height: 14),
              _infoBox('Card Number', account.cardNumber),
              const SizedBox(height: 14),
              _infoBox('Balance', '${_formatMoney(account.balance)}'),
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
          color: const Color.fromARGB(255, 200, 50, 50),
          width: 1.2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
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

  String _formatMoney(double value) {
    final s = value.toStringAsFixed(0);
    final chars = s.split('').reversed.toList();
    final out = <String>[];
    for (int i = 0; i < chars.length; i++) {
      out.add(chars[i]);
      if ((i + 1) % 3 == 0 && i != chars.length - 1) out.add(',');
    }
    return out.reversed.join();
  }

  // String _formatCard(String raw) {
  //   final digits = raw.replaceAll(RegExp(r'\s+'), '');
  //   if (digits.length != 16) return raw;
  //   return "${digits.substring(0, 4)} "
  //       "${digits.substring(4, 8)} "
  //       "${digits.substring(8, 12)} "
  //       "${digits.substring(12, 16)}";
  // }
}
