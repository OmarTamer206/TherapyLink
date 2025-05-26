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
      appBar: AppBar(
        title: const Text('My Journal'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);  // Handles the back button
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
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          entry['text']!,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          color: Colors.teal,
                          thickness: 1,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Input Field
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
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send,
                        color: Color.fromARGB(255, 24, 41, 125)),
                    onPressed: () {
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
