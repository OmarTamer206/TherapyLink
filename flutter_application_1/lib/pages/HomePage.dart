// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'dart:async';
import 'group_sessions_page.dart';
import 'sessions_page.dart';
import 'profile_page.dart';
import 'choose_therapist.dart';
import 'chat_page.dart';
import 'doctors_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    const SessionsPage(),
    const GroupSessionsPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1F2937),
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomBarItem(
              icon: Icons.home,
              label: "Home",
              isActive: _selectedIndex == 0,
              onTap: () => _onItemTapped(0)),
          _buildBottomBarItem(
              icon: Icons.calendar_today,
              label: "Sessions",
              isActive: _selectedIndex == 1,
              onTap: () => _onItemTapped(1)),
          _buildBottomBarItem(
              icon: Icons.group,
              label: "Group Sessions",
              isActive: _selectedIndex == 2,
              onTap: () => _onItemTapped(2)),
          _buildBottomBarItem(
              icon: Icons.person,
              label: "Account",
              isActive: _selectedIndex == 3,
              onTap: () => _onItemTapped(3)),
        ],
      ),
    );
  }

  Widget _buildBottomBarItem({
    required IconData icon,
    required String label,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isActive ? const Color(0xFF00B4A6) : const Color(0xFF6B7280),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? const Color(0xFF00B4A6) : const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 14),
                decoration: const BoxDecoration(
                  color: Color(0xFFDDF1F4),
                ),
                child: Column(
                  children: [
                    _buildAppBar(context),
                    const SizedBox(height: 24),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Welcome Emily !",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 11),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Upcoming Session",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SessionsPage()),
                        );
                      },
                      child: Container(
                        width: double.maxFinite,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Session With: Dr. Magdy",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              "Timing: 9/1/2025 , 7:00 PM",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 40),
                            Container(
                              height: 240,
                              width: double.maxFinite,
                              margin: const EdgeInsets.symmetric(horizontal: 38),
                              child: const DynamicCountdownWidget(
                                sessionTime: "2025-05-27 04:29:00",
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Divider(indent: 20, endIndent: 20, color: Color(0xFF149FA8)),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(child: _buildChangeTherapistButton(context)),
                          const SizedBox(width: 12),
                          Expanded(child: _buildChooseDoctorButton(context)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildRepeatChatbotButton(context),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFDDF1F4),
      elevation: 0,
      toolbarHeight: 44,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF00B4A6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "TherapyLink",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE53E3E),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: const Row(
                  children: [
                    Icon(Icons.help_outline, size: 16, color: Colors.white),
                    SizedBox(width: 4),
                    Text("Need Help?", style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const CircleAvatar(
                radius: 17,
                backgroundImage: NetworkImage("https://i.pravatar.cc/100"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChangeTherapistButton(BuildContext context) {
    return SizedBox(
      height: 54,
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TherapistSelectionPage()),
          );
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF00B4A6)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const Text(
          "Change Therapist Preference",
          style: TextStyle(
            color: Color(0xFF00B4A6),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildChooseDoctorButton(BuildContext context) {
    return SizedBox(
      height: 54,
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DoctorsPage()),
          );
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF1F2937)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const Text(
          "Choose Doctor",
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildRepeatChatbotButton(BuildContext context) {
    return Container(
      height: 54,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatBotPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1F2937),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 8),
            Text(
              "Repeat Chatbot Test",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DynamicCountdownWidget extends StatefulWidget {
  final String sessionTime;

  const DynamicCountdownWidget({super.key, required this.sessionTime});

  @override
  _DynamicCountdownWidgetState createState() => _DynamicCountdownWidgetState();
}

class _DynamicCountdownWidgetState extends State<DynamicCountdownWidget>
    with TickerProviderStateMixin {
  Timer? _timer;
  Duration _timeLeft = Duration.zero;

  late AnimationController _animationController;
  late AnimationController _colorController;
  late Animation<double> _animation;
  late Animation<Color?> _colorAnimation;

  bool _hasEnded = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _colorController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _colorAnimation = ColorTween(
      begin: const Color(0xFFE5E7EB), // Original teal color
      end: Colors.green,
    ).animate(_colorController);

    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final sessionDateTime = DateTime.parse(widget.sessionTime);
      final now = DateTime.now();
      final remaining = sessionDateTime.difference(now);

      setState(() {
        _timeLeft = remaining;

        if (!_hasEnded && _timeLeft.isNegative) {
          _hasEnded = true;
          _colorController.forward();
        }

        _animationController.forward().then((_) {
          _animationController.reset();
        });
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  String _formatTimeLeft() {
    if (_timeLeft.isNegative || _timeLeft == Duration.zero) {
      return "Session Started";
    }

    final hours = _timeLeft.inHours;
    final minutes = _timeLeft.inMinutes % 60;
    final seconds = _timeLeft.inSeconds % 60;

    if (hours > 0) {
      return "$hours h $minutes m $seconds s left";
    } else if (minutes > 0) {
      return "$minutes m $seconds s left";
    } else {
      return "$seconds seconds left";
    }
  }

  double _getProgressValue() {
    if (_timeLeft.isNegative) return 1.0;

    const totalMinutes = 120;
    final minutesLeft = _timeLeft.inMinutes;
    return (totalMinutes - minutesLeft) / totalMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_animation, _colorAnimation]),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 240,
              width: 240,
              child: CircularProgressIndicator(
                value: _getProgressValue(),
                backgroundColor: const Color(0xFF00B4A6), // Reverted light gray
                color: _colorAnimation.value ?? const Color(0xFF00B4A6), // Teal to green
                strokeWidth: 15,
              ),
            ),
            Text(
              _formatTimeLeft(),
              style: TextStyle(
                fontSize: _timeLeft.isNegative ? 14 : 16,
                fontWeight: FontWeight.w600,
                color: _timeLeft.isNegative ? Colors.green : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}

