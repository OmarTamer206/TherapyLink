import 'package:flutter/material.dart';
import 'package:mobile_app/screens/chatbot_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({super.key, this.username = 'User'});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1F1F6),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(
              'Welcome ${widget.username}!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF06303E),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Upcoming Session',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF06303E),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    children: [
                      Icon(Icons.person, color: Color(0xFF149FA8)),
                      SizedBox(width: 10),
                      Text(
                        'Session with : Dr . Magdy',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.access_time, color: Color(0xFF149FA8)),
                      SizedBox(width: 10),
                      Text(
                        'Timing: 9/1/2025, 7:00 PM',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE1F1F6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '20 minutes left',
                      style: TextStyle(
                        color: Color(0xFF149FA8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildActionButton(
              context,
              'Change Therapist',
              Icons.swap_horiz,
              onPressed: () {},
            ),
            const SizedBox(height: 15),
            _buildActionButton(
              context,
              'Preference',
              Icons.settings,
              onPressed: () {},
            ),
            const SizedBox(height: 15),
            _buildActionButton(
              context,
              'Repeat Chatbot Test',
              Icons.chat_bubble,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChatbotScreen()
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String text, IconData icon,
      {VoidCallback? onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF06303E),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF149FA8)),
          const SizedBox(width: 15),
          Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward, color: Colors.grey),
        ],
      ),
    );
  }
}
