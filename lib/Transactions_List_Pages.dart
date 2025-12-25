import 'package:flutter/material.dart';
import 'Transfer.dart';

class TransactionListPage extends StatelessWidget {
  const TransactionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = Bank_Transfer.generate_random_transactions();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        backgroundColor: const Color.fromARGB(255, 175, 51, 51),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final tx = transactions[index];
          final isDeposit = tx.type_of_transfer == Type_Of_Transfer.DEPOSIT;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    isDeposit ? Colors.green.shade100 : Colors.red.shade100,
                child: Icon(
                  isDeposit ? Icons.arrow_downward : Icons.arrow_upward,
                  color: isDeposit ? Colors.green : Colors.red,
                ),
              ),
              title: Text(
                tx.description,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${tx.dateTime.year}/${tx.dateTime.month}/${tx.dateTime.day}',
              ),
              trailing: Text(
                (isDeposit ? '+' : '-') + tx.amount.toStringAsFixed(0),
                style: TextStyle(
                  color: isDeposit ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}