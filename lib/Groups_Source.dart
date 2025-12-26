import 'Groups.dart';

class Group_Source {
  static final List<Groups> _groups = [];

  static List<Groups> get groups => _groups;

  static void addGroup(String name) {
    _groups.add(Groups(name: name));
  }

  static void addMember({
    required Groups group,
    required String memberName,
  }) {
    group.members.add(memberName);
  }
}
