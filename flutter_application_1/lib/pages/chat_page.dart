

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/agent.dart';
import 'package:flutter_application_1/services/patient.dart';
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final AgentApi _agentService = AgentApi();
  final PatientApi _patientService = PatientApi();

  List<ChatMessage> messages = [];
  bool loading = false;
  bool showSummary = false;
  Map<String, dynamic>? summaryData;

  String sessionId ="";
  
  String generateSessionId() {
    final now = DateTime.now().millisecondsSinceEpoch; // Current time in ms
    final randomPart = (10000 + (DateTime.now().microsecondsSinceEpoch % 89999)).toString(); // Some microseconds-based randomness
    return now.toString() + randomPart;
  }

  @override
  void initState() {
    super.initState();
    sessionId = generateSessionId();
    _initializeChat();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _initializeChat() async {
    print(sessionId);
    setState(() {
      loading = true;
      messages.clear();
      showSummary = false;
      summaryData = null;
    });

    try {
      await _agentService.startChat(sessionId);
      final questionResponse = await _agentService.getQuestion(sessionId);

      if (questionResponse?['done'] == true) {
        await _fetchSummary();
      } else {
        setState(() {
          messages.add(ChatMessage(text: questionResponse?['question'], isUser: false));
        });
      }
    } catch (e) {
      setState(() {
        messages.add(ChatMessage(text: "Failed to start chat: $e", isUser: false));
      });
    } finally {
      setState(() {
        loading = false;
      });
      _scrollToBottom();
    }
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || loading || showSummary) return;

    setState(() {
      messages.add(ChatMessage(text: text, isUser: true));
      loading = true;
    });

    _messageController.clear();
    _scrollToBottom();

    try {
      await _agentService.respondToChat(sessionId, text);
      final questionResponse = await _agentService.getQuestion(sessionId);

      if (questionResponse?['done'] == true) {
        await _fetchSummary();
      } else {
        setState(() {
          messages.add(ChatMessage(text: questionResponse?['question'], isUser: false));
        });
      }
    } catch (e) {
      setState(() {
        messages.add(ChatMessage(text: "Error: $e", isUser: false));
      });
    } finally {
      setState(() {
        loading = false;
      });
      _scrollToBottom();
    }
  }

  Future<void> _fetchSummary() async {
    setState(() {
      loading = true;
    });

    try {
      final summary = await _agentService.getSummary(sessionId);
      setState(() {
        summaryData = summary;
        showSummary = true;
      });
    } catch (e) {
      setState(() {
        messages.add(ChatMessage(text: "Failed to fetch summary: $e", isUser: false));
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    if (showSummary) {
      return _buildSummaryScreen();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFEAECEC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F2937),
        title: const Text('ChatBot'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: messages.length + (loading ? 1 : 0),
              itemBuilder: (context, index) {
                if (loading && index == messages.length) {
                  return _buildLoadingMessage();
                }
                return ChatBubble(message: messages[index]);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildLoadingMessage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFF4ECDC4),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.smart_toy, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 8),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Loading...',
              style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Color(0xFF1F2937),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Type Something...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onSubmitted: (_) => _sendMessage(),
                enabled: !loading,
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Color(0xFF4ECDC4), size: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryScreen() {
    if (summaryData == null) {
      return const Scaffold(
        body: Center(child: Text("No summary available")),
      );
    }

    var probablePreference = summaryData!['most_probable_status'] ?? 'Unknown';
    final finalScores = summaryData!['final_scores'] ?? {};

      if(probablePreference =="Normal")
        probablePreference = "General Psychological Support";
      if(probablePreference =="Mood and Anxiety Disorders")
        probablePreference = "Mood and Anxiety Disorder Specialist";
      if(probablePreference =="Depression and Suicidal")
        probablePreference = "Clinical Depression and Crisis Prevention Specialist";

      final result = _patientService.changeTherapistPreference(probablePreference);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
        backgroundColor: const Color(0xFF1F2937),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "After analyzing your text, the most probable type you need is $probablePreference",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: finalScores.entries
                    .map<Widget>((e) => ListTile(
                          title: Text(e.key),
                          trailing: Text(e.value.toString()),
                        ))
                    .toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                int count = 0;
                Navigator.popUntil(context, (route) {
                  return count++ == 2; // pop until 2 pops have been done
                });
              },
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({
    required this.text,
    required this.isUser,
  });
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xFF4ECDC4),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.smart_toy, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser ? const Color(0xFF4ECDC4) : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: isUser ? Colors.white : Colors.black87,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: Color(0xFF1F2937),
                size: 18,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
