import 'package:finalproject/All_Accounts_page.dart';
import 'package:flutter/material.dart';

class AccountDetailsPage extends StatelessWidget {
  final allAccount_type account;
  const AccountDetailsPage({super.key, required this.account});

  static const Color kAccent = Color.fromARGB(255, 175, 51, 51);

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

  String _formatCard(String raw) {
    final digits = raw.replaceAll(RegExp(r'\s+'), '');
    if (digits.length != 16) return raw;
    return "${digits.substring(0, 4)} ${digits.substring(4, 8)} ${digits.substring(8, 12)} ${digits.substring(12, 16)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Details", style: TextStyle(color: Colors.white)),
        backgroundColor: kAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _detailRow("Type", account.type),
                _detailRow("Account Number", account.accountNumber),
                _detailRow("Card Number", _formatCard(account.cardNumber)),
                _detailRow("Balance", _formatMoney(account.balance)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
