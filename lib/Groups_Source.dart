import 'Groups.dart';

class GroupRepository {
  static final List<Groups> _groups = [];

  static List<Groups> get groups => _groups;

  static void addGroup(String name) {
    _groups.add(Groups(name: name));
  }
}
