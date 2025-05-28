import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF6FA), // Light blue background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/images/therapy.png',
                height: 60,
              ),
              const SizedBox(height: 20),

              // Welcome Image
              Image.asset(
                'assets/images/welcome.png',
                height: 180,
              ),
              const SizedBox(height: 20),

              // Welcome Message with shadow and ScriptMTBold
              Text(
                '"Welcome back! Your path to clarity and support is just a conversation away."',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'ScriptMTBold',
                  color: Color(0xFF0891B2),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black26,
                      offset: Offset(2, 2),
                      
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Email
              _buildInputField('Email'),
              const SizedBox(height: 12),

              // Password
              _buildInputField('Password', obscureText: true),
              const SizedBox(height: 24),

              // Login Button without ScriptMTBold
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F2937),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Sign Up Link without ScriptMTBold
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                  fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0891B2),
                        fontWeight: FontWeight.w600,
                      ),
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

  // Input field using default font for input and placeholder
  Widget _buildInputField(String hint, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      style: const TextStyle(), // Default font
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(), // Default font
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
