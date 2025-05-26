import 'package:flutter/material.dart';
import 'life_coach_review.dart'; // Import the life_coach_review.dart page

class GroupSessionsPage extends StatelessWidget {
  const GroupSessionsPage({super.key});

  final List<Map<String, dynamic>> lifeCoaches = const [
    {"name": "Dr. Mark", "rating": 4.5},
    {"name": "Dr. Mohamed", "rating": 3.5},
    {"name": "Dr. Hossam", "rating": 3.5},
    {"name": "Dr. Mostafa", "rating": 3.5},
    {"name": "Dr. Lara", "rating": 4.5},
    {"name": "Dr. Mariam", "rating": 4.5},
    {"name": "Dr. Steve", "rating": 4.5},
    {"name": "Dr. Jasmine", "rating": 3.5},
    {"name": "Dr. Carmen", "rating": 3.5},
    {"name": "Dr. Sera", "rating": 4.5},
    {"name": "Dr. Marven", "rating": 4.5},
    {"name": "Dr. Karla", "rating": 3.5},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF0F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFF0F4),
        elevation: 0,
        title: const Text(
          'Life Coaches',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Our Life Coaches',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: lifeCoaches.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 20,
                  color: Colors.teal,
                ),
                itemBuilder: (context, index) {
                  final coach = lifeCoaches[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            coach['name'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.black,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              coach['rating'].toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        TextButton(
                          onPressed: () {
                            // Navigate to the life coach review page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LifeCoachReviewPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'View Coach',
                            style: TextStyle(
                              color: Color.fromARGB(255, 24, 41, 125),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
