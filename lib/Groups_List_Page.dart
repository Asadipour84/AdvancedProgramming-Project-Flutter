import 'package:flutter/material.dart';
import 'Groups.dart';
import 'Groups_Services.dart';

class MyGroupsPage extends StatelessWidget {
  const MyGroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Groups> groups = GroupService.generateRandomGroups();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Groups'),
        backgroundColor: const Color.fromARGB(255, 175, 51, 51),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: groups.length,
        itemBuilder: (context, index) {
          final group = groups[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.group, color: Colors.red),
              title: Text(group.name),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${group.name} selected'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
