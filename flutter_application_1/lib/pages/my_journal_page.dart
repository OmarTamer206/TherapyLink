import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyJournalPage(),
  ));
}

class MyJournalPage extends StatefulWidget {
  const MyJournalPage({super.key});

  @override
  State<MyJournalPage> createState() => _MyJournalPageState();
}

class _MyJournalPageState extends State<MyJournalPage> {
  final List<Map<String, String>> journalEntries = [
    {
      "date": "2/4/2024",
      "text":
          "Today, I realized how much progress I’ve made in managing my anxiety. The breathing exercises my therapist recommended are starting to feel natural, and I’m proud of myself for sticking with them.",
    },
    {
      "date": "3/2/2024",
      "text":
          "I’m grateful for having someone to talk to who truly listens and understands me. My therapist suggested keeping a gratitude list, so here’s my first entry: grateful for sunny mornings, my supportive sister, and cozy blankets.",
    },
    {
      "date": "4/5/2024",
      "text":
          "It was a tough day. My old fears crept back in, and I felt overwhelmed. But I’m reminding myself that healing isn’t linear. It’s okay to have hard days as long as I keep trying. Small wins, but they matter.",
    },
    {
      "date": "6/7/2024",
      "text":
          "I’ve decided to work on setting better boundaries in my relationships. My therapist says this will help me feel more in control and less drained. This week’s goal: say 'no' to things that don’t align with my priorities.",
    },
  ];

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF0F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFF0F4),
        elevation: 0,
        title: const Text(
          'My Journal',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: journalEntries.length,
                itemBuilder: (context, index) {
                  final entry = journalEntries[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              entry['date']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  journalEntries.removeAt(index);
                                });
                              },
                              child: const Icon(Icons.delete_outline,
                                  color: Color(0xFF1F2937)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          entry['text']!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          color: Color(0xFF00B4A6),
                          thickness: 1,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Input Field
      // Input Field (styled like the image)
Container(
  margin: const EdgeInsets.only(bottom: 16),
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Row(
    children: [
      Expanded(
        child: TextField(
          controller: _textController,
          decoration: const InputDecoration(
            hintText: "Type Something...",
            hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Color(0xFF1F2937)),
        ),
      ),
      GestureDetector(
        onTap: () {
          if (_textController.text.trim().isNotEmpty) {
            setState(() {
              journalEntries.add({
                "date": DateTime.now()
                    .toString()
                    .split(" ")
                    .first
                    .replaceAll("-", "/"),
                "text": _textController.text.trim(),
              });
              _textController.clear();
            });
          }
        },
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Color(0xFF00B4A6),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(Icons.send, color: Colors.white, size: 20),
        ),
      ),
    ],
  ),
),

          ],
        ),
      ),
    );
  }
}
