import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'home_page.dart';
import 'Account_Icon.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Authentication auth = Authentication();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  void handleLogin() {
    String code = codeController.text.trim();
    String name = nameController.text.trim();
    String lastName = lastNameController.text.trim();

    if (auth.Exsit(code) || (name.isNotEmpty && lastName.isNotEmpty)) {
      if (!auth.Exsit(code) && name.isNotEmpty && lastName.isNotEmpty) {
        auth.addUser(name, lastName, code);
      }
      String displayName = name.isNotEmpty
          ? name
          : auth.users.firstWhere((u) => u.national_code == code).name;
          final Account myAccount = Account.random();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomePage(userName: displayName, account: myAccount),
        ),
      );
      codeController.clear();
      nameController.clear();
      lastNameController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Enter Name and Last Name to Register.'),
          backgroundColor: Color.fromARGB(255, 175, 51, 51),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: screenSize.width * 0.9,
            height: screenSize.height * 0.9,
            padding: const EdgeInsets.all(25),
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
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login / Register',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 175, 51, 51),
                  ),
                ),
                const SizedBox(height: 25),
                _buildTextField(codeController, 'National Code', TextInputType.number),
                const SizedBox(height: 15),
                _buildTextField(nameController, 'Name', TextInputType.text),
                const SizedBox(height: 15),
                _buildTextField(lastNameController, 'Last Name', TextInputType.text),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 175, 51, 51),
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Next Page',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, TextInputType type) {
    return TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 175, 51, 51), width: 2),
        ),
      ),
    );
  }
}
