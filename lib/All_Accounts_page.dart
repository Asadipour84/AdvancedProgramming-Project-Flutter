import 'dart:math';
import 'package:finalproject/Account_Icon_Page.dart';
import 'package:flutter/material.dart';
import 'Account_detail_page.dart';

/// If you already have an Account model, REMOVE this class
/// and adjust the field names in the code below to match yours.
class allAccount_type {
  final String accountNumber;
  final String cardNumber;
  final double balance;
  final String type; // e.g. "Savings", "Current", "Student"

  allAccount_type({
    required this.accountNumber,
    required this.cardNumber,
    required this.balance,
    required this.type,
  });
}

class AllAccountsPage extends StatefulWidget {
  final String firstName;
  final String lastName;

  /// You can pass accounts from HomePage if you want.
  /// If you don't pass, we generate fake accounts.
  final List<allAccount_type>? initialAccounts;

  const AllAccountsPage({
    super.key,
    required this.firstName,
    required this.lastName,
    this.initialAccounts,
  });

  @override
  State<AllAccountsPage> createState() => _AllAccountsPageState();
}

class _AllAccountsPageState extends State<AllAccountsPage> {
  static const Color kAccent = Color.fromARGB(255, 175, 51, 51);

  final TextEditingController _searchCtrl = TextEditingController();

  late List<allAccount_type> _accounts;
  String _query = "";

  // Filters
  String? _typeFilter; // null = all types

  @override
  void initState() {
    super.initState();
    _accounts = widget.initialAccounts ?? _generateFakeAccounts();
    _searchCtrl.addListener(() {
      setState(() => _query = _searchCtrl.text.trim());
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<allAccount_type> get _filteredAccounts {
    final q = _query.toLowerCase();

    return _accounts.where((a) {
      final matchesQuery = q.isEmpty ||
          a.accountNumber.toLowerCase().contains(q) ||
          a.cardNumber.toLowerCase().contains(q) ||
          a.type.toLowerCase().contains(q);

      final matchesType = _typeFilter == null || a.type == _typeFilter;

      return matchesQuery && matchesType;
    }).toList();
  }

  void _openFilterSheet() async {
    final selected = await showModalBottomSheet<String?>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final types = _accounts.map((e) => e.type).toSet().toList()..sort();
        String? temp = _typeFilter;

        return StatefulBuilder(
          builder: (context, setLocal) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Filter",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(height: 12),

                  DropdownButtonFormField<String?>(
                    value: temp,
                    decoration: const InputDecoration(
                      labelText: "Account Type",
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text("All types"),
                      ),
                      ...types.map(
                            (t) => DropdownMenuItem<String?>(
                          value: t,
                          child: Text(t),
                        ),
                      )
                    ],
                    onChanged: (v) => setLocal(() => temp = v),
                  ),

                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context, null),
                          child: const Text("Clear"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kAccent,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context, temp),
                          child: const Text("Apply"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );

    // If user closed sheet, selected can be null OR a value; we treat null as "clear"
    setState(() => _typeFilter = selected);
  }

  void _addNewAccount() {
    setState(() {
      _accounts.insert(0, _generateOneAccount());
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("New account added")),
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

  @override
  Widget build(BuildContext context) {
    final shown = _filteredAccounts;

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Accounts", style: TextStyle(color: Colors.white)),
        backgroundColor: kAccent,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kAccent,
        foregroundColor: Colors.white,
        onPressed: _addNewAccount,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1) Top title (name + last name)
            Text(
              "${widget.firstName} ${widget.lastName}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 16),

            // 2) Search bar + filter icon aligned
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    decoration: InputDecoration(
                      hintText: "Search by type / account / card...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: _openFilterSheet,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Icon(
                      Icons.filter_list,
                      color: _typeFilter == null ? Colors.grey[700] : kAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 3) Ordered list of accounts
            Expanded(
              child: shown.isEmpty
                  ? const Center(child: Text("No accounts found."))
                  : ListView.separated(
                itemCount: shown.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final acc = shown[index];

                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red.shade100,
                        child: Icon(Icons.account_balance, color: kAccent),
                      ),
                      title: Text(
                        "Account: ${acc.accountNumber}",
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text("Type: ${acc.type}"),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("Balance",
                              style: TextStyle(fontSize: 12, color: Colors.grey)),
                          Text(
                            "${_formatMoney(acc.balance)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AccDetailPage(account: acc),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------
  // Fake data generators
  // -------------------------
  List<allAccount_type> _generateFakeAccounts() {
    return List.generate(5, (_) => _generateOneAccount());
  }

  allAccount_type _generateOneAccount() {
    final rand = Random();
    final types = ["Savings", "Current", "Student"];
    final type = types[rand.nextInt(types.length)];

    String digits(int len) =>
        List.generate(len, (_) => rand.nextInt(10)).join();

    return allAccount_type(
      accountNumber: "IR-${digits(10)}",
      cardNumber: digits(16),
      balance: (rand.nextInt(90000000) + 1000000).toDouble(),
      type: type,
    );
  }
}
