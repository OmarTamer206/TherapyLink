import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/chat.dart';

class ChatWidget extends StatefulWidget {
  final String chatId;
  final String userId;
  final String userType;
  final String receiverId;
  final String receiverType;

  const ChatWidget({
    Key? key,
    required this.chatId,
    required this.userId,
    required this.userType,
    required this.receiverId,
    required this.receiverType,
  }) : super(key: key);

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final ChatSocketService _chatSocketService = ChatSocketService();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();

  List<dynamic> messages = [];
  String typingStatus = '';
  bool sessionStarted = false;
  bool sessionEnded = false;

  @override
  void initState() {
    super.initState();
    _chatSocketService.connect();
    _chatSocketService.enterChat(widget.chatId, widget.userId, widget.userType);

    _chatSocketService.onPreviousMessages((data) {
      setState(() {
        messages = data;
      });
      _scrollToBottom();
    });

    _chatSocketService.onSystemMessage((msg) {
      setState(() {
        messages.add(msg);
      });
      _scrollToBottom();
    });

    _chatSocketService.onMessage((msg) {
      setState(() {
        messages.add(msg);
      });
      _scrollToBottom();
    });

    _chatSocketService.onTyping((data) {
      setState(() {
        typingStatus = data['typing'] ? '${data['userName']} is typing...' : '';
      });
    });

    _chatSocketService.onSessionStart(() {
      setState(() {
        sessionStarted = true;
        sessionEnded = false;
      });
    });

    _chatSocketService.onSessionEnded(() {
      setState(() {
        sessionEnded = true;
        sessionStarted = false;
      });
    });

    _chatSocketService.onErrorChat((msg) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Chat error: $msg')));
    });
  }

  @override
  void dispose() {
    _chatSocketService.exitChat(widget.chatId, widget.userId);
    _chatSocketService.disconnect();
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty || sessionEnded) return;

    _chatSocketService.sendMessage(
      widget.chatId,
      widget.userId,
      widget.userType,
      widget.receiverId,
      widget.receiverType,
      message,
    );
    _messageController.clear();
    _chatSocketService.stopTyping(widget.chatId, widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Chat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        if (typingStatus.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(typingStatus, style: const TextStyle(fontStyle: FontStyle.italic)),
          ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final msg = messages[index];
              final isSystem = msg['senderType'] == 'system';
              final isSelf = msg['senderId'] == widget.userId;

              return Align(
                alignment: isSystem
                    ? Alignment.center
                    : isSelf
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSystem
                        ? Colors.grey[300]
                        : isSelf
                            ? Colors.blue[100]
                            : Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isSystem) Text('${msg['senderName']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(msg['message']),
                      if (!isSystem)
                        Text(msg['timestamp'] ?? '',
                            style: const TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        if (!sessionEnded)
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  onChanged: (_) => _chatSocketService.typing(widget.chatId, widget.userId),
                  onEditingComplete: () => _chatSocketService.stopTyping(widget.chatId, widget.userId),
                  decoration: const InputDecoration(hintText: 'Type a message...'),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ],
          ),
        if (sessionEnded)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('The session has ended. Chat is closed.',
                style: TextStyle(color: Colors.grey)),
          ),
      ],
    );
  }
}
