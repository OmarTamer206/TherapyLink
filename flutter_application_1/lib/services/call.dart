import 'package:socket_io_client/socket_io_client.dart' as IO;

class CallApi {
  static final CallApi _instance = CallApi._internal();
  factory CallApi() => _instance;
  late IO.Socket socket;

  CallApi._internal();

  void connect() {
    socket = IO.io(
      'http://localhost:3000', // Use your backend address
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
    socket.connect();
    socket.onConnect((_) => print('Connected to call server'));
    socket.onDisconnect((_) => print('Disconnected from call server'));
  }

  void disconnect() {
    socket.disconnect();
  }

  void joinCall(String callID, String userId, String userType, String userName) {
    socket.emit('joinCall', {
      'call_ID': callID,
      'userId': userId,
      'userType': userType,
      'userName': userName
    });
  }

  void checkCallStatus(String callID, String userId, Function(bool allowed) callback) {
    socket.emitWithAck('checkCallStatus', {
      'call_ID': callID,
      'userId': userId,
    }, ack: (response) {
      callback(response['rejoinAllowed'] ?? false);
    });
  }

  void startSession(String callID, String sessionType, int durationMinutes) {
    socket.emit('startSession', {
      'call_ID': callID,
      'session_type': sessionType,
      'durationMinutes': durationMinutes
    });
  }

  void toggleMute(String callID, String userId, bool muted) {
    socket.emit('toggleMute', {
      'call_ID': callID,
      'userId': userId,
      'muted': muted
    });
  }

  void toggleVideo(String callID, String userId, bool videoOn) {
    socket.emit('toggleVideo', {
      'call_ID': callID,
      'userId': userId,
      'videoOn': videoOn
    });
  }

  void leaveCall(String callID, String userId) {
    socket.emit('leaveCall', {
      'call_ID': callID,
      'userId': userId,
    });
  }

  void endCall(String callID, String userId) {
    socket.emit('endCall', {
      'call_ID': callID,
      'userId': userId,
    });
  }

  void sendOffer(String callID, String senderId, dynamic offer) {
    socket.emit('webrtc-offer', {
      'call_ID': callID,
      'offer': offer,
      'senderId': senderId
    });
  }

  void sendAnswer(String callID, String senderId, dynamic answer) {
    socket.emit('webrtc-answer', {
      'call_ID': callID,
      'answer': answer,
      'senderId': senderId
    });
  }

  void sendIceCandidate(String callID, String senderId, dynamic candidate) {
    socket.emit('webrtc-ice-candidate', {
      'call_ID': callID,
      'candidate': candidate,
      'senderId': senderId
    });
  }

  void onParticipantsUpdate(Function(Map<String, dynamic>) handler) {
    socket.on('participantsUpdate', (data) => handler(Map<String, dynamic>.from(data)));
  }

  void onCallEnded(Function() handler) {
    socket.on('callEnded', (_) => handler());
  }

  void onSessionStarted(Function() handler) {
    socket.on('sessionStarted', (_) => handler());
  }

  void onOffer(Function(dynamic) handler) {
    socket.on('webrtc-offer', handler);
  }

  void onAnswer(Function(dynamic) handler) {
    socket.on('webrtc-answer', handler);
  }

  void onIceCandidate(Function(dynamic) handler) {
    socket.on('webrtc-ice-candidate', handler);
  }

  void onRejoinRequest(Function(dynamic) handler) {
    socket.on('rejoinRequest', handler);
  }
}
