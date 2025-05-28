import 'package:flutter/material.dart';
import 'life_coach_review.dart';

class GroupSessionsPage extends StatelessWidget {
  const GroupSessionsPage({super.key});

  static const Color mainColor = Color(0xFF1F2937);
  static const Color bgColor = Color(0xFFDFF0F4);

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
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: const Text(
          'Life Coaches',
          style: TextStyle(
            color: mainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: mainColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Our Life Coaches',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: mainColor,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: lifeCoaches.length,
                separatorBuilder: (context, index) => const Divider(height: 16),
                itemBuilder: (context, index) {
                  final coach = lifeCoaches[index];
                  return Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          coach['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: mainColor, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            coach['rating'].toString(),
                            style: const TextStyle(fontSize: 14, color: mainColor),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () {
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
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
