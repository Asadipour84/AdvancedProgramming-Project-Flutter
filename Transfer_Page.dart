import 'package:first_part_authentication/Transfer.dart';
import 'package:flutter/material.dart';
import 'Transactions_List_Pages.dart' ;
import 'Advance_Search_Page.dart' ;
import 'Transaction_Categories_Page.dart' ;
class TransferPage extends StatelessWidget {
  const TransferPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
        backgroundColor: const Color.fromARGB(255, 175, 51, 51),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _TransferIcon(
              icon: Icons.list_alt,
              title: 'View full list of transactions',
              onTap : (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionListPage(),),);
              } ,
            ),
            const SizedBox(height: 25),
            _TransferIcon(
              icon: Icons.search,
              title: 'Advanced Search',
              onTap : (){
                Navigator.push(context , MaterialPageRoute(builder: (context) => const AdvancedSearchPage(),),) ;
              },
            ),
            const SizedBox(height: 25),
            _TransferIcon(
              icon: Icons.category,
              title: 'Transaction Categories',
              onTap: (){
                Navigator.push(context , MaterialPageRoute(builder: (context) => TransactionCategoriesPage(transactions: Bank_Transfer.generate_random_transactions()),),);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TransferIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _TransferIcon({
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
            child: Icon(
              icon,
              size: 36,
              color: Colors.red.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
