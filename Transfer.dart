import 'dart:math' ;
enum Type_Of_Transfer {
  DEPOSIT , WITHDRAW ;
}
class Bank_Transfer {
  final String ID ;
  final Type_Of_Transfer type_of_transfer ;
  final double amount ;
  final DateTime dateTime ;
  final String description ;
  Bank_Transfer({required this.ID , required this.type_of_transfer , required this.amount , required this.dateTime , required this.description}) ;
  static Bank_Transfer random(){
    final rand = Random() ;
    final isDeposite = rand.nextBool() ;
    return Bank_Transfer(ID: rand.nextInt(100000).toString(), type_of_transfer: isDeposite ? Type_Of_Transfer.DEPOSIT : Type_Of_Transfer.WITHDRAW, amount: (rand.nextInt(900) + 100) * 1000, dateTime: DateTime.now().subtract(Duration(days: rand.nextInt(10)),), description: isDeposite? 'Deposite' : 'Withdrawal' ,) ;
  }
  static List <Bank_Transfer> generate_random_transactions(){
    return List.generate(10 , (_) => Bank_Transfer.random()) ..sort((a , b) => b.dateTime.compareTo(a.dateTime)) ;
  }
}