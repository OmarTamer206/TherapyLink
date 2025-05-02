import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/custom_icon_button.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({super.key});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          "Possimus ut explicabo non. Suscipit explicabo maiores qui nulla quibusdam distinctio ut. Placeat deserunt iure delectus accusantium architecto nesciunt officiis. Soluta quia quod veritatis ullam sunt earum tenetur et quia. Sed et vitae. Nulla enim inventore rem velit rerum molestiae beatae. Magni suscipit eos et praesentium odio at.",
      isUser: true,
    ),
    ChatMessage(
      text: "Magni suscipit eos et praesentium odio at.",
      isUser: false,
    ),
    ChatMessage(
      text:
          "Iste culpa voluptatum sed earum itaque. Velit cum id consequatur. Blanditiis suscipit facere eveniet sed. Incidunt quod modi illo nesciunt hic possimus. Optio sunt minus consequatur qui ut ut eum suscipit ratione. Cumque aspernatur fugit dolor.",
      isUser: true,
    ),
    ChatMessage(
      text: "Magni suscipit eos et praesentium odio at.",
      isUser: false,
    ),
    ChatMessage(
      text:
          "Iste culpa voluptatum sed earum itaque. Velit cum id consequatur. Blanditiis suscipit facere eveniet sed. Incidunt quod modi illo nesciunt hic possimus. Optio sunt minus consequatur qui ut ut eum suscipit ratione. Cumque aspernatur fugit dolor.",
      isUser: true,
    ),
    ChatMessage(
      text: "Magni suscipit eos et praesentium odio at.",
      isUser: false,
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onErrorContainer, 
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: Container(
              color: appTheme.teal50,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                reverse: false,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessage(_messages[index]);
                },
              ),
            ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: 74,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius:const BorderRadius.vertical(
          top: Radius.circular(0),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'ChatBot',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 41),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: message.isUser
                  ? const Color(0xFF149FA8)
                  :  theme.colorScheme.onErrorContainer,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: message.isUser ? appTheme.black900 : Colors.black,
              ),
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration:const BoxDecoration(
        color: Color(0xFF06303E),
        borderRadius:  BorderRadius.vertical(top: Radius.circular(14)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: appTheme.gray100,
                borderRadius: BorderRadius.circular(28),
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type Something ...',
                  hintStyle: TextStyle(
                    color: appTheme.black900.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
                onSubmitted: _handleSubmitted,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: CustomIconButton(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(8),
              decoration: IconButtonStyleHelper.fillGray,
              onTap: () => _handleSubmitted(_messageController.text),
              child: CustomImageView(
                imagePath: ImageConstant.imgFrame,
              ),
            ),
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

