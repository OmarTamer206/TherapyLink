import 'package:flutter/material.dart';
import 'feedback_page.dart'; // Import the FeedbackPage

class SessionFeedbackPage extends StatelessWidget {
  final String sessionWith;
  final String sessionDate;

  const SessionFeedbackPage({
    Key? key,
    required this.sessionWith,
    required this.sessionDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF0F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFF0F4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Old Sessions',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Session With: $sessionWith',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text('30 minutes'),
              ],
            ),
            const SizedBox(height: 4),
            Text('Timing: $sessionDate'),
            const SizedBox(height: 20),

            // Blank White Container in the center of the screen
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            // Rate & Feedback Button
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FeedbackPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F2937),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Rate & Feedback',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
