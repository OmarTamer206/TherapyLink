import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Sample notifications
  final List<String> notifications = [
    "Your session starts in 20 minutes.",
    "You have an upcoming group therapy at 5:00 PM.",
    "Emergency team on standby.",
  ];

  // Function to show notifications
  void _showNotifications() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Notifications"),
          content: SingleChildScrollView(
            child: Column(
              children: notifications
                  .map((notification) => ListTile(
                        title: Text(notification),
                      ))
                  .toList(),
            ),
          ),
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
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10), // Reduced top padding
          child: Row(
            children: [
              // Notification icon placed on the top left under the logo
              IconButton(
                icon: const Icon(Icons.notifications),
                color: const Color.fromARGB(255, 24, 41, 125),
                onPressed: _showNotifications, // Show notifications when pressed
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 24, 41, 125),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              ),
              onPressed: () {
                // TODO: Add logout logic
              },
              child: const Text(
                'Log Out',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const SizedBox(height: 90), // 👈 Push everything down except logout

          // Profile Picture
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://i.pravatar.cc/150?img=47'), // Replace with user image
          ),

          const SizedBox(height: 16),

          // Name and Join Date
          const Text(
            'Emily Mark',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 4),
          const Text('Joined 2/1/2023'),

          const SizedBox(height: 20),

          // Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/edit-profile');
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    side: const BorderSide(
                        color: Color.fromARGB(255, 24, 41, 125)),
                  ),
                  child: const Text(
                    'Edit profile',
                    style: TextStyle(
                        color: Color.fromARGB(255, 24, 41, 125),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/journal');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 24, 41, 125),
                    minimumSize: const Size.fromHeight(45),
                  ),
                  child: const Text(
                    'My Journal',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Stats Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _StatItem(
                  icon: Icons.calendar_today,
                  count: '6',
                  label: 'Therapy\nSessions',
                ),
                _StatItem(
                  icon: Icons.groups,
                  count: '3',
                  label: 'Group\nSessions',
                ),
                _StatItem(
                  icon: Icons.warning,
                  count: '1',
                  label: 'Emergency\nTeam',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String count;
  final String label;

  const _StatItem({
    required this.icon,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: const Color.fromARGB(255, 24, 41, 125),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(
          count,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
