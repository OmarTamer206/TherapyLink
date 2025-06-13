import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/HomePage.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:flutter_application_1/pages/feedback_page.dart';
import 'package:flutter_application_1/services/auth.dart';

class EmergencyCallWeb extends StatefulWidget {
  final String userId;

  const EmergencyCallWeb({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<EmergencyCallWeb> createState() => _EmergencyCallWebState();
}

class _EmergencyCallWebState extends State<EmergencyCallWeb> with SingleTickerProviderStateMixin {
  late html.IFrameElement _iframeElement;
  bool isIframeReady = false;
  String? token;
  bool sessionStarted = false;
  String? statusMessage = 'Waiting for session status...';

  final AuthApi _authApi = AuthApi();
  late final AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    setupIframeWithAuth();
    setupMessageListener();
  }

  Future<void> setupIframeWithAuth() async {
    token = await _authApi.getToken();

    if (token == null) {
      debugPrint('❌ Token is null');
      return;
    }

    _iframeElement = html.IFrameElement()
      ..src = 'http://localhost:4200/emergency-call/${widget.userId}'
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..allowFullscreen = true
      ..allow = 'camera; microphone';

    // Wait for iframe to fully load before sending token
    _iframeElement.onLoad.listen((event) {
      debugPrint('✅ Iframe loaded');
      _iframeElement.contentWindow?.postMessage(
        {'token': token, 'userId': widget.userId},
        '*',
      );
    });

    // Register iframe for Flutter Web view
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'call-web-iframe',
      (int viewId) => _iframeElement,
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
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) setState(() => statusMessage = null);
          });
        } else if (data['type'] == 'sessionEnded') {
          print("sessionEnded");
          setState(() {
            statusMessage = '❌ Session Ended.';
          });

          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    
                  ),
                ),
              );
            }
          });
        }
      }
    });
    
    setState(() {
      isIframeReady = true;
    });
  }

  void setupMessageListener() {
    
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
              if (isIframeReady)
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