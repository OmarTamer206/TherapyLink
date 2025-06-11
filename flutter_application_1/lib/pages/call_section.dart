import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_application_1/services/chat.dart';

class ChatWidget extends StatefulWidget {
  final String chatId;
  final String userId;
  final String userType;
  final String receiverId;
  final String receiverType;
  final String? serverUrl;

  const ChatWidget({
    Key? key,
    required this.chatId,
    required this.userId,
    required this.userType,
    required this.receiverId,
    required this.receiverType,
    this.serverUrl,
  }) : super(key: key);

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  List<Map<String, dynamic>> _messages = [];
  String _typingStatus = '';
  bool _sessionStarted = false;
  bool _sessionEnded = false;
  bool _isSendDisabled = true;
  bool _isConnected = false;
  
  List<StreamSubscription> _subscriptions = [];
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() {
    print('Initializing chat with chatId: ${widget.chatId}, userId: ${widget.userId}, userType: ${widget.userType}');
    
    // Connect to socket first
    _chatService.connect(serverUrl: widget.serverUrl ?? 'http://localhost:3000');
    
    // Set up listeners before entering chat
    _setupListeners();
    
    // Monitor connection status
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_chatService.isConnected && !_isConnected) {
        setState(() {
          _isConnected = true;
        });
        print('Socket connected, entering chat...');
        // Enter chat once connected
        _chatService.enterChat(widget.chatId, widget.userId, widget.userType);
        timer.cancel();
      } else if (timer.tick > 10) { // Stop trying after 5 seconds
        timer.cancel();
        if (!_isConnected) {
          _showErrorDialog('Failed to connect to server');
        }
      }
    });
  }

  void _setupListeners() {
    // Previous messages
    _subscriptions.add(
      _chatService.onPreviousMessages.listen((prevMessages) {
        print('Setting previous messages: ${prevMessages.length}');
        setState(() {
          _messages = [...prevMessages];
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
      })
    );

    // System messages
    _subscriptions.add(
      _chatService.onSystemMessage.listen((msg) {
        print('Adding system message: ${msg['message']}');
        setState(() {
          _messages.add(msg);
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
      })
    );

    // Regular messages
    _subscriptions.add(
      _chatService.onMessage.listen((msg) {
        print('Adding new message: ${msg['message']}');
        setState(() {
          _messages.add(msg);
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
      })
    );

    // Typing status
    _subscriptions.add(
      _chatService.onTyping.listen((data) {
        print('Typing data received: $data');
        // Only show typing indicator if it's not from current user
        if (data['userId'] != widget.userId) {
          setState(() {
            _typingStatus = data['typing'] == true 
                ? '${data['userName']} is typing...' 
                : '';
          });
        }
      })
    );

    // Session start
    _subscriptions.add(
      _chatService.onSessionStart.listen((_) {
        print('Session started event received');
        setState(() {
          _sessionStarted = true;
          _sessionEnded = false;
        });
      })
    );

    // Session ended
    _subscriptions.add(
      _chatService.onSessionEnded.listen((_) {
        print('Session ended event received');
        setState(() {
          _sessionEnded = true;
          _sessionStarted = false;
        });
      })
    );

    // Error handling
    _subscriptions.add(
      _chatService.onErrorChat.listen((errorMsg) {
        print('Chat error received: $errorMsg');
        _showErrorDialog('Chat error: $errorMsg');
      })
    );
  }

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
    _chatService.typing(widget.chatId, widget.userId, widget.userType);
    
    // Cancel previous timer and set new one
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 2), () {
      _chatService.stopTyping(widget.chatId, widget.userId);
    });
  }

  void _stopTyping() {
    _typingTimer?.cancel();
    _chatService.stopTyping(widget.chatId, widget.userId);
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty || _sessionEnded) return;

    print('Sending message: $message');
    _chatService.sendMessage(
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
        title: Row(
          children: [
            const Text('Chat'),
            const SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _isConnected ? Colors.green : Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
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
    _chatService.exitChat(widget.chatId, widget.userId);
    for (var subscription in _subscriptions) {
      subscription.cancel();
    }
    _chatService.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}