import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: undefined_prefixed_name
import 'dart:ui' as ui;

import 'package:flutter_application_1/pages/feedback_page.dart';

class ChatWeb extends StatefulWidget {
  var sessionData;
  final String chatId;
  final String userId;
  final String userType;
  final String receiverId;
  final String receiverType;
  final VoidCallback? onSessionStart; // ✅ Add this

   ChatWeb({
    Key? key,
    required this.sessionData,
    required this.chatId,
    required this.userId,
    required this.userType,
    required this.receiverId,
    required this.receiverType,
    this.onSessionStart,
  }) : super(key: key);

  @override
  State<ChatWeb> createState() => _ChatWebState();
}

class _ChatWebState extends State<ChatWeb> with SingleTickerProviderStateMixin {
  String? statusMessage = 'Waiting for session status...';
  bool sessionStarted = false;
  late final html.IFrameElement _iframeElement;
  late final AnimationController _fadeController;

  @override
  void initState() {
    super.initState();

    _iframeElement = html.IFrameElement()
      ..src =
          'http://localhost:4200/chat/${widget.chatId}/${widget.userId}/${widget.userType}/${widget.receiverId}/${widget.receiverType}'
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..allowFullscreen = true;

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'chat-web-iframe',
      (int viewId) => _iframeElement,
    );

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    html.window.onMessage.listen((event) {
      print('📩 Raw message from iframe: ${event.data}');
      final data = event.data;

      if (data is Map) {
        if (data['type'] == 'sessionStarted') {
          setState(() {
            sessionStarted = true;
            statusMessage = '✅ Session Started!';
          });
          _fadeController.forward();

          // ✅ Notify the parent
  widget.onSessionStart?.call();

          Future.delayed(const Duration(seconds: 0), () {
            if (mounted) setState(() => statusMessage = null);
          });
        } else if (data['type'] == 'sessionEnded') {
          setState(() {
            statusMessage = '❌ Session Ended.';
          });
          Future.delayed(const Duration(seconds: 0), () {
              var sessionWith = 'Dr. ${widget.sessionData["doctor_name"]}' ?? "Unknown";
              var sessionDate = '${widget.sessionData["date"]} , ${widget.sessionData["time"]} ' ?? "Unknown";
              var sessionDuration  = '${widget.sessionData["duration"]} Minutes' ?? "Unknown";
              var sessionCommunication = widget.sessionData["communication_type"] ?? "Unknown";
            if (mounted) Navigator.of(context).push(   MaterialPageRoute(builder: (context) => FeedbackPage(
                          sessionData: widget.sessionData,
                          sessionWith: sessionWith,
                          sessionDate:sessionDate,
                          sessionDuration:sessionDuration,
                          sessionCommunication : sessionCommunication,
                        ),));
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return const Scaffold(
        body: Center(child: Text('This view is only supported on Flutter Web.')),
      );
    }

    return Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                HtmlElementView(viewType: 'chat-web-iframe'),
                if (!sessionStarted)
                  const Positioned.fill(
                    child: ColoredBox(
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
          if (statusMessage != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.blueGrey[100],
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 20, color: Colors.black54),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      statusMessage!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
  }
}
