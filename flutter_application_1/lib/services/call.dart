import 'dart:async';
import 'dart:html' as html;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CallApi {
  static const String _baseUrl = 'http://localhost:3000'; // Replace with your actual backend URL
  
  IO.Socket? _socket;
  html.MediaStream? _localStream;
  final Map<String, html.RtcPeerConnection> _peerConnections = {};
  final Map<String, html.MediaStream> _remoteStreams = {};
  
  // Callbacks
  Function()? _onSessionStarted;
  Function()? _onCallEnded;
  Function(Map<String, dynamic>)? _onParticipantsUpdate;
  Function(String, html.MediaStream)? _onRemoteStream;
  Function(String)? _onParticipantLeft;
  
  // State
  bool _isConnected = false;
  bool _isMuted = false;
  bool _isVideoOn = false;
  String? _currentCallId;
  String? _currentUserId;
  String? _currentUserType;
  String? _currentUserName;

  // Getters
  bool get isConnected => _isConnected;
  bool get isMuted => _isMuted;
  bool get isVideoOn => _isVideoOn;
  html.MediaStream? get localStream => _localStream;
  Map<String, html.MediaStream> get remoteStreams => _remoteStreams;

  // Connect to socket
  void connect() {
    if (_socket?.connected == true) return;
    
    _socket = IO.io(_baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket!.connect();
    
    _socket!.on('connect', (_) {
      print('Connected to call socket');
      _isConnected = true;
    });

    _socket!.on('disconnect', (_) {
      print('Disconnected from call socket');
      _isConnected = false;
    });

    _setupEventListeners();
  }

  // Setup socket event listeners
  void _setupEventListeners() {
    // Session started by doctor/coach
    _socket!.on('sessionStarted', (_) {
      print('Session started');
      _onSessionStarted?.call();
    });

    // Call ended
    _socket!.on('callEnded', (_) {
      print('Call ended');
      _cleanup();
      _onCallEnded?.call();
    });

    // Participants update
    _socket!.on('participantsUpdate', (data) {
      print('Participants updated: $data');
      _onParticipantsUpdate?.call(Map<String, dynamic>.from(data));
    });

    // WebRTC signaling
    _socket!.on('webrtc-offer', (data) {
      _handleWebRTCOffer(data['offer'].toString(), data['senderId'].toString());
    });

    _socket!.on('webrtc-answer', (data) {
      _handleWebRTCAnswer(data['answer'].toString(), data['senderId'].toString());
    });

    _socket!.on('webrtc-ice-candidate', (data) {
      _handleWebRTCIceCandidate(data['candidate'].toString(), data['senderId'].toString());
    });

    // Rejoin request
    _socket!.on('rejoinRequest', (data) {
      _handleRejoinRequest(data['call_ID'].toString(), data['targetId'].toString());
    });
  }

  // Join call
  Future<void> joinCall(String callId, String userId, String userType, String userName) async {
    _currentCallId = callId;
    _currentUserId = userId;
    _currentUserType = userType;
    _currentUserName = userName;

    try {
      // Try to get user media (will fallback to audio-only if camera fails)
      await _getUserMedia();
      
      // Join the call room
      _socket!.emit('joinCall', {
        'call_ID': callId,
        'userId': userId,
        'userType': userType,
        'userName': userName,
      });

      print('Joined call: $callId as $userName ($userType)');
    } catch (e) {
      print('Error joining call: $e');
      
      // Even if media fails, still try to join the call
      _socket!.emit('joinCall', {
        'call_ID': callId,
        'userId': userId,
        'userType': userType,
        'userName': userName,
      });
      
      print('Joined call without media: $callId as $userName ($userType)');
    }
  }

  // Check call status (for rejoin)
  Future<bool> checkCallStatus(String callId, String userId) async {
    final completer = Completer<bool>();
    
    _socket!.emitWithAck('checkCallStatus', {
      'call_ID': callId,
      'userId': userId,
    }, ack: (data) {
      completer.complete(data['rejoinAllowed'] ?? false);
    });

    return completer.future;
  }

  // Get user media (camera/microphone)
  Future<void> _getUserMedia({bool retryWithoutVideo = false}) async {
    try {
      if (retryWithoutVideo) {
        // Try audio only if video fails
        _localStream = await html.window.navigator.mediaDevices!.getUserMedia({
          'audio': true,
        });
        _isVideoOn = false;
        print('Got user media (audio only)');
      } else {
        // Try with video first
        _localStream = await html.window.navigator.mediaDevices!.getUserMedia({
          'video': {
            'width': {'ideal': 640},
            'height': {'ideal': 480},
            'facingMode': 'user'
          },
          'audio': true,
        });
        _isVideoOn = true;
        print('Got user media (video + audio)');
      }
    } catch (e) {
      print('Error getting user media: $e');
      
      if (!retryWithoutVideo && e.toString().contains('NotReadableError')) {
        print('Camera might be in use by another app. Trying audio-only...');
        try {
          await _getUserMedia(retryWithoutVideo: true);
          return;
        } catch (audioError) {
          print('Error getting audio: $audioError');
        }
      }
      
      // If all fails, continue without media but show user a message
      _showMediaError(e.toString());
    }
  }

  void _showMediaError(String error) {
    print('Media access failed: $error');
    // You can emit an event here to show user-friendly error message
  }

  // Toggle mute
  void toggleMute() {
    if (_localStream != null) {
      final audioTracks = _localStream!.getAudioTracks();
      for (final track in audioTracks) {
        track.enabled = _isMuted;
      }
      _isMuted = !_isMuted;
      
      _socket!.emit('toggleMute', {
        'call_ID': _currentCallId,
        'userId': _currentUserId,
        'muted': _isMuted,
      });
    }
  }

  // Toggle video
  void toggleVideo() {
    if (_localStream != null) {
      final videoTracks = _localStream!.getVideoTracks();
      for (final track in videoTracks) {
        track.enabled = _isVideoOn;
      }
      _isVideoOn = !_isVideoOn;
      
      _socket!.emit('toggleVideo', {
        'call_ID': _currentCallId,
        'userId': _currentUserId,
        'videoOn': _isVideoOn,
      });
    }
  }

  // Start session (for doctors/coaches only)
  void startSession(String callId, String sessionType, {int? durationMinutes}) {
    _socket!.emit('startSession', {
      'call_ID': callId,
      'session_type': sessionType,
      'durationMinutes': durationMinutes ?? "no",
    });
  }

  // End call (for doctors/coaches only)
  void endCall() {
    if (_currentCallId != null && _currentUserId != null) {
      _socket!.emit('endCall', {
        'call_ID': _currentCallId,
        'userId': _currentUserId,
      });
    }
  }

  // Leave call
  void leaveCall() {
    if (_currentCallId != null && _currentUserId != null) {
      _socket!.emit('leaveCall', {
        'call_ID': _currentCallId,
        'userId': _currentUserId,
      });
      _cleanup();
    }
  }

  // WebRTC peer connection creation
  Future<html.RtcPeerConnection> _createPeerConnection(String peerId) async {
    final configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ]
    };

    final pc = html.RtcPeerConnection(configuration);

    // Add local stream
    if (_localStream != null) {
      for (final track in _localStream!.getTracks()) {
        pc.addTrack(track, _localStream!);
      }
    }

    // Handle remote stream
    pc.onTrack.listen((event) {
      final stream = event.streams!.first;
      _remoteStreams[peerId] = stream;
      _onRemoteStream?.call(peerId, stream);
    });

    // Handle ICE candidates
    pc.onIceCandidate.listen((event) {
      if (event.candidate != null) {
        _socket!.emit('webrtc-ice-candidate', {
          'call_ID': _currentCallId,
          'candidate': {
            'candidate': event.candidate!.candidate,
            'sdpMLineIndex': event.candidate!.sdpMLineIndex,
            'sdpMid': event.candidate!.sdpMid,
          },
          'senderId': _currentUserId,
        });
      }
    });

    return pc;
  }

  // Handle WebRTC offer
  Future<void> _handleWebRTCOffer(dynamic offer, String senderId) async {
    try {
      final pc = await _createPeerConnection(senderId);
      _peerConnections[senderId] = pc;

      await pc.setRemoteDescription(offer);
      final answer = await pc.createAnswer();
      final answerMap = {
        'type': answer.type,
        'sdp': answer.sdp,
      };
      await pc.setLocalDescription(answerMap);

      _socket!.emit('webrtc-answer', {
        'call_ID': _currentCallId,
        'answer': answerMap,
        'senderId': _currentUserId,
      });
    } catch (e) {
      print('Error handling WebRTC offer: $e');
    }
  }

  // Handle WebRTC answer
  Future<void> _handleWebRTCAnswer(dynamic answer, String senderId) async {
    try {
      final pc = _peerConnections[senderId];
      if (pc != null) {
        await pc.setRemoteDescription(answer);
      }
    } catch (e) {
      print('Error handling WebRTC answer: $e');
    }
  }

  // Handle WebRTC ICE candidate
  Future<void> _handleWebRTCIceCandidate(dynamic candidate, String senderId) async {
    try {
      final pc = _peerConnections[senderId];
      if (pc != null) {
        await pc.addIceCandidate(html.RtcIceCandidate(candidate));
      }
    } catch (e) {
      print('Error handling ICE candidate: $e');
    }
  }

  // Handle rejoin request
  Future<void> _handleRejoinRequest(String callId, String targetId) async {
    try {
      final pc = await _createPeerConnection(targetId);
      _peerConnections[targetId] = pc;

      final offer = await pc.createOffer();
      final offerMap = {
        'type': offer.type,
        'sdp': offer.sdp,
      };
      await pc.setLocalDescription(offerMap);

      _socket!.emit('webrtc-offer', {
        'call_ID': callId,
        'offer': offerMap,
        'senderId': _currentUserId,
      });
    } catch (e) {
      print('Error handling rejoin request: $e');
    }
  }

  // Cleanup resources
  void _cleanup() {
    // Close peer connections
    for (final pc in _peerConnections.values) {
      pc.close();
    }
    _peerConnections.clear();

    // Stop local stream
    if (_localStream != null) {
      for (final track in _localStream!.getTracks()) {
        track.stop();
      }
      _localStream = null;
    }

    // Clear remote streams
    _remoteStreams.clear();

    // Reset state
    _isMuted = false;
    _isVideoOn = false;
  }

  // Disconnect
  void disconnect() {
    _cleanup();
    _socket?.disconnect();
    _socket = null;
    _isConnected = false;
  }

  // Event callbacks
  void onSessionStarted(Function() callback) {
    _onSessionStarted = callback;
  }

  void onCallEnded(Function() callback) {
    _onCallEnded = callback;
  }

  void onParticipantsUpdate(Function(Map<String, dynamic>) callback) {
    _onParticipantsUpdate = callback;
  }

  void onRemoteStream(Function(String, html.MediaStream) callback) {
    _onRemoteStream = callback;
  }

  void onParticipantLeft(Function(String) callback) {
    _onParticipantLeft = callback;
  }
}