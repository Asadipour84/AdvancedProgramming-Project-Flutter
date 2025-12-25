import 'dart:math';
class Account {
  final String Account_Number;
  final String Card_Number;
  double Balance;

  Account({
    required this.Account_Number,
    required this.Card_Number,
    required this.Balance,
  });
  factory Account.random() {
    final rand = Random() ;
    return Account(
      Account_Number: _generateAccountNumber(),
      Card_Number: _generateCardNumber(),
      Balance: rand.nextInt(900000) + 100000,
    );
  }

  static String _generateAccountNumber() {
    final rand = Random();
    return List.generate(10, (_) => rand.nextInt(10)).join();
  }

  static String _generateCardNumber() {
    final rand = Random();
    return List.generate(16, (_) => rand.nextInt(10)).join();
  }
}