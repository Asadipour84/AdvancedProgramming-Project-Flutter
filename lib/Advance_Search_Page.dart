import 'package:flutter/material.dart';
import 'Transfer.dart';
class AdvancedSearchPage extends StatefulWidget {
  const AdvancedSearchPage({super.key});

  @override
  State<AdvancedSearchPage> createState() => _AdvancedSearchPageState();
}

class _AdvancedSearchPageState extends State<AdvancedSearchPage> {
  final List<Bank_Transfer> _allTransactions =
      Bank_Transfer.generate_random_transactions();

  List<Bank_Transfer> _filteredTransactions = [];

  Type_Of_Transfer? _selectedType;
  double? _minAmount;
  double? _maxAmount;
  DateTime? _fromDate;
  DateTime? _toDate;
  Categories_Of_Transfer? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _filteredTransactions = _allTransactions;
  }

  void _applyFilters() {
    setState(() {
      _filteredTransactions = _allTransactions.where((tx) {
        final matchType =
            _selectedType == null || tx.type_of_transfer == _selectedType;

        final matchMin =
            _minAmount == null || tx.amount >= _minAmount!;

        final matchMax =
            _maxAmount == null || tx.amount <= _maxAmount!;

        final matchFrom =
            _fromDate == null || tx.dateTime.isAfter(_fromDate!);

        final matchTo =
            _toDate == null || tx.dateTime.isBefore(_toDate!);

        final matchCategory =
           _selectedCategory == null || tx.categories_of_transfer == _selectedCategory ;
        return matchType && matchMin && matchMax && matchFrom && matchTo && matchCategory ;
      }).toList();
    });
  }

  Future<void> _pickDate(bool isFrom) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        isFrom ? _fromDate = picked : _toDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Search', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 175, 51, 51),
        // backgroundColor: EditProfilePage.kAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          //Filters
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                DropdownButtonFormField<Categories_Of_Transfer>(
                 value: _selectedCategory,
                 hint: const Text('Category'),
                 items: Categories_Of_Transfer.values.map((cat) {
                 return DropdownMenuItem(
                 value: cat,
                 child: Text(cat.name),
                 );
                }).toList(),
                 onChanged: (value) {
                  setState(() => _selectedCategory = value);
                },
                  ),
                    const SizedBox(height: 10),
                DropdownButtonFormField<Type_Of_Transfer>(
                  value: _selectedType,
                  hint: const Text('Transaction Type'),
                  items: const [
                    DropdownMenuItem(
                      value: Type_Of_Transfer.DEPOSIT,
                      child: Text('Deposit'),
                    ),
                    DropdownMenuItem(
                      value: Type_Of_Transfer.WITHDRAW,
                      child: Text('Withdraw'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedType = value);
                  },
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: 'Min Amount'),
                        onChanged: (value) =>
                            _minAmount = double.tryParse(value),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: 'Max Amount'),
                        onChanged: (value) =>
                            _maxAmount = double.tryParse(value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _pickDate(true),
                        child: Text(
                          _fromDate == null
                              ? 'From Date'
                              : '${_fromDate!.year}/${_fromDate!.month}/${_fromDate!.day}',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _pickDate(false),
                        child: Text(
                          _toDate == null
                              ? 'To Date'
                              : '${_toDate!.year}/${_toDate!.month}/${_toDate!.day}',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: _applyFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Apply Filters', style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),

          const Divider(),

          //Results
          Expanded(
            child: _filteredTransactions.isEmpty
                ? const Center(child: Text('No transactions found'))
                : ListView.builder(
                    itemCount: _filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final tx = _filteredTransactions[index];
                      final isDeposit =
                          tx.type_of_transfer == Type_Of_Transfer.DEPOSIT;

                      return ListTile(
                        leading: Icon(
                          isDeposit
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          color: isDeposit ? Colors.green : Colors.red,
                        ),
                        title: Text(tx.description),
                        subtitle: Text(
                            '${tx.dateTime.year}/${tx.dateTime.month}/${tx.dateTime.day} • ${tx.categories_of_transfer.name}'),
                        trailing: Text(
                          tx.amount.toStringAsFixed(0),
                          style: TextStyle(
                            color:
                                isDeposit ? Colors.green : Colors.red,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}