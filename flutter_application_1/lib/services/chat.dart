import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatSocketService {
  late IO.Socket socket;

  void connect() {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
  }

  void disconnect() {
    socket.disconnect();
  }

  void enterChat(String chatId, String userId, String userType) {
    socket.emit('enterChat', {
      'chatId': chatId,
      'userId': userId,
      'userType': userType,
    });
  }

  void exitChat(String chatId, String userId) {
    socket.emit('exitChat', {
      'chatId': chatId,
      'userId': userId,
    });
  }

  void sendMessage(String chatId, String senderId, String senderType,
      String receiverId, String receiverType, String message) {
    socket.emit('sendMessage', {
      'chatId': chatId,
      'senderId': senderId,
      'senderType': senderType,
      'receiverId': receiverId,
      'receiverType': receiverType,
      'message': message,
    });
  }

  void typing(String chatId, String userId) {
    socket.emit('typing', {
      'chatId': chatId,
      'userId': userId,
    });
  }

  void stopTyping(String chatId, String userId) {
    socket.emit('stopTyping', {
      'chatId': chatId,
      'userId': userId,
    });
  }

  void patientReady(String chatId) {
    socket.emit('patientReady', {'chatId': chatId});
  }

  void doctorReady(String chatId, int sessionDurationMinutes) {
    socket.emit('doctorReady', {
      'chatId': chatId,
      'sessionDurationMinutes': sessionDurationMinutes,
    });
  }

  void doctorEndSession(String chatId, String userId) {
    socket.emit('doctorEndSession', {
      'chatId': chatId,
      'userId': userId,
    });
  }

  void onMessage(Function(dynamic) callback) {
    socket.on('receiveMessage', callback);
  }

 void onPreviousMessages(void Function(List<dynamic>) callback) {
  socket.on('previousMessages', (dynamic data) {
    if (data is List<dynamic>) {
      callback(data);
    }
  });
}

  void onSystemMessage(Function(dynamic) callback) {
    socket.on('systemMessage', callback);
  }

  void onTyping(Function(dynamic) callback) {
    socket.on('participantTyping', callback);
  }

  void onSessionStart(Function() callback) {
    socket.on('sessionStart', (_) => callback());
  }

  void onSessionEnded(Function() callback) {
    socket.on('sessionEnded', (_) => callback());
  }

void onErrorChat(void Function(String) callback) {
  socket.on('errorChat', (dynamic data) {
    if (data is String) {
      callback(data);
    }
  });
}
}
