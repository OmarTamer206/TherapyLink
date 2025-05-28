import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController(text: "Emily Mark");
  final TextEditingController _dobController = TextEditingController(text: "9 / 1 / 2005");
  final TextEditingController _phoneController = TextEditingController(text: "010-5670-3248");
  final TextEditingController _emailController = TextEditingController(text: "Emilymark@gmail.com");
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String _maritalStatus = 'Single';
  String _gender = 'Female';
  final List<String> _maritalStatusOptions = ['Single', 'Married', 'Divorced', 'Widowed'];
  final List<String> _genderOptions = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F3F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/profile.jpg'), // Replace with NetworkImage if needed
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildInputField(Icons.person_outline, 'Name', _nameController),
                  _buildInputField(Icons.calendar_today_outlined, 'Date of Birth', _dobController),
                  _buildDropdownField(Icons.group_outlined, 'Marital Status', _maritalStatus, _maritalStatusOptions, (value) {
                    setState(() {
                      _maritalStatus = value!;
                    });
                  }),
                  _buildDropdownField(Icons.accessibility, 'Gender', _gender, _genderOptions, (value) {
                    setState(() {
                      _gender = value!;
                    });
                  }),
                  _buildInputField(Icons.phone_outlined, 'Phone Number', _phoneController),
                  _buildInputField(Icons.email_outlined, 'Email', _emailController),
                  _buildInputField(Icons.lock_outline, 'Password', _passwordController, obscureText: true),
                  _buildInputField(Icons.lock_outline, 'Confirm Password', _confirmPasswordController, obscureText: true),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F2937),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                // Handle confirm action
              },
              child: const Text(
                'Confirm',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(IconData icon, String label, TextEditingController controller,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color:Color(0xFF1F2937)),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                hintText: label,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal), // Same color as icon
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(IconData icon, String label, String value, List<String> options, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF1F2937)),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: value,
              decoration: const InputDecoration(border: UnderlineInputBorder()),
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}