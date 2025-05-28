import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF6FA), // light blue background
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

              // Motivational Text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  '"Find the support you need, connect with the right therapist, and start your journey toward healing because everyone deserves a safe space to talk."',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'ScriptMTBold',
                    color: Color(0xFF0891B2),
                    fontSize: 18,
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
              ),
              const SizedBox(height: 30),

              _buildInputField('Full Name'),
              const SizedBox(height: 12),

              _buildGenderDropdown(),
              const SizedBox(height: 12),

              _buildInputField('Age'),
              const SizedBox(height: 12),

              _buildMaritalStatusDropdown(),
              const SizedBox(height: 12),

              _buildInputField('Email'),
              const SizedBox(height: 12),

              _buildInputField('Phone Number'),
              const SizedBox(height: 12),

              _buildInputField('Password', obscureText: true),
              const SizedBox(height: 12),

              _buildInputField('Confirm Password', obscureText: true),
              const SizedBox(height: 24),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login'); // Go back to login
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F2937),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      'Log In',
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

  Widget _buildInputField(String hint, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      style: const TextStyle(),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(),
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

  Widget _buildGenderDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(border: InputBorder.none),
        hint: const Text('Gender', style: TextStyle()),
        items: const [
          DropdownMenuItem(value: 'Male', child: Text('Male')),
          DropdownMenuItem(value: 'Female', child: Text('Female')),
        ],
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildMaritalStatusDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(border: InputBorder.none),
        hint: const Text('Marital Status', style: TextStyle()),
        items: const [
          DropdownMenuItem(value: 'Single', child: Text('Single')),
          DropdownMenuItem(value: 'Married', child: Text('Married')),
          DropdownMenuItem(value: 'Divorced', child: Text('Divorced')),
          DropdownMenuItem(value: 'Widowed', child: Text('Widowed')),
        ],
        onChanged: (value) {},
      ),
    );
  }
}
