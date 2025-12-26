import 'dart:math';
import 'Groups.dart';

class GroupService {
  static final Random _rand = Random();

  static final List<String> _groupNames = [
    'Water & Electricity Bills',
    'Gas Payment Group',
    'Education Expenses',
    'Installment Payments',
    'Family Expenses',
    'University Fees',
    'Internet & Phone Bills',
  ];

  static final List<String> _membersPool = [
    'Ali Rezaei',
    'Sara Ahmadi',
    'Mohammad Karimi',
    'Neda Hosseini',
    'Reza Mohammadi',
    'Fatemeh Azadi',
    'Amir Jalali',
    'Maryam Tavakoli',
    'Hossein Ghasemi',
    'Elham Ebrahimi',
  ];

  static List<Groups> generateRandomGroups() {
    final int groupCount = _rand.nextInt(3) + 3; // 3–5 groups
    final shuffledGroups = List<String>.from(_groupNames)..shuffle();

    return List.generate(groupCount, (index) {
      // 👇 generate members HERE, alongside the group
      final int memberCount = _rand.nextInt(4) + 2; // 2–5 members
      final shuffledMembers = List<String>.from(_membersPool)..shuffle();
      final members = shuffledMembers.take(memberCount).toList();

      return Groups(
        name: shuffledGroups[index],
        members: members,
      );
    });
  }
}
