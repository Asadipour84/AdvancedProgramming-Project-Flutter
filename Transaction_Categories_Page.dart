import 'package:flutter/material.dart';
import 'Transfer.dart';
class TransactionCategoriesPage extends StatelessWidget {
  final List<Bank_Transfer> transactions;

  const TransactionCategoriesPage({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final Map<Categories_Of_Transfer, int> categoryCounts = {};
    for (var cat in Categories_Of_Transfer.values) {
      categoryCounts[cat] =
          transactions.where((tx) => tx.categories_of_transfer == cat).length;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Categories', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 175, 51, 51),
      ),
      body: ListView.builder(
        itemCount: Categories_Of_Transfer.values.length,
        itemBuilder: (context, index) {
          final cat = Categories_Of_Transfer.values[index];
          final count = categoryCounts[cat] ?? 0;

          return ListTile(
            leading: const Icon(Icons.category, color: Colors.red),
            title: Text(cat.name),
            trailing: Text('$count'),
            onTap: () {
              final filtered = transactions
                  .where((tx) => tx.categories_of_transfer == cat)
                  .toList();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransactionListPageFiltered(
                    filteredTransactions: filtered,
                    category: cat,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
class TransactionListPageFiltered extends StatelessWidget {
  final List<Bank_Transfer> filteredTransactions;
  final Categories_Of_Transfer category;

  const TransactionListPageFiltered(
      {super.key, required this.filteredTransactions, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions: ${category.name}', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 175, 51, 51),
      ),
      body: filteredTransactions.isEmpty
          ? const Center(child: Text('No transactions found'))
          : ListView.builder(
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                final tx = filteredTransactions[index];
                final isDeposit = tx.type_of_transfer == Type_Of_Transfer.DEPOSIT;

                return ListTile(
                  leading: Icon(
                    isDeposit ? Icons.arrow_downward : Icons.arrow_upward,
                    color: isDeposit ? Colors.green : Colors.red,
                  ),
                  title: Text(tx.description),
                  subtitle: Text(
                      '${tx.dateTime.year}/${tx.dateTime.month}/${tx.dateTime.day} • ${tx.categories_of_transfer.name}'),
                  trailing: Text(
                    tx.amount.toStringAsFixed(0),
                    style: TextStyle(
                      color: isDeposit ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
    );
  }
}