import 'package:first_part_authentication/Groups_List_Page.dart';
import 'package:flutter/material.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  void _showComingSoon(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title - Compelete Soon'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups'),
        backgroundColor: const Color.fromARGB(255, 175, 51, 51),
      ),
      body: Center(
        child: Wrap(
          spacing: 40,
          runSpacing: 30,
          alignment: WrapAlignment.center,
          children: [
            _GroupIcon(
              icon: Icons.groups,
              title: 'My Groups',
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MyGroupsPage(),),);
              },
            ),
            _GroupIcon(
              icon: Icons.add_circle,
              title: 'Create Group',
              onTap: () => _showComingSoon(context, 'Create Group'),
            ),
            _GroupIcon(
              icon: Icons.person_add,
              title: 'Add Member',
              onTap: () => _showComingSoon(context, 'Add Member'),
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _GroupIcon({
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
            child: Icon(icon, size: 36, color: Colors.red.shade700),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
