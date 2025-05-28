import 'package:flutter/material.dart';
import 'session_feedback_page.dart';
import 'upcoming_sessions.dart'; // Add this import

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
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 0.9;

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: Text(
                "Upcoming Sessions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: SizedBox(
                width: containerWidth,
                height: 220,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Scrollbar(
                    child: _buildSessionList(upcomingSessions, false, context),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: Text(
                "Previous Sessions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: SizedBox(
                width: containerWidth,
                height: 220,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Scrollbar(
                    child: _buildSessionList(previousSessions, true, context),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionList(List<Map<String, String>> sessions, bool isPrevious, BuildContext context) {
    return ListView.separated(
      itemCount: sessions.length,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        thickness: 0.8,
        color: Color(0xFF00B4A6),
      ),
      itemBuilder: (context, index) {
        final session = sessions[index];
        return GestureDetector(
          onTap: isPrevious
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SessionFeedbackPage(
                        sessionWith: session['title']!,
                        sessionDate: session['date']!,
                      ),
                    ),
                  );
                }
              : () {
                  // Navigate to upcoming sessions page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpcomingSessionsPage(),
                    ),
                  );
                },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
           child: Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    SizedBox(
      width: 80, // fixed width for date
      child: Text(
        session['date']!,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    Expanded(
      child: Text(
        session['title']!,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.left, // left-aligned for consistency
      ),
    ),
    SizedBox(
      width: 70, // fixed width for time
      child: Text(
        session['time']!,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black54,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.right,
      ),
    ),
  ],
),

          ),
        );
      },
    );
  }
}