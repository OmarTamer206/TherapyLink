import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/patient.dart';
import 'package:flutter_application_1/services/session.dart';
import 'session_feedback_page.dart';
import 'upcoming_sessions.dart';

class SessionsPage extends StatefulWidget {
  SessionsPage({super.key});

  @override
  State<SessionsPage> createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  List<Map<dynamic, dynamic>>? upcomingSessions;
  List<Map<dynamic, dynamic>>? previousSessions;

  bool isLoadingUpcoming = true;
  bool isLoadingPrevious = true;

  final SessionApi _sessionApi = SessionApi();

  @override
  void initState() {
    super.initState();
    getUpcomingSessions();
    getPreviousSessions();
  }

  Future<void> getUpcomingSessions() async {
    try {
      final upcomingSessionsData = await _sessionApi.getUpcomingSessionsPatient();
      setState(() {
        upcomingSessions = upcomingSessionsData.map((upcomingSession) {
          DateTime date = DateTime.parse(upcomingSession['scheduled_time']).toLocal();
          String formattedDate = '${date.day}/${date.month}/${date.year}';

          int hours24 = date.hour;
          int minutes = date.minute;

          int hours12 = hours24 % 12 == 0 ? 12 : hours24 % 12;
          String ampm = hours24 >= 12 ? 'PM' : 'AM';
          String paddedMinutes = minutes.toString().padLeft(2, '0');

          String formattedTime = '$hours12:$paddedMinutes $ampm';

          return {
            ...upcomingSession,
            'date': formattedDate,
            'time': formattedTime,
          };
        }).toList();
        isLoadingUpcoming = false;
      });
    } catch (error) {
      print('Error fetching upcoming sessions: $error');
      setState(() {
        upcomingSessions = [];
        isLoadingUpcoming = false;
      });
    }
  }

  Future<void> getPreviousSessions() async {
    try {
      final previousSessionsData = await _sessionApi.getPreviousSessionsPatient();
      setState(() {
        previousSessions = previousSessionsData.map((previousSession) {
          DateTime date = DateTime.parse(previousSession['scheduled_time']).toLocal();
          String formattedDate = '${date.day}/${date.month}/${date.year}';

          int hours24 = date.hour;
          int minutes = date.minute;

          int hours12 = hours24 % 12 == 0 ? 12 : hours24 % 12;
          String ampm = hours24 >= 12 ? 'PM' : 'AM';
          String paddedMinutes = minutes.toString().padLeft(2, '0');

          String formattedTime = '$hours12:$paddedMinutes $ampm';

          return {
            ...previousSession,
            'date': formattedDate,
            'time': formattedTime,
          };
        }).toList();
        isLoadingPrevious = false;
      });
    } catch (error) {
      print('Error fetching previous sessions: $error');
      setState(() {
        previousSessions = [];
        isLoadingPrevious = false;
      });
    }
  }

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
                  child: isLoadingUpcoming
                      ? const Center(child: CircularProgressIndicator())
                      : (upcomingSessions == null || upcomingSessions!.isEmpty)
                          ? const Center(child: Text("No upcoming sessions"))
                          : Scrollbar(
                              child: _buildSessionList(upcomingSessions!, false, context),
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
                  child: isLoadingPrevious
                      ? const Center(child: CircularProgressIndicator())
                      : (previousSessions == null || previousSessions!.isEmpty)
                          ? const Center(child: Text("No previous sessions"))
                          : Scrollbar(
                              child: _buildSessionList(previousSessions!, true, context),
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

  Widget _buildSessionList(List<Map<dynamic, dynamic>> sessions, bool isPrevious, BuildContext context) {
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
                       sessionData: session,
                      ),
                    ),
                  );
                }
              : () {
                  // TODO: Implement navigation for upcoming sessions if needed
                },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80, // fixed width for date
                  child: Text(
                    session['date'] ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Session with Dr. ${session['doctor_name'] ?? ''}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 70, // fixed width for time
                  child: Text(
                    session['time'] ?? '',
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
