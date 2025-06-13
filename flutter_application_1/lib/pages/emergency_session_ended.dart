import 'package:flutter/material.dart';

class SessionEndedPage extends StatelessWidget {
  const SessionEndedPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Automatically navigate back after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });

    return Scaffold(
      backgroundColor: const Color(0xFFDFF0F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFF0F4),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Session Ended',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Stylish Circle Icon
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: const Color(0xFF1F2937),
                    width: 8,
                  ),
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF1F2937),
                  size: 70,
                ),
              ),
              const SizedBox(height: 36),

              // Success Message
              const Text(
                'Session Ended!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 12),

              const Text(
                'Hope you feel better!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),

              // Themed Divider
              Container(
                height: 2,
                width: 100,
                color: const Color(0xFF1F2937),
              ),
              const SizedBox(height: 40),

              // Optional space for future content
            ],
          ),
        ),
      ),
    );
  }
}
