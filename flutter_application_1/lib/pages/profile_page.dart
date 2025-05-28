import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF0F4),
      appBar: AppBar(
  backgroundColor: const Color(0xFFDFF0F4),
  elevation: 0,
  automaticallyImplyLeading: false, // <<--- This hides the default back button
  title: const Text(
    'Profile',
    style: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
  ),
  centerTitle: true,
  actions: [
    Padding(
      padding: const EdgeInsets.only(right: 16),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 255, 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 48),

              // Profile Image
              const CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?img=47'), // Replace with real user image
              ),

              const SizedBox(height: 28),

              // Name and Join Date
              const Text(
                'Emily Mark',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(height: 8),
              const Text(
                'Joined 2/1/2023',
                style: TextStyle(
                    fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w400),
              ),

              const SizedBox(height: 26),

              // Edit Profile & My Journal Buttons
              SizedBox(
                width: 204,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/edit-profile');
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFF1F2937),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Edit profile',
                    style: TextStyle(
                        color: Color(0xFF1F2937),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: 204,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/journal');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1F2937),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'My Journal',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 80),

              // Stats Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(width: 76, child: _StatItem(
                      icon: Icons.calendar_today,
                      count: '6',
                      label: 'Therapy\nSessions',
                    )),
                    SizedBox(width: 40),
                    SizedBox(width: 76, child: _StatItem(
                      icon: Icons.groups,
                      count: '3',
                      label: 'Group\nSessions',
                    )),
                    SizedBox(width: 40),
                    SizedBox(width: 76, child: _StatItem(
                      icon: Icons.warning,
                      count: '1',
                      label: 'Emergency\nTeam',
                    )),
                  ],
                ),
              ),

              const SizedBox(height: 90),
            ],
          ),
        ),
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
          radius: 32, // Increased icon size
          backgroundColor: Color(0xFF1F2937), // Dark teal like the screenshot
          child: Icon(
            icon,
            color: Colors.white,
            size: 28, // Icon size inside avatar
          ),
        ),
        const SizedBox(height: 8),
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
