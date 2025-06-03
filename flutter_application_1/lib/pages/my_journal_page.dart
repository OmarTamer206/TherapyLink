import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/patient.dart';

class MyJournalPage extends StatefulWidget {
  const MyJournalPage({super.key});

  @override
  State<MyJournalPage> createState() => _MyJournalPageState();
}

class _MyJournalPageState extends State<MyJournalPage> {
  final PatientApi _patientApi = PatientApi();
  final TextEditingController _textController = TextEditingController();
  List<Map<String, dynamic>> _journalEntries = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchJournals();
  }

  Future<void> _fetchJournals() async {
    final userData = await _patientApi.getProfileData();
    final journals = userData["data"]["journals"];
    print(journals);
    setState(() {
      _journalEntries = List<Map<String, dynamic>>.from(journals);
      print("_journalEntries" + _journalEntries.toString());
      _loading = false;
    });
  }

  Future<void> _addJournalEntry() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    final success = await _patientApi.writeInJournal(text);
    if (success) {
      _textController.clear();
      _fetchJournals(); // Refresh the list
    }
  }

  Future<void> _deleteJournalEntry(int journalId) async {
    final success = await _patientApi.deleteFromJournal("$journalId");
    if (success) {
      _fetchJournals(); // Refresh the list
    }
  }

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
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _journalEntries.isEmpty
                      ? const Center(child: Text("No journal entries yet."))
                      : ListView.builder(
                          itemCount: _journalEntries.length,
                          itemBuilder: (context, index) {
                            final entry = _journalEntries[index];
                            print("entry" + entry.toString());
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
                                        entry['time']
                                            .split("T")[0]
                                            .replaceAll("-", "/"),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Color(0xFF1F2937),
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () =>
                                            _deleteJournalEntry(entry['journal_ID']),
                                        child: const Icon(
                                            Icons.delete_outline,
                                            color: Color(0xFF1F2937)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    entry['journal_content'],
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
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                    onTap: _addJournalEntry,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00B4A6),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(Icons.send,
                          color: Colors.white, size: 20),
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
