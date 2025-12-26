import 'package:flutter/material.dart';
import 'Groups.dart';
import 'Expense.dart';
import 'Settlement_status_page.dart';
import 'Add_expense_page.dart';

class GroupDetailPage extends StatefulWidget {
  final Groups group;

  const GroupDetailPage({super.key, required this.group});

  @override
  State<GroupDetailPage> createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends State<GroupDetailPage> {
  // fake initial expenses
  late List<Expense> _expenses;

  @override
  void initState() {
    super.initState();
    _expenses = [
      Expense(memberName: widget.group.members.isNotEmpty ? widget.group.members[0] : "Member 1", amount: 120),
      Expense(memberName: widget.group.members.length > 1 ? widget.group.members[1] : "Member 2", amount: 55),
      Expense(memberName: widget.group.members.isNotEmpty ? widget.group.members.last : "Member 3", amount: 300),
    ];
  }

  @override
  Widget build(BuildContext context) {
    const kAccent = Color.fromARGB(255, 175, 51, 51);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Detail"),
        backgroundColor: kAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Group name at top
            Text(
              widget.group.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Members section
            const Text(
              "Members:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),

            SizedBox(
              height: 160,
              child: ListView.builder(
                itemCount: widget.group.members.length,
                itemBuilder: (context, index) {
                  final member = widget.group.members[index];
                  return _InfoTile(
                    icon: Icons.person,
                    title: member,
                    subtitle: "Group member",
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Expenses title + Add +
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Expenses",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
                InkWell(
                  onTap: () async {
                    final newExpense = await Navigator.push<Expense>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddExpensePage(members: widget.group.members),
                      ),
                    );

                    if (newExpense != null) {
                      setState(() {
                        _expenses.insert(0, newExpense);
                      });
                    }
                  },
                  child: const Text(
                    "add +",
                    style: TextStyle(
                      color: kAccent,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),

            Expanded(
              child: ListView.builder(
                itemCount: _expenses.length,
                itemBuilder: (context, index) {
                  final e = _expenses[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const Icon(Icons.payments_outlined, color: kAccent),
                      title: Text("${e.amount.toStringAsFixed(0)}"),
                      subtitle: Text("Paid by: ${e.memberName}"),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // Final Results button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SettlementStatusPage(
                        group: widget.group,
                        expenses: _expenses,
                        currentUserName: widget.group.members.isNotEmpty ? widget.group.members[0] : "Current User",
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Final Results",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[800]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(color: Colors.grey[700], fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
