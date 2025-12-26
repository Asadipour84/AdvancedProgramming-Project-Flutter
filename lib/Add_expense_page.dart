import 'package:flutter/material.dart';
// import 'Groups_detail_page.dart';
import 'Expense.dart';

class AddExpensePage extends StatefulWidget {
  final List<String> members;

  const AddExpensePage({super.key, required this.members});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _amountController = TextEditingController();
  String? _selectedMember;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const kAccent = Color.fromARGB(255, 175, 51, 51);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense"),
        backgroundColor: kAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              initialValue: _selectedMember,
              items: widget.members
                  .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedMember = v),
              decoration: const InputDecoration(labelText: "Member who paid"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Amount"),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  final amount = double.tryParse(_amountController.text.trim());
                  if (_selectedMember == null || amount == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select a member and enter a valid amount")),
                    );
                    return;
                  }

                  Navigator.pop(context, Expense(memberName: _selectedMember!, amount: amount));
                },
                child: const Text("Save", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
