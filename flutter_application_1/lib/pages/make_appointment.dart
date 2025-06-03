import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/therapist.dart';
import 'package:table_calendar/table_calendar.dart';
import 'checkout_page.dart';

class AppointmentPage extends StatefulWidget {
  final Map<String, dynamic> doctorData;
  const AppointmentPage({super.key, required this.doctorData});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  String? _selectedTime;
  var doctor_id;

  TherapistApi _therapistApi = TherapistApi();
  final List<String> allTimes = [
    '9:00 AM', '11:00 AM', '1:00 PM',
    '3:00 PM', '5:00 PM', '7:00 PM',
    '9:00 PM', '11:00 PM', '1:00 AM'
  ];

  List<Map<String, dynamic>> timeTable = [];

  @override
  void initState() {
    super.initState();
    doctor_id = widget.doctorData["doctor_data"]["id"];
    _fetchAvailableTimes(_selectedDay!);
  }

  void _fetchAvailableTimes(DateTime selectedDay) async {
    String date = "${selectedDay.year}-${selectedDay.month.toString().padLeft(2, '0')}-${selectedDay.day.toString().padLeft(2, '0')}";
    var response = await _therapistApi.viewAvailableTime(date, "$doctor_id", "doctor");

    List<Map<String, dynamic>> fetchedTimeTable = [];

    if (response != null && response['success']) {
      for (var item in response['data']) {
        final utcDate = DateTime.parse(item['available_date']);
        final localDate = utcDate.toLocal();
        final time = TimeOfDay.fromDateTime(localDate).format(context);
        fetchedTimeTable.add({
          'time': time,
          'isReserved': item['IsReserved'],
          'fullTimestamp': item['available_date'],
        });
      }

      for (String time in allTimes) {
        if (!fetchedTimeTable.any((t) => t['time'] == time)) {
          fetchedTimeTable.add({'time': time, 'isReserved': true, 'fullTimestamp': ''});
        }
      }
    }

    fetchedTimeTable.sort((a, b) {
      final t1 = TimeOfDay(
        hour: int.parse(_to24(a['time']).split(':')[0]),
        minute: int.parse(_to24(a['time']).split(':')[1]),
      );
      final t2 = TimeOfDay(
        hour: int.parse(_to24(b['time']).split(':')[0]),
        minute: int.parse(_to24(b['time']).split(':')[1]),
      );
      return t1.hour != t2.hour ? t1.hour.compareTo(t2.hour) : t1.minute.compareTo(t2.minute);
    });

    setState(() {
      timeTable = fetchedTimeTable;
    });
  }

  String _to24(String time) {
    final parts = time.split(RegExp(r'[:\s]'));
    int hour = int.parse(parts[0]);
    int min = int.parse(parts[1]);
    String period = parts[2];
    if (period == "PM" && hour != 12) hour += 12;
    if (period == "AM" && hour == 12) hour = 0;
    return "${hour.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}";
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
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Appointment',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildCalendar(),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Time Available", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            _buildTimeGrid(),
            const SizedBox(height: 30),
            _buildProceedButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(),
          selectedDecoration: BoxDecoration(
            color: Color(0xFF1F2937),
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          _fetchAvailableTimes(selectedDay);
        },
      ),
    );
  }

  Widget _buildTimeGrid() {
  return GridView.count(
    shrinkWrap: true,
    crossAxisCount: 3,
    crossAxisSpacing: 12,
    childAspectRatio: 2.5, // Adjust this to make items shorte
    mainAxisSpacing: 12,
    physics: const NeverScrollableScrollPhysics(),
    children: timeTable.map((slot) {
      final bool isSelected = slot['time'] == _selectedTime;
      final bool isDisabled = slot['isReserved'] == true;

      return GestureDetector(
        onTap: isDisabled
            ? null
            : () {
                setState(() {
                  _selectedTime = slot['time'];
                });
              },
        child: SizedBox(
          height: 60, // Reduced height
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isDisabled
                  ? Colors.grey
                  : isSelected
                      ? const Color(0xFF1F2937)
                      : const Color(0xFF00B4A6),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              slot['time'],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12, // Optional: smaller text
              ),
            ),
          ),
        ),
      );
    }).toList(),
  );
}


  Widget _buildProceedButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1F2937),
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      onPressed: () {
        if (_selectedDay != null && _selectedTime != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutPage(
                doctorData: widget.doctorData,
                selectedDate: _selectedDay!,
                selectedTime: _selectedTime!,
              ),
            ),
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
    );
  }
}
