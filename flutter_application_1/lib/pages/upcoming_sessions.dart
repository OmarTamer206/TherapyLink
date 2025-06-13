import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/call_section.dart';
import 'package:flutter_application_1/pages/chat_web.dart';

import 'dart:async';


import 'package:flutter_application_1/services/patient.dart';

class UpcomingSessionsPage extends StatefulWidget {
  final Map<String, dynamic> sessionData;

  const UpcomingSessionsPage({Key? key, required this.sessionData}) : super(key: key);

  @override
  State<UpcomingSessionsPage> createState() => _UpcomingSessionsPageState();
}

class _UpcomingSessionsPageState extends State<UpcomingSessionsPage> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  bool sessionStarted = false;
  bool sessionEnded = false;
  bool _loading = true;

  final PatientApi _patientApi = PatientApi();

  String? patient_name;

  @override
  void initState() {
    super.initState();
    _getPatientName();
    _extractDataAndTime();
    _initializeCountdown();
  }

  _getPatientName() async {
    var patient_data = await _patientApi.getProfileData();
    setState(() {
      patient_name = patient_data["data"]["patient"][0]["Name"];
      _loading = false;
    });
    // _initSockets();
  }

  void _extractDataAndTime() {
    DateTime date = DateTime.parse(widget.sessionData['scheduled_time']).toLocal();
    String formattedDate = '${date.day}/${date.month}/${date.year}';

    int hours24 = date.hour;
    int minutes = date.minute;
    int hours12 = hours24 % 12 == 0 ? 12 : hours24 % 12;
    String ampm = hours24 >= 12 ? 'PM' : 'AM';
    String paddedMinutes = minutes.toString().padLeft(2, '0');
    String formattedTime = '$hours12:$paddedMinutes $ampm';

    widget.sessionData['date'] = formattedDate;
    widget.sessionData['time'] = formattedTime;
  }

  void _initializeCountdown() {
    final now = DateTime.now();
    final scheduledTime = DateTime.tryParse(widget.sessionData['scheduled_time'] ?? '');
    if (scheduledTime != null) {
      final diff = scheduledTime.difference(now);
      _remaining = diff > Duration.zero ? diff : Duration.zero;

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_remaining.inSeconds <= 1) {
          timer.cancel();
          setState(() {
            _remaining = Duration.zero;
            sessionStarted = true;
          });
        } else {
          setState(() {
            _remaining = Duration(seconds: _remaining.inSeconds - 1);
          });
        }
      });
    }
  }

  // void _initSockets() {
  //   final type = widget.sessionData['communication_type'];
  //   final chatId = widget.sessionData['chat_ID']?.toString() ?? "";
  //   final callId = widget.sessionData['call_ID']?.toString() ?? "";
  //   final userId = widget.sessionData['patient_ID'].toString();
  //   final userType = 'patient';
  //   final userName = patient_name;

  //   if (type == 'Chatting') {
  //     _chatSocketService.connect();
  //     _chatSocketService.enterChat(chatId, userId, userType);
  //     _chatSocketService.onSessionStart(() {
  //       setState(() => sessionStarted = true);
  //     });
  //     _chatSocketService.onSessionEnded(() {
  //       setState(() => sessionEnded = true);
  //     });
  //   } else if (type == 'Voice / Video Call') {
  //     _callApi.connect();

  //     // Wait for the doctor to start the session
  //     _callApi.onSessionStarted(() {
  //       _callApi.joinCall(callId, userId, userType, userName ?? "Unknown");
  //       setState(() => sessionStarted = true);
  //     });

  //     _callApi.onCallEnded(() {
  //       setState(() => sessionEnded = true);
  //     });
  //   }
  // }

  @override
  void dispose() {
    _timer?.cancel();
    // _chatSocketService.disconnect();
    // _callApi.disconnect();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    if (duration.inSeconds == 0) return 'Session time is now';
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return 'Starts in : ${twoDigits(duration.inDays)}:${twoDigits(duration.inHours.remainder(24))}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}';
  }

  Widget _buildSessionWidget() {
    final type = widget.sessionData['communication_type'];

    

    if (type == 'Chatting') {
      // return ChatWidget(
      //   chatId: widget.sessionData['chat_ID'].toString(),
      //   userId: widget.sessionData['patient_ID'].toString(),
      //   userType: 'patient',
      //   receiverId: widget.sessionData['doctor_ID'].toString(),
      //   receiverType: widget.sessionData['session_type'],
      // );
      return ChatWeb(
         sessionData:widget.sessionData,
         chatId: widget.sessionData['chat_ID'].toString(),
         userId: widget.sessionData['patient_ID'].toString(),
         userType: 'patient',
         receiverId: widget.sessionData['doctor_ID'].toString(),
         receiverType: widget.sessionData['session_type'],
       );
    } 
    // else if (type == 'Voice / Video Call') {
    //   return CallWidget(
    //     callId: widget.sessionData['call_ID'].toString(),
    //     userId: widget.sessionData['patient_ID'].toString(),
    //     userType: 'patient',
    //     userName: patient_name ?? "Unknown",
    //   );
    // } 
    else {
      return const Text('Invalid session type');
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = widget.sessionData;

    if (_loading) {
      return const Scaffold(
        backgroundColor: Color(0xFFDFF0F4),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFDFF0F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFF0F4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Upcoming Session',
            style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Session With: Dr. ${session['doctor_name'] ?? 'Unknown'}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('Duration : ${session['duration'] ?? 30} minutes'),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Timing: ${session['date']} , ${session['time']}'),
                Text('Comm. Type : ${session['communication_type']}'),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                
                padding: const EdgeInsets.all(0),
                child: _buildSessionWidget(),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1F2937),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _formatDuration(_remaining),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
