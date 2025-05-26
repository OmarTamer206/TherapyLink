import 'package:flutter/material.dart';
import 'make_appointment.dart';  // Import the appointment page

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DoctorReviewPage(),
  ));
}

class DoctorReviewPage extends StatelessWidget {
  const DoctorReviewPage({super.key});

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
            Navigator.pop(context); // This pops the current page off the stack, returning to the previous page
          },
        ),
        title: const Text(
          "Dr. Mark's Page",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildDoctorInfo(),
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
                _buildReviewCard("Dr. Mark", "Dr. Mark has been an incredible support throughout my therapy journey. He listens attentively and offers thoughtful advice that’s really helped me manage my anxiety. I always feel heard and understood after each session!"),
                _buildReviewCard("Dr. Mark", "I was hesitant about online therapy, but Dr. Mark made me feel comfortable right away. His calm demeanor and practical suggestions have made a big difference in my life. I would highly recommend him to anyone seeking help!"),
                _buildReviewCard("Dr. Mark", "Dr. Mark is very knowledgeable and compassionate. He helped me through a really tough time in my life, and I’ve made so much progress thanks to him. The online sessions are convenient and still feel very personal."),
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
                // Navigate to the make appointment page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AppointmentPage()),
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
          )
        ],
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/doctor.png'), // Replace with actual asset or URL
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Dr. Mark ★★★★★', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Clinical Psychologist'),
                SizedBox(height: 6),
                Text(
                  "I am Dr. Mark, a dedicated clinical psychologist specializing in helping individuals overcome mental health challenges through evidence-based and compassionate care.",
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
