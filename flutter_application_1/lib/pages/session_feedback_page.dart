import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/old_chat_web.dart';
import 'feedback_page.dart';

class SessionFeedbackPage extends StatefulWidget {
  final dynamic sessionData;

  const SessionFeedbackPage({
    Key? key,
    required this.sessionData,
  }) : super(key: key);

  @override
  State<SessionFeedbackPage> createState() => _SessionFeedbackPageState();
}

class _SessionFeedbackPageState extends State<SessionFeedbackPage> {
  late String sessionWith;
  late String sessionDate;
  var sessionDuration ;
  var sessionCommunication ;
  @override
  void initState() {
    super.initState();

    // Extract and assign values from sessionData
    sessionWith = 'Dr. ${widget.sessionData["doctor_name"]}' ?? "Unknown";
    sessionDate = '${widget.sessionData["date"]} , ${widget.sessionData["time"]} ' ?? "Unknown";
    sessionDuration  = '${widget.sessionData["duration"]} Minutes' ?? "Unknown";
    sessionCommunication = widget.sessionData["communication_type"] ?? "Unknown";
  }

   Widget _buildSessionWidget() {
    final type = widget.sessionData['communication_type'];

    

    if (type == 'Chatting') {
      
      return OldChatWeb(
         sessionData:widget.sessionData,
         chatId: widget.sessionData['chat_ID'].toString(),
         userId: widget.sessionData['patient_ID'].toString(),
       );
    } 
    else if (type == 'Voice / Video Call') {
      return Center(
        child: Text(
          "Voice / Video Call sessions can't be viewed.",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      );
    } 
    else {
      return const Text('Invalid session type');
    }
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
          onPressed: () => { Navigator.of(context).popUntil((route) => route.isFirst)} // Pops all routes and goes back to the first (Home)
,
        ),
        title: const Text(
          'Old Session',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Session With: $sessionWith',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                 Text('Duration : ${sessionDuration}'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text('Timing: $sessionDate'),
                Text('Comm. Type : $sessionCommunication'),
              ],
            ),
            const SizedBox(height: 20),

            // Blank White Container in the center of the screen
           Expanded(
              child: Container(
                width: double.infinity,
                
                padding: const EdgeInsets.all(0),
                child: _buildSessionWidget(),
              ),
            ),
            const SizedBox(height: 20),

            // Rate & Feedback Button
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedbackPage(
                          sessionData: widget.sessionData,
                          sessionWith: sessionWith,
                          sessionDate:sessionDate,
                          sessionDuration:sessionDuration,
                          sessionCommunication : sessionCommunication,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F2937),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Rate & Feedback',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
