import 'package:flutter/material.dart';
import 'Groups.dart';
import 'Groups_Source.dart';

class AddMemberPage extends StatefulWidget {
  const AddMemberPage({super.key});

  @override
  State<AddMemberPage> createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  Groups? selectedGroup;
  final TextEditingController _memberController = TextEditingController();

  void _addMember() {
    final memberName = _memberController.text.trim();

    if (selectedGroup == null || memberName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select group and enter name')),
      );
      return;
    }

    Group_Source.addMember(
      group: selectedGroup!,
      memberName: memberName,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Member added successfully')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final groups = Group_Source.groups;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Member'),
        backgroundColor: const Color.fromARGB(255, 175, 51, 51),
        // backgroundColor: EditProfilePage.kAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Select Group'),
            const SizedBox(height: 8),

            DropdownButtonFormField<Groups>(
              items: groups.map((group) {
                return DropdownMenuItem(
                  value: group,
                  child: Text(group.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedGroup = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text('Member Name'),
            const SizedBox(height: 8),

            TextField(
              controller: _memberController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter member name',
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: _addMember,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 175, 51, 51),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Add Member',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
