import 'dart:math';
import 'Groups.dart';

class GroupService {
  static final List<String> _groupNames = [
    'Water & Electricity Bills',
    'Gas Payment Group',
    'Education Expenses',
    'Installment Payments',
    'Family Expenses',
    'University Fees',
    'Internet & Phone Bills',
  ];

  static List<Groups> generateRandomGroups() {
    final rand = Random();
    final count = rand.nextInt(3) + 3; 

    final shuffled = List<String>.from(_groupNames)..shuffle();

    return List.generate(
      count,
      (index) => Groups(name: shuffled[index]),
    );
  }
}
