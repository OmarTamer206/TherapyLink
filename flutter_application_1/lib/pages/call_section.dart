import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'dart:html' as html; // For web view rendering
import 'dart:ui' as ui; // For web view registry
import 'package:flutter/foundation.dart' show kIsWeb;

class CallWidget extends StatefulWidget {
  final String userId;
  final String userType;
  final String userName;
  final String callId;

  const CallWidget({
    Key? key,
    required this.userId,
    required this.userType,
    required this.userName,
    required this.callId,
  }) : super(key: key);

  @override
  _CallWidgetState createState() => _CallWidgetState();
}

class _CallWidgetState extends State<CallWidget> {
  late RTCPeerConnection _peerConnection;
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  bool _inCalling = false;
  final String _localViewId = 'local-web-video';
  final String _remoteViewId = 'remote-web-video';

  @override
  void initState() {
    super.initState();
    _initializeRenderers();
    if (kIsWeb) {
      _registerWebViews();
      _startWebCall();
    } else {
      _startCall();
    }
  }

  void _registerWebViews() {
    ui.platformViewRegistry.registerViewFactory(
      _localViewId,
      (int viewId) {
        final video = html.VideoElement()
          ..autoplay = true
          ..muted = true
          ..style.width = '100%'
          ..style.height = '100%';
        return video;
      },
    );

    ui.platformViewRegistry.registerViewFactory(
      _remoteViewId,
      (int viewId) {
        final video = html.VideoElement()
          ..autoplay = true
          ..style.width = '100%'
          ..style.height = '100%';
        return video;
      },
    );
  }

  Future<void> _startWebCall() async {
    try {
      final stream = await html.window.navigator.mediaDevices!.getUserMedia({
        'audio': true,
        'video': {'facingMode': 'user'}
      });

      final local = html.document.getElementById(_localViewId) as html.VideoElement?;
      final remote = html.document.getElementById(_remoteViewId) as html.VideoElement?;

      if (local != null && remote != null) {
        setState(() {
          local.srcObject = stream;
          remote.srcObject = stream.clone();
          _inCalling = true;
        });
      }
    } catch (e) {
      print('Web getUserMedia error: $e');
    }
  }

  Future<void> _initializeRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  Future<void> _startCall() async {
    final Map<String, dynamic> configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ]
    };

    _peerConnection = await createPeerConnection(configuration);

    final mediaStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': {'facingMode': 'user'},
    });
    _localRenderer.srcObject = mediaStream;

    mediaStream.getTracks().forEach((track) {
      _peerConnection.addTrack(track, mediaStream);
    });

    _peerConnection.onTrack = (RTCTrackEvent event) {
      if (event.streams.isNotEmpty) {
        setState(() {
          _remoteRenderer.srcObject = event.streams[0];
        });
      }
    };

    setState(() {
      _inCalling = true;
    });
  }

  Future<void> _hangUp() async {
    if (!kIsWeb) {
      await _localRenderer.dispose();
      await _remoteRenderer.dispose();
      await _peerConnection.close();
    }
    setState(() {
      _inCalling = false;
    });
  }

  @override
  void dispose() {
    _hangUp();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF0F4),
      appBar: AppBar(
        title: const Text('Video Call'),
        backgroundColor: const Color(0xFF1F2937),
      ),
      body: _inCalling
          ? Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: kIsWeb
                            ? HtmlElementView(viewType: _localViewId)
                            : RTCVideoView(_localRenderer, mirror: true),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: kIsWeb
                            ? HtmlElementView(viewType: _remoteViewId)
                            : RTCVideoView(_remoteRenderer),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _hangUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Hang Up'),
                ),
                const SizedBox(height: 20),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
