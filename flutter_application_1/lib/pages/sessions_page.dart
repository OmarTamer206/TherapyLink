import 'package:flutter/material.dart';
import 'session_feedback_page.dart'; // Import the Session Feedback page

class SessionsPage extends StatelessWidget {
  const SessionsPage({super.key});

  final List<Map<String, String>> upcomingSessions = const [
    {"date": "2/2/2025", "title": "Session with Dr. Mark", "time": "7:00PM"},
    {"date": "3/6/2025", "title": "Session with Dr. Sara", "time": "5:00PM"},
    {"date": "4/8/2025", "title": "Group Session", "time": "2:00PM"},
    {"date": "5/2/2025", "title": "Session with Dr. Mark", "time": "6:00PM"},
    {"date": "6/7/2025", "title": "Group Session", "time": "7:00PM"},
  ];

  final List<Map<String, String>> previousSessions = const [
    {"date": "2/2/2024", "title": "Session with Dr. Mark", "time": "7:00PM"},
    {"date": "3/6/2024", "title": "Session with Dr. Sara", "time": "5:00PM"},
    {"date": "4/8/2024", "title": "Group Session", "time": "2:00PM"},
    {"date": "5/2/2024", "title": "Session with Dr. Mark", "time": "6:00PM"},
    {"date": "6/7/2024", "title": "Group Session", "time": "7:00PM"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF0F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFF0F4),
        elevation: 0,
        title: const Text(
          'Sessions',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const Text(
              'Upcoming Sessions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            _buildSessionList(upcomingSessions, false, context), // Upcoming sessions - Non-tappable
            const SizedBox(height: 30),
            const Text(
              'Previous Sessions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            _buildSessionList(previousSessions, true, context), // Previous sessions - Tappable
          ],
        ),
      ),
    );
  }

  // Method to build the session list
  Widget _buildSessionList(List<Map<String, String>> sessions, bool isPrevious, BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final session = sessions[index];
          return GestureDetector(
            onTap: isPrevious ? () {
              // If it's a previous session, navigate to the session feedback page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SessionFeedbackPage(
                    sessionWith: session['title']!,
                    sessionDate: session['date']!,
                  ),
                ),
              );
            } : null, // Upcoming sessions are non-tappable
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Date: ${session['date']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Time: ${session['time']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
