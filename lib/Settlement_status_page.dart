import 'package:flutter/material.dart';
import 'Groups.dart';
import 'Expense.dart';

class SettlementStatusPage extends StatelessWidget {
  final Groups group;
  final List<Expense> expenses;

  // who is the currently logged-in user (fake for now)
  final String currentUserName;

  const SettlementStatusPage({
    super.key,
    required this.group,
    required this.expenses,
    required this.currentUserName,
  });

  Map<String, double> _calculateNetBalances() {
    // simplest fair split:
    // total / membersCount is each person's share
    // payer gets +credit, everyone effectively owes their share
    final balances = <String, double>{};
    for (final m in group.members) {
      balances[m] = 0;
    }
    if (group.members.isEmpty) return balances;

    final total = expenses.fold<double>(0, (sum, e) => sum + e.amount);
    final share = total / group.members.length;

    // Everyone owes their share => -share
    for (final m in group.members) {
      balances[m] = (balances[m] ?? 0) - share;
    }

    // Payers paid money => +amount
    for (final e in expenses) {
      balances[e.memberName] = (balances[e.memberName] ?? 0) + e.amount;
    }

    return balances;
  }

  @override
  Widget build(BuildContext context) {
    const kAccent = Color.fromARGB(255, 175, 51, 51);

    final balances = _calculateNetBalances();

    // if current user balance is negative => they owe money
    final currentBalance = balances[currentUserName] ?? 0;
    final needsToSettle = currentBalance < -0.01;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settlement Status"),
        backgroundColor: kAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: balances.entries.map((entry) {
                  final name = entry.key;
                  final value = entry.value;
                  final sign = value >= 0 ? "+" : "-";
                  final absValue = value.abs().toStringAsFixed(0);

                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const Icon(Icons.person, color: kAccent),
                      title: Text(name),
                      trailing: Text(
                        "$sign $absValue",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: value >= 0 ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            if (needsToSettle) ...[
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Settle debt clicked (connect to payment later)")),
                    );
                  },
                  child: const Text(
                    "Settle Debt",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
