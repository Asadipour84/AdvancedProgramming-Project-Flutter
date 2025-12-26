import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final String userName;

  // Read-only fields you want to show
  final String? nationalCode;
  final String? firstName;
  final String? lastName;

  // Optional: previously saved image path (local file path)
  final String? initialImagePath;

  const EditProfilePage({
    super.key,
    required this.userName,
    this.nationalCode,
    this.firstName,
    this.lastName,
    this.initialImagePath,
  });

  static const Color kAccent = Color.fromARGB(255, 175, 51, 51);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _picker = ImagePicker();

  late final TextEditingController _userNameController;

  File? _pickedImageFile; // NEW selected image
  File? _initialImageFile; // previous image (if any)

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController(text: widget.userName);

    if (widget.initialImagePath != null && widget.initialImagePath!.trim().isNotEmpty) {
      final f = File(widget.initialImagePath!);
      if (f.existsSync()) _initialImageFile = f;
    }
  }

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  Future<void> _pickFromGallery() async {
    final XFile? x = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1200,
    );
    if (x == null) return;

    setState(() {
      _pickedImageFile = File(x.path);
    });
  }

  Future<void> _pickFromCamera() async {
    final XFile? x = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
      maxWidth: 1200,
    );
    if (x == null) return;

    setState(() {
      _pickedImageFile = File(x.path);
    });
  }

  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Change profile picture",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: const Text("Choose from gallery"),
                  onTap: () async {
                    Navigator.pop(context);
                    await _pickFromGallery();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera_outlined),
                  title: const Text("Take a photo"),
                  onTap: () async {
                    Navigator.pop(context);
                    await _pickFromCamera();
                  },
                ),
                if (_pickedImageFile != null || _initialImageFile != null)
                  ListTile(
                    leading: const Icon(Icons.delete_outline),
                    title: const Text("Remove photo"),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _pickedImageFile = null;
                        _initialImageFile = null;
                      });
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveAndPop() {
    final newUserName = _userNameController.text.trim();
    if (newUserName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Username cannot be empty"),
          backgroundColor: EditProfilePage.kAccent,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Return results to previous page
    Navigator.pop(context, {
      "userName": newUserName,
      "imagePath": _pickedImageFile?.path ?? _initialImageFile?.path,
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardWidth = size.width * 0.92;

    final displayImage = _pickedImageFile ?? _initialImageFile;
    final initials = _initials(widget.userName);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: EditProfilePage.kAccent,
        foregroundColor: Colors.white,
        title: const Text("Edit Profile"),
        centerTitle: true,
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
                  // Avatar
                  GestureDetector(
                    onTap: _showImagePickerSheet,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: EditProfilePage.kAccent,
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 46,
                            backgroundColor: Colors.grey[100],
                            backgroundImage: displayImage != null ? FileImage(displayImage) : null,
                            child: displayImage == null
                                ? Text(
                              initials,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                color: EditProfilePage.kAccent,
                              ),
                            )
                                : null,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: EditProfilePage.kAccent,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(Icons.edit, color: Colors.white, size: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Fields
                  _field(
                    controller: _userNameController,
                    label: "Username",
                    readOnly: false,
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 12),

                  _readonlyField(
                    label: "First Name",
                    value: widget.firstName ?? "—",
                    icon: Icons.badge_outlined,
                  ),
                  const SizedBox(height: 12),

                  _readonlyField(
                    label: "Last Name",
                    value: widget.lastName ?? "—",
                    icon: Icons.badge_outlined,
                  ),
                  const SizedBox(height: 12),

                  _readonlyField(
                    label: "National Code",
                    value: widget.nationalCode ?? "—",
                    icon: Icons.verified_user_outlined,
                  ),

                  const SizedBox(height: 18),

                  // Save button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveAndPop,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: EditProfilePage.kAccent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: EditProfilePage.kAccent,
                        side: const BorderSide(color: EditProfilePage.kAccent, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Cancel",
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

  Widget _readonlyField({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return TextField(
      readOnly: true,
      controller: TextEditingController(text: value),
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: EditProfilePage.kAccent, width: 2),
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required bool readOnly,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: EditProfilePage.kAccent, width: 2),
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r"\s+")).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return "?";
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }
}
