import 'package:flutter/material.dart';

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the doctor's name passed as an argument
    final doctorName = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFF0F4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to DoctorsPage
          },
        ),
        title: const Text(
          'Doctor Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor's name
            Text(
              doctorName,  // Use the passed doctor's name
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // Doctor's details
            const Text(
              "Specialty: Clinical Psychologist",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            const SizedBox(height: 10),
            const Text(
              "About the doctor:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
              "Dr. Mark specializes in treating mental health issues like anxiety, depression, and stress. He uses evidence-based therapies like CBT and mindfulness-based techniques to help clients improve their mental well-being.",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 40),

            // Button to give feedback
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/feedback'); // Navigate to Feedback Page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003D3E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Give Feedback"),
              ),
            ),
            const SizedBox(height: 20),

            // Button to book an appointment
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/appointment'); // Navigate to Appointment Page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003D3E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Book Appointment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
