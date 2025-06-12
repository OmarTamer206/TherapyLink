import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  IO.Socket? _socket;

  // Stream controllers for different events
  final StreamController<Map<String, dynamic>> _messageController = StreamController.broadcast();
  final StreamController<List<Map<String, dynamic>>> _previousMessagesController = StreamController.broadcast();
  final StreamController<Map<String, dynamic>> _systemMessageController = StreamController.broadcast();
  final StreamController<Map<String, dynamic>> _typingController = StreamController.broadcast();
  final StreamController<void> _sessionStartController = StreamController.broadcast();
  final StreamController<void> _sessionEndedController = StreamController.broadcast();
  final StreamController<String> _errorChatController = StreamController.broadcast();

  // Getters for streams
  Stream<Map<String, dynamic>> get onMessage => _messageController.stream;
  Stream<List<Map<String, dynamic>>> get onPreviousMessages => _previousMessagesController.stream;
  Stream<Map<String, dynamic>> get onSystemMessage => _systemMessageController.stream;
  Stream<Map<String, dynamic>> get onTyping => _typingController.stream;
  Stream<void> get onSessionStart => _sessionStartController.stream;
  Stream<void> get onSessionEnded => _sessionEndedController.stream;
  Stream<String> get onErrorChat => _errorChatController.stream;

  bool get isConnected => _socket?.connected ?? false;

  void connect({String serverUrl = 'http://localhost:3000'}) {
    if (_socket != null && _socket!.connected) {
      print('Socket already connected');
      return;
    }

    _socket = IO.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true, // <-- Enable auto connect
    });

    _setupEventListeners(); // Moved here before connect

    _socket!.onConnect((_) {
      print('Socket connected: ${_socket!.id}');
    });

    _socket!.onDisconnect((_) {
      print('Socket disconnected');
    });
  }

  void disconnect() {
    if (_socket != null) {
      _socket!.disconnect();
      _socket = null;
      print('Socket disconnected');
    }
  }

  void _setupEventListeners() {
    _socket!.on('receiveMessage', (data) {
      print('Received message: $data');
      _messageController.add(Map<String, dynamic>.from(data));
    });

    _socket!.on('previousMessages', (data) {
      print('Received previous messages: ${data.length} messages');
      final messages = List<Map<String, dynamic>>.from(
        data.map((msg) => Map<String, dynamic>.from(msg))
      );
      _previousMessagesController.add(messages);
    });

    _socket!.on('systemMessage', (data) {
      print('Received system message: $data');
      _systemMessageController.add(Map<String, dynamic>.from(data));
    });

    _socket!.on('participantTyping', (data) {
      print('Typing status: $data');
      _typingController.add(Map<String, dynamic>.from(data));
    });

    _socket!.on('sessionStart', (_) {
      print('Session started');
      _sessionStartController.add(null);
    });

    _socket!.on('sessionEnded', (_) {
      print('Session ended');
      _sessionEndedController.add(null);
    });

    _socket!.on('errorChat', (data) {
      print('Chat error: $data');
      _errorChatController.add(data.toString());
    });
  }

  // Enter chat with userId and userType
  void enterChat(String chatId, String userId, String userType) {
    _socket?.emit('enterChat', {
      'chatId': chatId,
      'userId': userId,
      'userType': userType,
    });
  }

  // Exit chat
  void exitChat(String chatId, String userId) {
    _socket?.emit('exitChat', {
      'chatId': chatId,
      'userId': userId,
    });
  }

  // Send message with senderId, senderType, and receiver details
  void sendMessage({
    required String chatId,
    required String senderId,
    required String senderType,
    required String receiverId,
    required String receiverType,
    required String message,
  }) {
    _socket?.emit('sendMessage', {
      'chatId': chatId,
      'senderId': senderId,
      'senderType': senderType,
      'receiverId': receiverId,
      'receiverType': receiverType,
      'message': message,
    });
  }

  // Typing indicator
  void typing(String chatId, String userId, String userType) {
    _socket?.emit('typing', {
      'chatId': chatId,
      'userId': userId,
      'userType': userType,
    });
  }

  // Stop typing indicator
  void stopTyping(String chatId, String userId) {
    _socket?.emit('stopTyping', {
      'chatId': chatId,
      'userId': userId,
    });
  }

  // Patient ready
  void patientReady(String chatId) {
    _socket?.emit('patientReady', {
      'chatId': chatId,
    });
  }

  // Doctor ready
  void doctorReady(String chatId, int sessionDurationMinutes) {
    _socket?.emit('doctorReady', {
      'chatId': chatId,
      'sessionDurationMinutes': sessionDurationMinutes,
    });
  }

  // Doctor end session
  void doctorEndSession(String chatId, String userId) {
    _socket?.emit('doctorEndSession', {
      'chatId': chatId,
      'userId': userId,
    });
  }

  // Dispose method to clean up resources
  void dispose() {
    _messageController.close();
    _previousMessagesController.close();
    _systemMessageController.close();
    _typingController.close();
    _sessionStartController.close();
    _sessionEndedController.close();
    _errorChatController.close();
    disconnect();
  }
}
