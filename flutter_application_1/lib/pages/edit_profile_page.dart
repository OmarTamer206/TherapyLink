import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: EditProfilePage(),
  ));
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController(text: 'Emily Mark');
  final TextEditingController _dobController = TextEditingController(text: '9/1/2005');
  final TextEditingController _phoneController = TextEditingController(text: '01056703248');
  final TextEditingController _emailController = TextEditingController(text: 'emilysmark@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: 'Password123');

  String maritalStatus = 'Single';  // Default marital status
  final List<String> statuses = ['Single', 'Married', 'Divorced', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFF0F4),
        elevation: 0,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=47'),
            ),
            const SizedBox(height: 30), 
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildTextField(_nameController, Icons.person, 'Name'),
                  const SizedBox(height: 16),
                  _buildTextField(_dobController, Icons.calendar_today, 'Date of Birth'),
                  const SizedBox(height: 16),
                  _buildDropdownField(),
                  const SizedBox(height: 16),
                  _buildTextField(_phoneController, Icons.phone, 'Phone', keyboardType: TextInputType.number),
                  const SizedBox(height: 16),
                  _buildTextField(_emailController, Icons.email, 'Email'),
                  const SizedBox(height: 16),
                  _buildTextField(_passwordController, Icons.lock, 'Password', obscureText: true),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Confirm button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Handle profile update (you can add logic to update the profile)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile updated successfully!')),
                  );

                  // After a brief moment, navigate back to the previous page
                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.pop(context); // Go back to the previous page after update
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 24, 41, 125), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Build a custom text field widget
  Widget _buildTextField(
    TextEditingController controller,
    IconData icon,
    String label, {
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 24, 41, 125)),
        hintText: label,
        border: const UnderlineInputBorder(),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 24, 41, 125)),
        ),
      ),
    );
  }

  // Build a dropdown for marital status
  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      value: maritalStatus,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.group_outlined, color: Color.fromARGB(255, 24, 41, 125)),
        hintText: 'Marital Status',
        border: UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 24, 41, 125)),
        ),
      ),
      items: statuses
          .map((status) => DropdownMenuItem(
                value: status,
                child: Text(status),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          maritalStatus = value!;
        });
      },
    );
  }
}
