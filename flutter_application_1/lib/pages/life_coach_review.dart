import 'package:flutter/material.dart';
import 'make_appointment_coach.dart';  // Ensure this import is added

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LifeCoachReviewPage(),
  ));
}

class LifeCoachReviewPage extends StatelessWidget {
  const LifeCoachReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF0F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFF0F4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);  // Go back to the previous screen
          },
        ),
        title: const Text(
          "Dr. Mohamed's Life Coach Page",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildLifeCoachInfo(),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Reviews',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildReviewCard("Dr. Mohamed", "Dr. Mohamed helped me unlock my potential and work through many personal challenges. His insights were profound and helped me build a positive mindset."),
                _buildReviewCard("Dr. Mohamed", "I was feeling lost and unmotivated, but Dr. Mohamed gave me actionable strategies that made me feel empowered and focused."),
                _buildReviewCard("Dr. Mohamed", "His compassionate approach made me feel heard and understood. I felt supported throughout my journey and made significant progress."),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 24, 41, 125), // Your custom color
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {
                // Navigate to the make_appointment_coach page when clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MakeAppointmentCoachPage()),  // Correct page navigation
                );
              },
              child: const Text(
                'Make Appointment',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifeCoachInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: const [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/life_coach.png'), // Replace with actual asset or URL
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Dr. Mohamed ★★★★★', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Life Coach'),
                SizedBox(height: 6),
                Text(
                  "I am Dr. Mohamed, a dedicated life coach specializing in empowering individuals to unlock their full potential and navigate life challenges with confidence.",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildReviewCard(String name, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(content),
          const SizedBox(height: 10),
          Container(height: 1, color: Colors.teal),
        ],
      ),
    );
  }
}
