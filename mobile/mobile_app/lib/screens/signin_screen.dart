import 'package:flutter/material.dart';
import 'signup_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _navigateToSignUp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        pageBuilder: (context, animation1, animation2) => HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1F1F6),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0) ,
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
                ],
              ),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  '"Welcome Back! Your Path to Clarity and Support is Just a Conversation Away."',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Email',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14
                    ),
                    validator:(value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (! value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14
                      ),
                      
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      ),

    )
  }
}
