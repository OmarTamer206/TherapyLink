import 'package:flutter/material.dart';


class SessionEndedPage extends StatelessWidget {
  const SessionEndedPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Automatically navigate back after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).popUntil((route) => route.isFirst); // Pops all routes and goes back to the first (Home)
    });

    return Scaffold(
      backgroundColor: const Color(0xFFDFF0F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFF0F4),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Session Ended',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,  // Ensures no back button
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Checkmark Icon
              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF1F2937),
                    width: 10,
                  ),
                ),
                child: Icon(
                  Icons.sms_outlined,
                  color: const Color(0xFF1F2937),
                  size: 60,
                ),
              ),
              const SizedBox(height: 40),

              // Payment Success Message
              const Text(
                'Session Ended!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),

              // Transaction Number
              const Text(
                'Hope you feel better!',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),

              // Divider
              const Divider(
                color: Colors.teal,
                thickness: 1,
              ),
              const SizedBox(height: 16),

              // Amount Paid
              
            ],
          ),
        ),
      ),
    );
  }
}
