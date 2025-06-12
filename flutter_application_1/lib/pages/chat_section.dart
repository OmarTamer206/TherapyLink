import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';

class ChatWidget extends StatefulWidget {
  final String chatId;
  final String userId;
  final String userType;
  final String receiverId;
  final String receiverType;
  final String serverUrl;

  const ChatWidget({
    Key? key,
    required this.chatId,
    required this.userId,
    required this.userType,
    required this.receiverId,
    required this.receiverType,
    this.serverUrl = 'http://localhost:3000',
  }) : super(key: key);

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  // Socket connection
  IO.Socket? _socket;
  
  // UI Controllers
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  // State variables
  List<Map<String, dynamic>> _messages = [];
  String _typingStatus = '';
  bool _sessionStarted = false;
  bool _sessionEnded = false;
  bool _isSendDisabled = true;
  
  List<StreamSubscription> _subscriptions = [];
  Timer? _typingTimer;

  // Socket connection status
  bool get isConnected => _socket?.connected ?? false;

  @override
  void initState() {
    super.initState();
    print("Chat initialized: ${widget.chatId}, ${widget.userId}, ${widget.userType}, ${widget.receiverId}");
    _initializeChat();
  }

  void _initializeChat() {
    _connectSocket();
    // Don't call _enterChat() here, it will be called after connection
  }

  void _connectSocket() {
    if (_socket != null && _socket!.connected) {
      _socket!.clearListeners();
    _socket!.disconnect();
    _socket = null;
      return;
    }

    _socket = IO.io(widget.serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    _setupSocketEventListeners();

    _socket!.onConnect((_) {
      print('Socket connected: ${_socket!.id}');
    _enterChat();
    });

    _socket!.onDisconnect((_) {
      print('Socket disconnected');
      _socket!.clearListeners();
    _socket!.disconnect();
    _socket = null;
    });
  }

  void _setupSocketEventListeners() {
    _socket!.on('receiveMessage', (data) {
      print('Received message: $data');
      setState(() {
        _messages.add(Map<String, dynamic>.from(data));
      });
      _scrollToBottom();
    });

    _socket!.on('previousMessages', (data) {
      print('Received previous messages: ${data.length} messages');
      final messages = List<Map<String, dynamic>>.from(
        data.map((msg) => Map<String, dynamic>.from(msg))
      );
      setState(() {
        _messages = [...messages];
      });
      _scrollToBottom();
    });

    _socket!.on('systemMessage', (data) {
      print('Received system message: $data');
      try {
        Map<String, dynamic> systemMessage;
        if (data is List && data.isNotEmpty) {
          systemMessage = Map<String, dynamic>.from(data[0]);
        } else if (data is Map) {
          systemMessage = Map<String, dynamic>.from(data);
        } else {
          print('Unexpected system message format: $data');
          return;
        }
        
        setState(() {
          _messages.add(systemMessage);
        });
        _scrollToBottom();
      } catch (e) {
        print('Error processing system message: $e');
      }
    });

    _socket!.on('participantTyping', (data) {
      print('Typing status received: $data');
      try {
        Map<String, dynamic> typingData;
        if (data is List && data.isNotEmpty) {
          typingData = Map<String, dynamic>.from(data[0]);
        } else if (data is Map) {
          typingData = Map<String, dynamic>.from(data);
        } else {
          print('Unexpected typing data format: $data');
          return;
        }
        
        // Only show typing status for other users, not yourself
        if (typingData['userId'] != widget.userId) {
          setState(() {
            _typingStatus = typingData['typing'] == true 
                ? '${typingData['userName'] ?? 'Someone'} is typing...' 
                : '';
          });
        }
      } catch (e) {
        print('Error processing typing status: $e');
      }
    });

    _socket!.on('sessionStart', (_) {
      print('Session started');
      setState(() {
        _sessionStarted = true;
        _sessionEnded = false;
      });
    });

    _socket!.on('sessionEnded', (_) {
      print('Session ended');
      setState(() {
        _sessionEnded = true;
        _sessionStarted = false;
      });
    });

    _socket!.on('errorChat', (data) {
      print('Chat error: $data');
      _showErrorDialog('Chat error: ${data.toString()}');
    });
  }

  // Socket emit methods
  void _enterChat() {
    if (!isConnected) {
      print('Cannot enter chat: Socket not connected');
      return;
    }
    
    print('Entering chat room: ${widget.chatId}');
    _socket?.emit('enterChat', {
      'chatId': widget.chatId,
      'userId': widget.userId,
      'userType': widget.userType,
    });
  }

  void _exitChat() {
    _socket?.emit('exitChat', {
      'chatId': widget.chatId,
      'userId': widget.userId,
    });
  }

  void _sendSocketMessage({
    required String chatId,
    required String senderId,
    required String senderType,
    required String receiverId,
    required String receiverType,
    required String message,
  }) {
    if (!isConnected) {
      print('Cannot send message: Socket not connected');
      _showErrorDialog('Connection lost. Please try again.');
      return;
    }
    
    print('Sending message: $message');
    _socket?.emit('sendMessage', {
      'chatId': chatId,
      'senderId': senderId,
      'senderType': senderType,
      'receiverId': receiverId,
      'receiverType': receiverType,
      'message': message,
    });
  }

  void _emitTyping() {
    if (!isConnected) return;
    
    _socket?.emit('typing', {
      'chatId': widget.chatId,
      'userId': widget.userId,
      'userType': widget.userType,
    });
  }

  void _emitStopTyping() {
    if (!isConnected) return;
    
    _socket?.emit('stopTyping', {
      'chatId': widget.chatId,
      'userId': widget.userId,
    });
  }

  void _patientReady() {
    _socket?.emit('patientReady', {
      'chatId': widget.chatId,
    });
  }

  void _doctorReady(int sessionDurationMinutes) {
    _socket?.emit('doctorReady', {
      'chatId': widget.chatId,
      'sessionDurationMinutes': sessionDurationMinutes,
    });
  }

  void _doctorEndSession() {
    _socket?.emit('doctorEndSession', {
      'chatId': widget.chatId,
      'userId': widget.userId,
    });
  }

  void _disconnectSocket() {
    if (_socket != null) {
      _socket!.disconnect();
      _socket = null;
      print('Socket disconnected');
    }
  }

  // UI Event Handlers
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _onInputChange(String value) {
    setState(() {
      _isSendDisabled = value.trim().isEmpty;
    });
  }

  void _onTyping() {
    _emitTyping();
    
    // Cancel previous timer and set new one
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 2), () {
      _emitStopTyping();
    });
  }

  void _stopTyping() {
    _typingTimer?.cancel();
    _emitStopTyping();
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty || _sessionEnded) return;

    _sendSocketMessage(
      chatId: widget.chatId,
      senderId: widget.userId,
      senderType: widget.userType,
      receiverId: widget.receiverId,
      receiverType: widget.receiverType,
      message: message,
    );

    _messageController.clear();
    setState(() {
      _isSendDisabled = true;
    });
    _stopTyping();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> msg) {
    final isSystem = msg['senderType'] == 'system';
    final isSent = msg['senderId'] == widget.userId && !isSystem;
    final isReceived = msg['senderId'] != widget.userId && !isSystem;

    if (isSystem) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              msg['message'],
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        mainAxisAlignment: isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSent ? Colors.blue[500] : Colors.grey[300],
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isSystem && msg['senderName'] != null)
                    Text(
                      msg['senderName'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSent ? Colors.white : Colors.black87,
                        fontSize: 12,
                      ),
                    ),
                  const SizedBox(height: 2),
                  Text(
                    msg['message'],
                    style: TextStyle(
                      color: isSent ? Colors.white : Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!isSystem)
                        Text(
                          msg['senderType'] ?? '',
                          style: TextStyle(
                            color: isSent ? Colors.white70 : Colors.grey[600],
                            fontSize: 10,
                          ),
                        ),
                      const SizedBox(width: 8),
                      Text(
                        _formatTimestamp(msg['timestamp']),
                        style: TextStyle(
                          color: isSent ? Colors.white70 : Colors.grey[600],
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return '';
    
    try {
      DateTime dateTime;
      if (timestamp is String) {
        dateTime = DateTime.parse(timestamp);
      } else if (timestamp is DateTime) {
        dateTime = timestamp;
      } else {
        return '';
      }
      
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat - ${isConnected ? 'Connected' : 'Disconnected'}'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 1,
        bottom: _typingStatus.isNotEmpty
            ? PreferredSize(
                preferredSize: const Size.fromHeight(30),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    children: [
                      Text(
                        _typingStatus,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          if (!_sessionEnded)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          onChanged: _onInputChange,
                          onTap: _onTyping,
                          onEditingComplete: _stopTyping,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: Colors.blue[500]!),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FloatingActionButton(
                        onPressed: _isSendDisabled ? null : _sendMessage,
                        backgroundColor: _isSendDisabled 
                            ? Colors.grey[300] 
                            : Colors.blue[500],
                        mini: true,
                        child: Icon(
                          Icons.send,
                          color: _isSendDisabled ? Colors.grey[600] : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (_sessionEnded)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: const Text(
                'The session has ended. Chat is closed.',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _exitChat();
    for (var subscription in _subscriptions) {
      subscription.cancel();
    }
    _disconnectSocket();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}