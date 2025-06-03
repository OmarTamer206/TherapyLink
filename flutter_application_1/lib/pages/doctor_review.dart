import 'package:flutter/material.dart';
import 'make_appointment.dart';

class DoctorReviewPage extends StatelessWidget {
  final Map<String, dynamic> doctorData;

  const DoctorReviewPage({super.key, required this.doctorData});

  static const Color mainColor = Color(0xFF1F2937);
  static const Color bgColor = Color(0xFFDFF0F4);

  @override
  Widget build(BuildContext context) {
    print(doctorData);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Text(
          "Dr. ${doctorData["name"]}’s Page",
          style: const TextStyle(color: mainColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: mainColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _buildDoctorCard(),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: (doctorData["reviews"] == null || doctorData["reviews"].isEmpty)
                ? const Center(
                    child: Text(
                      'There are no reviews yet.',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: mainColor,
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: doctorData["reviews"].length,
                    separatorBuilder: (context, index) => const Divider(height: 16),
                    itemBuilder: (context, index) {
                      final review = doctorData["reviews"][index];
                      return _buildReview(review["content"], review["rating"]);
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AppointmentPage(doctorData:doctorData)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Make Appointment',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard() {
    final rating = double.tryParse(doctorData["avgRating"].toString()) ?? 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage('assets/doctor.png'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Dr. ${doctorData["name"]} ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: mainColor,
                      ),
                    ),
                    Text(
                      _buildStarString(rating),
                      style: const TextStyle(fontSize: 14, color: mainColor),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  doctorData["doctor_data"]["Specialization"],
                  style: const TextStyle(fontSize: 13, color: mainColor),
                ),
                const SizedBox(height: 6),
                Text(
                  doctorData["doctor_data"]["Description"],
                  style: const TextStyle(fontSize: 12, color: mainColor),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReview(String content, int rating) {
    final avgRating = double.tryParse(doctorData["avgRating"].toString()) ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _buildStarString(avgRating),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: mainColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: const TextStyle(fontSize: 13, color: mainColor),
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFF00B4A6), thickness: 1),
        ],
      ),
    );
  }

  String _buildStarString(double rating) {
    final stars = rating.round().clamp(0, 5);
    return '★' * stars + '☆' * (5 - stars);
  }
}
