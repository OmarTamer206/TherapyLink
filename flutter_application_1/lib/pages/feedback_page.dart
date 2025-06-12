import 'package:flutter/material.dart';



class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int selectedRating = 0;

  void _showNoRatingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Please Rate the Session"),
          content: const Text("You must rate the session before submitting your feedback."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF0F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFF0F4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Old Sessions',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
    body: Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Column(
    children: [
      const SizedBox(height: 20), // Increased from 10 → pushes "Session With"
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'Session With: Dr. Magdy',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4), // pushes down "30 minutes"
            child: Text('30 minutes'),
          ),
        ],
      ),
      const SizedBox(height: 6),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text('Timing: 9/1/2025 , 7:00 PM'),
      ),
      const SizedBox(height: 40),

      // Feedback Container
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.55, // Bigger container
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.close, size: 24),
            ),
            const SizedBox(height: 10),

            // Star Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  iconSize: 47,
                  onPressed: () {
                    setState(() {
                      selectedRating = index + 1;
                    });
                  },
                  icon: Icon(
                    Icons.star,
                    color: index < selectedRating
                        ? const Color(0xFF00B4A6)
                        : Colors.grey.shade300,
                  ),
                );
              }),
            ),

            const SizedBox(height: 50), // More space before feedback header
            const Text(
              'We need your feedback!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 10),
            const Text(
              'How would you rate your\nexperience with the app today?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 70), // More space before feedback box

            // Feedback Text Box
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write your feedback',
                ),
              ),
            ),
          ],
        ),
      ),

      const Spacer(),

      // Submit Button
      SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            if (selectedRating == 0) {
              _showNoRatingDialog();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Thank you for your feedback!'),
                  duration: Duration(seconds: 2),
                ),
              );
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pop(context);
                Navigator.pop(context);
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1F2937),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: const Text(
            'Submit',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
    ],
  ),
),

    );
  }
}
