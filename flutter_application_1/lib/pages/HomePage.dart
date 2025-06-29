// ignore_for_file: must_be_immutable

import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/services/patient.dart';
import 'package:flutter_application_1/services/session.dart';
import 'dart:async';
import 'group_sessions_page.dart';
import 'sessions_page.dart';
import 'profile_page.dart';
import 'choose_therapist.dart';
import 'chat_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'doctors_page.dart';
import 'emergency.dart';
import 'upcoming_sessions.dart'; // Add this import
import 'chatbot_welcome.dart'; // Add this import


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    SessionsPage(),
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

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with RouteAware {
  bool _loading = true;
  String? _patientName = "Emily"; // You can replace with fetched data
  var _patientId ; // You can replace with fetched data
  Map<String, dynamic>? _upcomingSession; // null means no session
  late DateTime _sessionDateTime;

  PatientApi _patientApi = PatientApi();
  SessionApi _sessionApi = SessionApi();

  var userData ;
  var sessionData ;
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Called when coming back to this page
    setState(() {
      print("Returning to HomeScreen");
      _fetchData(); // 🔁 REFRESH ON RETURN
    });
  }


  Future<void> _fetchData() async {
    // Simulate data fetching delay here or replace with real fetch calls
    
    userData = await _patientApi.getProfileData();
    sessionData = await _sessionApi.getUpcomingSessionsPatient();

    if(userData["data"]["patient"][0]["first_time_login"] == 1){
      Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatBotWelcomePage()),
          );

       _patientApi.changeFirstLogin();
    }

    print("data : " + sessionData.toString());
    // Example: you should replace these with real fetched values
    setState(() {
      _patientName = userData["data"]["patient"][0]["Name"]; // fetched patient name
      _patientId = userData["data"]["patient"][0]["id"]; // fetched patient name
      // Uncomment below to simulate a session present
      if(sessionData.toString() != '[]'){
        _upcomingSession = {
        'doctor_name': 'Dr. ' + sessionData[0]["doctor_name"] ,
        'scheduled_time': sessionData[0]["scheduled_time"],
      };
      }

      // Uncomment below to simulate no upcoming session
      // _upcomingSession = null;

      if (_upcomingSession != null && _upcomingSession!['scheduled_time'] != null) {
        _sessionDateTime = DateTime.parse(_upcomingSession!['scheduled_time']).toLocal();
      }

      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding: const EdgeInsets.only(top: 14),
          decoration: const BoxDecoration(
            color: Color(0xFFDDF1F4),
          ),
          child: Column(
            children: [
              _buildAppBar(context),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome ${_patientName ?? ''} !",
                    style: const TextStyle(
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
                  if (_upcomingSession != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpcomingSessionsPage(sessionData: sessionData[0])),
                    );
                  }
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
                      Text(
                        "Session With: ${_upcomingSession != null ? _upcomingSession!['doctor_name'] : 'N/A'}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _upcomingSession != null && _upcomingSession!['scheduled_time'] != null
                            ? "Timing: ${_sessionDateTime.day}/${_sessionDateTime.month}/${_sessionDateTime.year} , "
                              "${_sessionDateTime.hour % 12 == 0 ? 12 : _sessionDateTime.hour % 12}:"
                              "${_sessionDateTime.minute.toString().padLeft(2, '0')} "
                              "${_sessionDateTime.hour >= 12 ? 'PM' : 'AM'}"
                            : "Timing: N/A",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),
                      if (_upcomingSession != null && _upcomingSession!['scheduled_time'] != null)
                        Container(
                          height: 240,
                          width: double.maxFinite,
                          margin: const EdgeInsets.symmetric(horizontal: 38),
                          child: DynamicCountdownWidget(
                            key: ValueKey(_upcomingSession!['scheduled_time']),
                            sessionTime: _upcomingSession!['scheduled_time'],
                          ),

                        )
                      else
                        Container(
                          height: 240,

                          child: const Center(
                            child: Text(
                              "No Upcoming Sessions.",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
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
          Image.asset(
            'assets/images/therapy.png',
            height: 40, // adjust size as needed
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  EmergencyPage(userId: _patientId,)),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53E3E),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: const Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, size: 16, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        "Emergency Support",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
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
            fontWeight: FontWeight.bold,
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
            MaterialPageRoute(builder: (context) => const ChatBotWelcomePage()),
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
  State<DynamicCountdownWidget> createState() => _DynamicCountdownWidgetState();
}

class _DynamicCountdownWidgetState extends State<DynamicCountdownWidget> with TickerProviderStateMixin {
  Timer? _timer;
  Duration _timeLeft = Duration.zero;
  Duration _initialDuration = const Duration(seconds: 1);
  late DateTime _sessionDateTime;

  bool _hasEnded = false;
  bool _isLoaded = false;

  late AnimationController _animationController;
  late AnimationController _colorController;
  late Animation<double> _animation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimationControllers();
    _loadSessionTime();
  }

  void _setupAnimationControllers() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _colorController = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _colorAnimation = ColorTween(
      begin: const Color(0xFFE5E7EB),
      end: Colors.green,
    ).animate(_colorController);
  }

  Future<void> _loadSessionTime() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('saved_session_time');
    final newTime = DateTime.parse(widget.sessionTime);

    if (saved != null) {
      final savedTime = DateTime.parse(saved);

      // If developer updated the session time manually, override
      if (!savedTime.isAtSameMomentAs(newTime)) {
        _sessionDateTime = newTime;
        await prefs.setString('saved_session_time', _sessionDateTime.toIso8601String());
      } else {
        _sessionDateTime = savedTime;
      }
    } else {
      _sessionDateTime = newTime;
      await prefs.setString('saved_session_time', _sessionDateTime.toIso8601String());
    }

    _initialDuration = _sessionDateTime.difference(DateTime.now());
    _timeLeft = _initialDuration;

    if (_timeLeft.isNegative) {
      _timeLeft = Duration.zero;
      _hasEnded = true;
      _colorController.forward();
    } else {
      _startCountdown();
    }

    setState(() => _isLoaded = true);
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      final remaining = _sessionDateTime.difference(now);

      setState(() {
        _timeLeft = remaining;

        if (!_hasEnded && _timeLeft.isNegative) {
          _hasEnded = true;
          _colorController.forward();
        }

        _animationController.forward().then((_) => _animationController.reset());
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

    final days = _timeLeft.inDays;
    final hours = _timeLeft.inHours % 24;
    final minutes = _timeLeft.inMinutes % 60;
    final seconds = _timeLeft.inSeconds % 60;

    if (days > 0) return "$days d $hours h $minutes m $seconds s left";
    if (hours > 0) return "$hours h $minutes m $seconds s left";
    if (minutes > 0) return "$minutes m $seconds s left";
    return "$seconds seconds left";
  }

  double _getProgressValue() {
    if (_timeLeft.isNegative || _initialDuration.inSeconds <= 0) return 1.0;
    final elapsed = _initialDuration - _timeLeft;
    return elapsed.inSeconds / _initialDuration.inSeconds;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      return const Center(child: CircularProgressIndicator());
    }

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
                value: _getProgressValue().clamp(0.0, 1.0),
                backgroundColor: const Color(0xFF00B4A6),
                color: _colorAnimation.value ?? const Color(0xFF00B4A6),
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
