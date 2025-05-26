import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'checkout_coach_page.dart'; // Import the Checkout page

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MakeAppointmentCoachPage(),
  ));
}

class MakeAppointmentCoachPage extends StatefulWidget {
  const MakeAppointmentCoachPage({super.key});

  @override
  State<MakeAppointmentCoachPage> createState() => _MakeAppointmentCoachPageState();
}

class _MakeAppointmentCoachPageState extends State<MakeAppointmentCoachPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  String? _selectedTime;

  final List<String> times = [
    '2:00 PM', '2:30 PM', '3:00 PM',
    '3:30 PM', '4:00 PM', '4:30 PM',
    '5:00 PM', '5:30 PM', '6:00 PM',
    '6:30 PM', '7:00 PM', '8:30 PM',
  ];

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
            Navigator.pop(context);  // Go back to the previous screen
          },
        ),
        title: const Text(
          'Life Coach Appointment',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _buildLifeCoachCard(),
          _buildCalendar(),
          const SizedBox(height: 10),
          const Text("Time Available", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildTimeGrid(),
          const SizedBox(height: 20),
          _buildProceedButton(context), // Pass context to navigate
        ],
      ),
    );
  }

  Widget _buildLifeCoachCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/life_coach.png'), // Replace with your own image
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Dr. Mohamed', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Life Coach'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(), // Remove highlight from today
          todayTextStyle: TextStyle(), // Makes today's text look normal unless selected
          selectedDecoration: BoxDecoration(
            color: Color(0xFF013B47),
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
      ),
    );
  }

  Widget _buildTimeGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: times.map((time) {
          bool isSelected = time == _selectedTime;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTime = time;
              });
            },
            child: Container(
              width: 80,
              padding: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF013B47) : const Color(0xFF01B5C5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                time,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProceedButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 24, 41, 125),
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        onPressed: () {
          if (_selectedDay != null && _selectedTime != null) {
            // Navigate to checkout page when Proceed is pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CheckoutCoachPage()), // Navigate to Checkout page
            );
          }
        },
        child: const Text(
          'Proceed',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
