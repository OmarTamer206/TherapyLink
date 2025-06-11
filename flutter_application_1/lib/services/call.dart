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
  bool _isDisposed = false; // Add flag to track disposal state

  StreamController<Map<String, dynamic>>? _participantsUpdateController;
  StreamController<void>? _callEndedController;
  StreamController<void>? _sessionStartedController;
  StreamController<MapEntry<String, html.MediaStream>>? _remoteStreamController;
  StreamController<String>? _participantLeftController;

  // Initialize controllers
  void _initializeControllers() {
    if (_isDisposed) return;
    
    _participantsUpdateController?.close();
    _callEndedController?.close();
    _sessionStartedController?.close();
    _remoteStreamController?.close();
    _participantLeftController?.close();
    
    _participantsUpdateController = StreamController<Map<String, dynamic>>.broadcast();
    _callEndedController = StreamController<void>.broadcast();
    _sessionStartedController = StreamController<void>.broadcast();
    _remoteStreamController = StreamController<MapEntry<String, html.MediaStream>>.broadcast();
    _participantLeftController = StreamController<String>.broadcast();
  }

  // Getters
  bool get isConnected => _isConnected;
  bool get isMuted => _isMuted;
  bool get isVideoOn => _isVideoOn;
  html.MediaStream? get localStream => _localStream;
  Map<String, html.MediaStream> get remoteStreams => _remoteStreams;

  // Stream getters for better state management
  Stream<Map<String, dynamic>> get participantsUpdateStream => 
      _participantsUpdateController?.stream ?? Stream.empty();
  Stream<void> get callEndedStream => 
      _callEndedController?.stream ?? Stream.empty();
  Stream<void> get sessionStartedStream => 
      _sessionStartedController?.stream ?? Stream.empty();
  Stream<MapEntry<String, html.MediaStream>> get remoteStreamStream => 
      _remoteStreamController?.stream ?? Stream.empty();
  Stream<String> get participantLeftStream => 
      _participantLeftController?.stream ?? Stream.empty();

  // Safe method to add events to controllers
  void _safeAddToController<T>(StreamController<T>? controller, T event) {
    try {
      if (!_isDisposed && controller != null && !controller.isClosed) {
        controller.add(event);
      }
    } catch (e) {
      print('Error adding to controller: $e');
      // Silently handle the error to prevent crashes
    }
  }

  // Connect to socket
  void connect() {
    if (_socket?.connected == true) return;
    
    _isDisposed = false;
    _initializeControllers();
    
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

  void _setupEventListeners() {
    _socket!.on('sessionStarted', (data) {
      if (_isDisposed) return;
      print('Session started event received: $data');
      _onSessionStarted?.call();
      _safeAddToController(_sessionStartedController, null);
    });

    _socket!.on('callEnded', (data) {
      if (_isDisposed) return;
      print('Call ended event received: $data');
      _onCallEnded?.call();
      _safeAddToController(_callEndedController, null);
      // Call cleanup after emitting the event
      _cleanup();
    });

    _socket!.on('participantsUpdate', (data) {
      if (_isDisposed) return;
      print('Participants update received: $data');
      final map = Map<String, dynamic>.from(data);
      _onParticipantsUpdate?.call(map);
      _safeAddToController(_participantsUpdateController, map);
    });

    _socket!.on('userJoined', (data) {
      if (_isDisposed) return;
      print('User joined: $data');
      final userId = data['userId'].toString();
      // Initiate WebRTC connection for new user
      if (userId != _currentUserId) {
        _initiateWebRTCConnection(userId);
      }
    });

    _socket!.on('userLeft', (data) {
      if (_isDisposed) return;
      print('User left: $data');
      final userId = data['userId'].toString();
      _handleUserLeft(userId);
    });

    _socket!.on('webrtc-offer', (data) {
      print('WebRTC offer received from: ${data['senderId']}');
      _handleWebRTCOffer(Map<String, dynamic>.from(data['offer']), data['senderId'].toString());
    });

    _socket!.on('webrtc-answer', (data) {
      print('WebRTC answer received from: ${data['senderId']}');
      _handleWebRTCAnswer(Map<String, dynamic>.from(data['answer']), data['senderId'].toString());
    });

    _socket!.on('webrtc-ice-candidate', (data) {
      print('ICE candidate received from: ${data['senderId']}');
      _handleWebRTCIceCandidate(Map<String, dynamic>.from(data['candidate']), data['senderId'].toString());
    });

    _socket!.on('rejoinRequest', (data) {
      print('Rejoin request received: $data');
      _handleRejoinRequest(data['call_ID'].toString(), data['targetId'].toString());
    });

    // Add error handling
    _socket!.on('error', (data) {
      print('Socket error: $data');
    });

    _socket!.on('connect_error', (data) {
      print('Socket connection error: $data');
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
      
      // Wait a bit for other participants to be ready
      await Future.delayed(Duration(milliseconds: 500));
      
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

  // Initiate WebRTC connection (for when a new user joins)
  Future<void> _initiateWebRTCConnection(String targetUserId) async {
    try {
      print('Initiating WebRTC connection with: $targetUserId');
      final pc = await _createPeerConnection(targetUserId);
      _peerConnections[targetUserId] = pc;

      final offer = await pc.createOffer();
      final offerMap = {
        'type': offer.type,
        'sdp': offer.sdp,
      };
      await pc.setLocalDescription(offerMap);

      _socket!.emit('webrtc-offer', {
        'call_ID': _currentCallId,
        'offer': offerMap,
        'senderId': _currentUserId,
        'targetId': targetUserId,
      });
    } catch (e) {
      print('Error initiating WebRTC connection: $e');
    }
  }

  // Handle user left
  void _handleUserLeft(String userId) {
    if (_isDisposed) return;
    _peerConnections[userId]?.close();
    _peerConnections.remove(userId);
    _remoteStreams.remove(userId);
    _onParticipantLeft?.call(userId);
    _safeAddToController(_participantLeftController, userId);
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
        {'urls': 'stun:stun1.l.google.com:19302'},
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
      if (_isDisposed) return;
      print('Remote track received from: $peerId');
      final stream = event.streams!.first;
      _remoteStreams[peerId] = stream;
      _onRemoteStream?.call(peerId, stream);
      _safeAddToController(_remoteStreamController, MapEntry(peerId, stream));
    });

    // Handle ICE candidates
    pc.onIceCandidate.listen((event) {
      if (event.candidate != null) {
        print('Sending ICE candidate to: $peerId');
        _socket!.emit('webrtc-ice-candidate', {
          'call_ID': _currentCallId,
          'candidate': {
            'candidate': event.candidate!.candidate,
            'sdpMLineIndex': event.candidate!.sdpMLineIndex,
            'sdpMid': event.candidate!.sdpMid,
          },
          'senderId': _currentUserId,
          'targetId': peerId,
        });
      }
    });

    // Handle connection state changes
    pc.onConnectionStateChange.listen((event) {
      print('Connection state changed for $peerId: ${pc.connectionState}');
    });

    return pc;
  }

  // Handle WebRTC offer
  Future<void> _handleWebRTCOffer(dynamic offer, String senderId) async {
    try {
      print('Handling WebRTC offer from: $senderId');
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
        'targetId': senderId,
      });
    } catch (e) {
      print('Error handling WebRTC offer: $e');
    }
  }

  // Handle WebRTC answer
  Future<void> _handleWebRTCAnswer(dynamic answer, String senderId) async {
    try {
      print('Handling WebRTC answer from: $senderId');
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
      print('Handling ICE candidate from: $senderId');
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
      print('Handling rejoin request for: $targetId');
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
        'targetId': targetId,
      });
    } catch (e) {
      print('Error handling rejoin request: $e');
    }
  }

  // Cleanup resources (but don't close controllers here)
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

  // Disconnect - only close controllers here
  void disconnect() {
    _isDisposed = true;
    _cleanup();
    _socket?.disconnect();
    _socket = null;
    _isConnected = false;
    
  // In the disconnect method, add this before closing controllers:
_socket?.off('sessionStarted');
_socket?.off('callEnded'); 
_socket?.off('participantsUpdate');
_socket?.off('userJoined');
_socket?.off('userLeft');
_socket?.off('webrtc-offer');
_socket?.off('webrtc-answer');
_socket?.off('webrtc-ice-candidate');
_socket?.off('rejoinRequest');
_socket?.off('error');
_socket?.off('connect_error');

    // Close streams only when disconnecting
    _participantsUpdateController?.close();
    _callEndedController?.close();
    _sessionStartedController?.close();
    _remoteStreamController?.close();
    _participantLeftController?.close();
    
    // Null them out to prevent further use
    _participantsUpdateController = null;
    _callEndedController = null;
    _sessionStartedController = null;
    _remoteStreamController = null;
    _participantLeftController = null;
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