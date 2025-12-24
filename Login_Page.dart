import 'package:flutter/material.dart';
import 'Authentication.dart' ;
class Login_Page extends StatefulWidget {
  @override
  State<Login_Page> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login_Page> {
  final Authentication auth = Authentication();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  void handleLogin() {
    String code = codeController.text.trim();
    String name = nameController.text.trim();
    String lastName = lastNameController.text.trim();

    String message;
    if (auth.Exsit(code)) {
      message = 'Log in Successfully! Welcome to our Bank.';
    } else {
      if (name.isNotEmpty && lastName.isNotEmpty) {
        auth.addUser(name, lastName, code);
        message = 'Register Successfully! Welcome.';
      } else {
        message = 'Please Enter Name and Last Name to Register.';
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color.fromARGB(255, 175, 51, 51),
        duration: Duration(seconds: 2),
      ),
    );

    codeController.clear();
    nameController.clear();
    lastNameController.clear();
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
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
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
                Text(
                  'Login / Register',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 175, 51, 51),
                  ),
                ),
                SizedBox(height: 25),
                _buildTextField(codeController, 'National Code', TextInputType.number),
                SizedBox(height: 15),
                _buildTextField(nameController, 'Name', TextInputType.text),
                SizedBox(height: 15),
                _buildTextField(lastNameController, 'Last Name', TextInputType.text),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 50, 175, 224),
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
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

  Widget _buildTextField(TextEditingController controller, String label, TextInputType type) {
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
          borderSide: BorderSide(color: const Color.fromARGB(255, 175, 51, 51), width: 2),
        ),
      ),
    );
  }
}
