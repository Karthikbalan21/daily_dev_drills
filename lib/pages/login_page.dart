import 'package:daily_dev_drills/main.dart';
import 'package:flutter/material.dart';
import 'package:daily_dev_drills/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              const Icon(Icons.code, size: 50, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                "Daily Dev Drills",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 30),
              const Text(
                "Login",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              CustomTextField(icon: Icons.person, hint: "Username"),
              const SizedBox(height: 20),
              CustomTextField(icon: Icons.lock, hint: "Password", isPassword: true),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  testDB();
                  Navigator.pushReplacementNamed(context, '/home'); // Navigate to Home Page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/register'); // Navigate to Register Page
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
