import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'checkout_page.dart'; // Import the CheckoutPage

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AppointmentPage(),
  ));
}

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
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
            Navigator.pop(context);  // Ensure the back button works
          },
        ),
        title: const Text(
          'Appointment',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _buildDoctorCard(),
          _buildCalendar(),
          const SizedBox(height: 10),
          const Text("Time Available", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildTimeGrid(),
          const SizedBox(height: 20),
          _buildProceedButton(context),  // Pass context to proceed button
        ],
      ),
    );
  }

  Widget _buildDoctorCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: const [
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/doctor.png'), // Replace with your image
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dr. Mark', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Clinical Psychologist'),
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
            // Navigate to Checkout Page when proceed button is pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CheckoutPage()),
            );
          }
        },
       child: const Text(
  'Proceed',
  style: TextStyle(
    color: Colors.white, // 👈 Add this line
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
),

      ),
    );
  }
}
