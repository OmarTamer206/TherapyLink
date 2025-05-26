import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChatBotPage(),
  ));
}

class ChatBotPage extends StatelessWidget {
  const ChatBotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF0F4), // Light blue background
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A3D7B), // Dark Blue
        elevation: 0,
        title: const Text(
          'ChatBot',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigate back to the previous screen (HomePage)
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.transparent, // Blank screen with no content
            ),
          ),
          
          // Text input field and send button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type Something...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // TODO: Send message logic (if needed)
                  },
                  icon: const Icon(Icons.send, color: Color.fromARGB(255, 24, 41, 125)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
