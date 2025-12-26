import 'dart:io';
import 'package:flutter/material.dart';
import 'Account_Icon.dart';
import 'Login_Page.dart';
import 'Edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  final String userName;
  final String? nationalCode;
  final Account account;

  const ProfilePage({
    super.key,
    required this.userName,
    required this.account,
    this.nationalCode,
  });

  static const Color kAccent = Color.fromARGB(255, 175, 51, 51);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _userName;
  String? _imagePath; // saved profile image path (from edit page)

  @override
  void initState() {
    super.initState();
    _userName = widget.userName;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardWidth = size.width * 0.92;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: ProfilePage.kAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Container(
              width: cardWidth,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _Header(
                    userName: _userName,
                    nationalCode: widget.nationalCode,
                    imagePath: _imagePath,
                  ),
                  const SizedBox(height: 18),

                  const _SectionTitle(title: "User"),
                  const SizedBox(height: 10),
                  const _InfoTile(icon: Icons.account_circle, label: "Name", value: "value"),
                  const _InfoTile(icon: Icons.account_box_outlined, label: "LastName", value: "value"),

                  const SizedBox(height: 18),
                  const _SectionTitle(title: "Account"),
                  const SizedBox(height: 10),

                  _InfoTile(
                    icon: Icons.account_balance_outlined,
                    label: "Account Number",
                    value: widget.account.Account_Number,
                  ),
                  _InfoTile(
                    icon: Icons.credit_card_outlined,
                    label: "Card Number",
                    value: _formatCard(widget.account.Card_Number),
                  ),
                  _InfoTile(
                    icon: Icons.wallet_outlined,
                    label: "Balance",
                    value: _formatMoney(widget.account.Balance),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditProfilePage(
                              userName: _userName,
                              nationalCode: widget.nationalCode,
                              firstName: "name",
                              lastName: "last name",
                              initialImagePath: _imagePath,
                            ),
                          ),
                        );

                        // expecting: {"userName": "...", "imagePath": "..."}
                        if (result is Map) {
                          setState(() {
                            if (result['userName'] != null) {
                              _userName = result['userName'];
                            }
                            // allow clearing image too
                            _imagePath = result['imagePath'];
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ProfilePage.kAccent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Logout'),
                            content: const Text('Are you sure you want to logout?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Logout'),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginPage()),
                                (route) => false,
                          );
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: ProfilePage.kAccent,
                        side: const BorderSide(color: ProfilePage.kAccent, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatMoney(double value) {
    final s = value.toStringAsFixed(0);
    final chars = s.split('').reversed.toList();
    final out = <String>[];
    for (int i = 0; i < chars.length; i++) {
      out.add(chars[i]);
      if ((i + 1) % 3 == 0 && i != chars.length - 1) out.add(',');
    }
    return out.reversed.join();
  }

  String _formatCard(String raw) {
    final digits = raw.replaceAll(RegExp(r'\s+'), '');
    if (digits.length != 16) return raw;
    return "${digits.substring(0, 4)} ${digits.substring(4, 8)} ${digits.substring(8, 12)} ${digits.substring(12, 16)}";
  }
}

class _Header extends StatelessWidget {
  final String userName;
  final String? nationalCode;
  final String? imagePath;

  const _Header({
    required this.userName,
    required this.nationalCode,
    required this.imagePath,
  });

  static const Color kAccent = Color.fromARGB(255, 175, 51, 51);

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath != null && imagePath!.trim().isNotEmpty;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(color: kAccent, shape: BoxShape.circle),
          child: CircleAvatar(
            radius: 44,
            backgroundColor: Colors.grey[100],
            backgroundImage: hasImage ? FileImage(File(imagePath!)) : null,
            child: hasImage
                ? null
                : Text(
              _initials(userName),
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: kAccent,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          userName,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          (nationalCode == null || nationalCode!.trim().isEmpty)
              ? "User"
              : "ID: ${nationalCode!.trim()}",
          style: TextStyle(color: Colors.grey[700], fontSize: 14),
        ),
      ],
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r"\s+")).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return "?";
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  static const Color kAccent = Color.fromARGB(255, 175, 51, 51);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: const BoxDecoration(color: kAccent, shape: BoxShape.circle)),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: kAccent),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[800]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.grey[700], fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
