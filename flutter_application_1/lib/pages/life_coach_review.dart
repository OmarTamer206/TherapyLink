import 'package:flutter/material.dart';
import 'make_appointment_coach.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LifeCoachReviewPage(),
  ));
}

class LifeCoachReviewPage extends StatelessWidget {
  const LifeCoachReviewPage({super.key});

  static const Color mainColor = Color(0xFF1F2937);
  static const Color bgColor = Color(0xFFDFF0F4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: const Text(
          "Life Coach Page",
          style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: mainColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _buildLifeCoachCard(),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildReviewCard(
                  "Dr. Mohamed",
                  "Dr. Mohamed helped me unlock my potential and work through many personal challenges. His insights were profound and helped me build a positive mindset.",
                ),
                _buildReviewCard(
                  "Dr. Mohamed",
                  "I was feeling lost and unmotivated, but Dr. Mohamed gave me actionable strategies that made me feel empowered and focused.",
                ),
                _buildReviewCard(
                  "Dr. Mohamed",
                  "His compassionate approach made me feel heard and understood. I felt supported throughout my journey and made significant progress.",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MakeAppointmentCoachPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Make Appointment',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifeCoachCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage('assets/life_coach.png'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  children: [
                    Text(
                      'Dr. Mohamed ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: mainColor,
                      ),
                    ),
                    Text(
                      '★★★★★',
                      style: TextStyle(fontSize: 14, color: mainColor),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Life Coach',
                  style: TextStyle(fontSize: 13, color: mainColor),
                ),
                SizedBox(height: 6),
                Text(
                  "I am Dr. Mohamed, a dedicated life coach specializing in empowering individuals to unlock their full potential and navigate life challenges with confidence.",
                  style: TextStyle(fontSize: 12, color: mainColor),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(String name, String content) {
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
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: mainColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: const TextStyle(fontSize: 13, color: mainColor),
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFF00B4A6), thickness: 1),
        ],
      ),
    );
  }
}
