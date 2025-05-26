import 'package:flutter/material.dart';
import 'group_sessions_page.dart'; // Import Group Sessions Page
import 'sessions_page.dart';      // Import Sessions Page
import 'profile_page.dart';       // Import Profile Page
import 'choose_therapist.dart';   // Import Therapist Selection Page
import 'chat_page.dart';          // Import ChatBotPage
import 'doctors_page.dart';       // Import DoctorsPage (Choose Doctor)

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Default to Home tab

  // List of pages to display based on selected tab
  final List<Widget> _pages = [
    const HomeScreen(),        // Home content
    const GroupSessionsPage(), // Group Sessions page
    const SessionsPage(),      // Sessions page
    const ProfilePage(),       // Profile page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDF1F4), // Light blue background
      appBar: AppBar(
        backgroundColor: const Color(0xFFDDF1F4),
        elevation: 0,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "TherapyLink",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade700,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: const Row(
                    children: [
                      Icon(Icons.help_outline, size: 16, color: Colors.white),
                      SizedBox(width: 6),
                      Text("Need Help?", style: TextStyle(color: Colors.white, fontSize: 13)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage("https://i.pravatar.cc/100"),
                ),
              ],
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex], // Display selected page based on the tab
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Handle tab selection
        selectedItemColor: const Color(0xFF003D3E),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Group Sessions'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Sessions'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Home Screen Widget
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Upcoming Session",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
              const SizedBox(height: 15),

              // SESSION CARD
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Session With: Dr. Magdy", style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: Colors.black)),
                    const SizedBox(height: 4),
                    const Text("Timing: 9/1/2025 , 7:00 PM", style: TextStyle(fontSize: 13, color: Colors.black87)),
                    const SizedBox(height: 25),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 140,
                          height: 140,
                          child: CircularProgressIndicator(
                            value: 0.67,
                            strokeWidth: 10,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00A4A6)),
                          ),
                        ),
                        const Text("20 minutes left", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // BUTTONS
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to Therapist Selection Page when pressed
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TherapistSelectionPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB6E6E4),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text("Change Therapist Preference", textAlign: TextAlign.center),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Navigate to Doctors Page when pressed
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DoctorsPage()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text("Choose Doctor"),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Chatbot Page when pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatBotPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003D3E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Repeat Chatbot Test"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
