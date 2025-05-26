import 'package:flutter/material.dart';
import 'doctor_review.dart'; // Import the doctor review page

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});

  final List<Map<String, dynamic>> doctors = const [
    {"name": "Dr. Mark", "rating": 4.5},
    {"name": "Dr. Mohamed", "rating": 3.5},
    {"name": "Dr. Hossam", "rating": 3.5},
    {"name": "Dr. Mostafa", "rating": 3.5},
    {"name": "Dr. Lara", "rating": 4.5},
    {"name": "Dr. Mariam", "rating": 4.5},
    {"name": "Dr. Steve", "rating": 4.5},
    {"name": "Dr. Jasmine", "rating": 3.5},
    {"name": "Dr. Carmen", "rating": 3.5},
    {"name": "Dr. Sera", "rating": 4.5},
    {"name": "Dr. Marven", "rating": 4.5},
    {"name": "Dr. Karla", "rating": 3.5},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF0F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFF0F4),
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Doctors',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Clinical Psychologist',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.separated(
                shrinkWrap: true, // 👈 Wrap content height
                physics: const NeverScrollableScrollPhysics(), // 👈 Disable internal scroll
                itemCount: doctors.length,
                separatorBuilder: (context, index) => const Divider(height: 16),
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          doctor['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.black, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            doctor['rating'].toString(),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () {
                          // Navigate to the doctor profile page (doctor_review.dart)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DoctorReviewPage()),
                          );
                        },
                        child: const Text(
                          'View Doctor',
                          style: TextStyle(
                            color: Color.fromARGB(255, 24, 41, 125),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
