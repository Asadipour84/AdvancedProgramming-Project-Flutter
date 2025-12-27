import 'package:flutter/material.dart';


class CardToCard extends StatelessWidget {
  const CardToCard({super.key});

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card To Card'),
        backgroundColor: const Color.fromARGB(255, 175, 51, 51),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Wrap(
          spacing: 40,
          runSpacing: 30,
          alignment: WrapAlignment.center,
          children: [
            //////////10 mil saghf
            _CardToCardIcon(
              icon: Icons.credit_card_outlined,
              title: "Regular",
              onTap: () => _showComingSoon( context ,"Regular card to card"),
            ),
            //////////bedune saghf - same first 4 digits card no.
            _CardToCardIcon(
              icon: Icons.account_balance_outlined,
              title: "Same Bank",
              onTap: () => _showComingSoon( context ,"Same Bank card to card"),
            ),
            ///////////bedune saghf
            _CardToCardIcon(
              icon: Icons.attach_money,
              title: "With IR",
              onTap: () => _showComingSoon( context ,"With IR card to card"),
            )
          ],
        )
        ,
      )
      ,
    );
  }
}

class _CardToCardIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _CardToCardIcon({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(60),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.red.shade100,
            child: Icon(icon, size: 36, color: Colors.red.shade700),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
