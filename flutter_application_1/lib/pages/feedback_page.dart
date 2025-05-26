import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FeedbackPage(),
  ));
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int selectedRating = 0;

  // Function to show the dialog if no rating is selected
  void _showNoRatingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Please Rate the Session"),
          content: const Text("You must rate the session before submitting your feedback."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
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
          onPressed: () {
            Navigator.pop(context); // This will navigate back to the previous screen
          },
        ),
        title: const Text(
          'Feedback',
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Session With: Dr. Magdy',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('30 minutes'),
              ],
            ),
            const SizedBox(height: 4),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Timing: 9/1/2025 , 7:00 PM'),
            ),
            const SizedBox(height: 30),
            const SizedBox(height: 40), // 👈 push the container lower

            // Feedback Card (Bigger)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              height: 360, // 👈 Taller container
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // TODO: Close feedback card
                        },
                        child: const Icon(Icons.close),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Star Row for Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        iconSize: 46,
                        onPressed: () {
                          setState(() {
                            selectedRating = index + 1;
                          });
                        },
                        icon: Icon(
                          Icons.star,
                          color: index < selectedRating
                              ? const Color(0xFF01B5C5)
                              : Colors.grey.shade300,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'We need your feedback!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'How would you rate your\nexperience with the app today?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),

                  // Feedback Text Field
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const TextField(
                      maxLines: 2,
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
                  // Check if no rating has been selected
                  if (selectedRating == 0) {
                    // Show a dialog asking the user to rate
                    _showNoRatingDialog();
                  } else {
                    // Show SnackBar with Thank You message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Thank you for your feedback!'),
                        duration: Duration(seconds: 2),
                      ),
                    );

                    // After a short delay, navigate back twice to the SessionsPage
                    Future.delayed(const Duration(seconds: 2), () {
                      // First pop the current page (FeedbackPage)
                      Navigator.pop(context);

                      // Second pop to go back to SessionsPage
                      Navigator.pop(context); // This will return the user to the SessionsPage
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 24, 41, 125),
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
