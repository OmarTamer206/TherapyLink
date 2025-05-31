import 'package:flutter/material.dart';
import 'dart:async';

class UpcomingSessionsPage extends StatefulWidget {

  final Map<String, dynamic> sessionData;

  const UpcomingSessionsPage({Key? key , required this.sessionData}) : super(key: key);

  @override
  State<UpcomingSessionsPage> createState() => _UpcomingSessionsPageState();
}

class _UpcomingSessionsPageState extends State<UpcomingSessionsPage> {
  Timer? _timer;
  Duration _elapsed = const Duration(hours: 1, minutes: 35, seconds: 50);
  Duration _remaining = const Duration(hours: 25, minutes: 15, seconds: 10);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsed = Duration(seconds: _elapsed.inSeconds + 1);
        if (_remaining.inSeconds > 0) {
          _remaining = Duration(seconds: _remaining.inSeconds - 1);
        }
      });
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF0F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFF0F4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Upcoming Sessions',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Session With: Dr. Magdy',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(

                  padding: EdgeInsets.only(top: 1),
                  child: Text('30 minutes'),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Timing: 9/1/2025 , 7:00 PM'),
            ),
            const SizedBox(height: 10),

            Expanded(
          child: Container(
  width: double.infinity,
  padding: const EdgeInsets.symmetric(vertical: 100), // Increase padding
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
  ),
  child: Column(
    children: const [
      Spacer(),
      SizedBox(height: 80), // Increase empty space
    ],
  ),
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
                'Ends in ${_formatDuration(_remaining)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
