import 'package:flutter/material.dart';
import 'dart:math';
import 'Account.dart';
class HomePage extends StatelessWidget {
  final String userName;
  const HomePage({super.key, required this.userName});
  Account _createRandomAccount() {
    final random = Random();
    String cardNumber =
        List.generate(16, (_) => random.nextInt(10).toString()).join();
    String password =
        List.generate(4, (_) => random.nextInt(10).toString()).join();
    return Account(cardNumber, password, 0.0);
  }
  void _showComingSoon(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title - Compelete Soon'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final account = _createRandomAccount();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color.fromARGB(255, 175, 51, 51),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome $userName 👋',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Account Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('Card Number: ${account.card_number}'),
                      Text('Password: ${account.Pass_Word}'),
                      const SizedBox(height: 10),
                      Text(
                        'Balance: ${account.Balance.toStringAsFixed(0)} \$',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const Text(
                'Quick Access',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              Wrap(
                spacing: 30,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _QuickIcon(
                    icon: Icons.person,
                    title: 'Profile',
                    onTap: () => _showComingSoon(context, 'Profile'),
                  ),
                  _QuickIcon(
                    icon: Icons.account_balance,
                    title: 'Accounts',
                    onTap: () => _showComingSoon(context, 'Accounts'),
                  ),
                  _QuickIcon(
                    icon: Icons.group,
                    title: 'Groups',
                    onTap: () => _showComingSoon(context, 'Groups'),
                  ),
                  _QuickIcon(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () => _showComingSoon(context, 'Settings'),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              const Text(
                'Services',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              Wrap(
                spacing: 30,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _QuickIcon(
                    icon: Icons.credit_card,
                    title: 'Card to Card',
                    onTap: () => _showComingSoon(context, 'Card to Card'),
                  ),
                  _QuickIcon(
                    icon: Icons.swap_horiz,
                    title: 'Transfer',
                    onTap: () => _showComingSoon(context, 'Transfer'),
                  ),
                  _QuickIcon(
                    icon: Icons.payment,
                    title: 'Bill Pay',
                    onTap: () => _showComingSoon(context, 'Bill Pay'),
                  ),
                  _QuickIcon(
                    icon: Icons.school,
                    title: 'Education',
                    onTap: () => _showComingSoon(context, 'Education'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _QuickIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _QuickIcon({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.red.shade100,
            child: Icon(icon, color: Colors.red.shade700, size: 30),
          ),
          const SizedBox(height: 6),
          Text(title),
        ],
      ),
    );
  }
}
