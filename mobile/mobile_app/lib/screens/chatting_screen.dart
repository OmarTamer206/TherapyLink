import 'package:flutter/material.dart';

class ChatbotInterfaceScreen extends StatefulWidget {
  const ChatbotInterfaceScreen({super.key});

  @override
  State<ChatbotInterfaceScreen> createState() => _ChatbotInterfaceScreenState();
}

class _ChatbotInterfaceScreenState extends State<ChatbotInterfaceScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Magni suscipit eos et praesentium odio et.",
      isUser: false,
    ),
    ChatMessage(
      text:
          "Iste culpa voluptatum sed earum fiaque. Veift cum id consequatur.\n"
          "Blanditis suscipit facere eveniet sed.\n"
          "Incidunt quod modi ibn nesciunt hic posimus. Optio sunt minus consequatur qui ut ut eum suscipit ratione. Cumque aspernatur fugit dolor.",
      isUser: false,
    ),
    ChatMessage(
      text: "Magni suscipit eos et praesentium odio et.",
      isUser: false,
    ),
    ChatMessage(
      text:
          "Iste culpa voluptatum sed earum fiaque. Veift cum id consequatur.\n"
          "Blanditis suscipit facere eveniet sed.\n"
          "Incidunt quod modi ibn nesciunt hic posimus. Optio sunt minus consequatur qui ut ut eum suscipit ratione. Cumque aspernatur fugit dolor.",
      isUser: false,
    ),
    ChatMessage(
      text: "Magni suscipit eos et praesentium odio et.",
      isUser: false,
    ),
    ChatMessage(
      text:
          "Possimus ut explicabo non. Suscipit explicabo maiores qui nulla quibusdam distinctio ut. "
          "Placent deserunt lure delectua accusantium architecto nesciunt officilis. Soluta quia quod veritatis ullam sunt earum tenetur et quia. "
          "Sed et vitae. Nulla enim indientore rem velit renum molestiae beatae.\n"
          "Magni suscipit eos et praresntium odio et.",
      isUser: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1F1F6),
      appBar: AppBar(
        title: const Text('ChatBot'),
        backgroundColor: const Color(0xFF149FA8),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              reverse: false,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser)
            const CircleAvatar(
              backgroundColor: Color(0xFF149FA8),
              child: Text(
                'B',
                style: TextStyle(color: Colors.white),
              ),
            ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: message.isUser ? const Color(0xFF149FA8) : Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type Something .......',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onSubmitted: _handleSubmitted,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Color(0xFF149FA8)),
            onPressed: () => _handleSubmitted(_messageController.text),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
      ));
    });

    _messageController.clear();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}
