import 'package:flutter/material.dart';
import 'signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? selectedGender;
  String? selectedMaritalStatus;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1F1F6),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 120,
                    height: 120,
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'TherapyLink',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF06303E),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '"Find the support you need, Connect with the right therapist, and start your journey toward healing because everyone deserves a safe space to talk."',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF149FA8),
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                value: selectedGender,
                items: const [
                  DropdownMenuItem(
                    value: 'Male',
                    child: Text('Male'),
                  ),
                  DropdownMenuItem(
                    value: 'Female',
                    child: Text('Female'),
                  ),
                  DropdownMenuItem(
                    value: 'Other',
                    child: Text('Other'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Marital Status',
                  border: OutlineInputBorder(),
                ),
                value: selectedMaritalStatus,
                items: const [
                  DropdownMenuItem(
                    value: 'Single',
                    child: Text('Single'),
                  ),
                  DropdownMenuItem(
                    value: 'Married',
                    child: Text('Married'),
                  ),
                  DropdownMenuItem(
                    value: 'Divorced',
                    child: Text('Divorced'),
                  ),
                  DropdownMenuItem(
                    value: 'Widowed',
                    child: Text('Widowed'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedMaritalStatus = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select your marital status';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ' Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff06303E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      _navigateToSignIn();
                    }
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: GestureDetector(
                  onTap: _navigateToSignIn,
                  child: RichText(
                    text: const TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: 'Log In',
                          style: TextStyle(
                            color: Color(0xFF149FA8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToSignIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }
}
