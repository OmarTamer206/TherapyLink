import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: undefined_prefixed_name
import 'dart:ui' as ui;

import 'package:flutter_application_1/pages/feedback_page.dart';

class CallWeb extends StatefulWidget {
  final dynamic sessionData;
  final String call_ID;
  final String userId;
  final String userType;
  final String userName;

  const CallWeb({
    Key? key,
    required this.sessionData,
    required this.call_ID,
    required this.userId,
    required this.userType,
    required this.userName,
  }) : super(key: key);

  @override
  State<CallWeb> createState() => _CallWebState();
}

class _CallWebState extends State<CallWeb> with SingleTickerProviderStateMixin {
  String? statusMessage = 'Waiting for session status...';
  bool sessionStarted = false;
  late final html.IFrameElement _iframeElement;
  late final AnimationController _fadeController;

  @override
  void initState() {
    super.initState();

    _iframeElement = html.IFrameElement()
      ..src =
          'http://localhost:4200/call/${widget.call_ID}/${widget.userId}/${widget.userType}/${widget.userName}'
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..allowFullscreen = true
      ..allow = 'camera; microphone'; // ✅ Enable mic and camera access

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'call-web-iframe',
      (int viewId) => _iframeElement,
    );

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    html.window.onMessage.listen((event) {
      final data = event.data;

      if (data is Map) {
        if (data['type'] == 'sessionStarted') {
          setState(() {
            sessionStarted = true;
            statusMessage = '✅ Session Started!';
          });
          _fadeController.forward();
          Future.delayed(const Duration(seconds: 0), () {
            if (mounted) setState(() => statusMessage = null);
          });
        } else if (data['type'] == 'sessionEnded') {
          setState(() {
            statusMessage = '❌ Session Ended.';
          });
          Future.delayed(const Duration(seconds: 0), () {
            final sessionWith = 'Dr. ${widget.sessionData["doctor_name"]}' ?? "Unknown";
            final sessionDate = '${widget.sessionData["date"]} , ${widget.sessionData["time"]}' ?? "Unknown";
            final sessionDuration = '${widget.sessionData["duration"]} Minutes' ?? "Unknown";
            final sessionCommunication = widget.sessionData["communication_type"] ?? "Unknown";

            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedbackPage(
                    sessionData: widget.sessionData,
                    sessionWith: sessionWith,
                    sessionDate: sessionDate,
                    sessionDuration: sessionDuration,
                    sessionCommunication: sessionCommunication,
                  ),
                ),
              );
            }
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
              HtmlElementView(viewType: 'call-web-iframe'),
              if (!sessionStarted)
                const Positioned.fill(
                  child: ColoredBox(color: Colors.white),
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
