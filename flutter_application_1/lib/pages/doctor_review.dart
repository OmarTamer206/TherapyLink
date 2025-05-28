import 'package:flutter/material.dart';
import 'make_appointment.dart';

class DoctorReviewPage extends StatelessWidget {
  const DoctorReviewPage({super.key});

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
          "Dr. Mark’s Page",
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
          const SizedBox(height: 10),
          _buildDoctorCard(),
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
                _buildReview(
                  "Dr. Mark",
                  "Dr. Mark has been an incredible support throughout my therapy journey. He listens attentively and offers thoughtful advice that’s really helped me manage my anxiety. I always feel heard and understood after each session!",
                ),
                _buildReview(
                  "Dr. Mark",
                  "I was hesitant about online therapy, but Dr. Mark made me feel comfortable right away. His calm demeanor and practical suggestions have made a big difference in my life. I would highly recommend him to anyone seeking help!",
                ),
                _buildReview(
                  "Dr. Mark",
                  "Dr. Mark is very knowledgeable and compassionate. He helped me through a really tough time in my life, and I’ve made so much progress thanks to him. The online sessions are convenient and still feel very personal.",
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
                  MaterialPageRoute(builder: (context) => const AppointmentPage()),
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

  Widget _buildDoctorCard() {
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
            backgroundImage: AssetImage('assets/doctor.png'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      'Dr. Mark ',
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
                const SizedBox(height: 4),
                const Text(
                  'Clinical Psychologist',
                  style: TextStyle(fontSize: 13, color: mainColor),
                ),
                const SizedBox(height: 6),
                const Text(
                  "I am Dr. Mark, a dedicated clinical psychologist specializing in helping individuals overcome mental health challenges through evidence-based and compassionate care.",
                  style: TextStyle(fontSize: 12, color: mainColor,),
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

  Widget _buildReview(String name, String content) {
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
          const SizedBox(height: 4),
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
