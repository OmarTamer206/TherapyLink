import 'package:flutter/material.dart';
import 'make_appointment.dart';

class DoctorReviewPage extends StatelessWidget {
  final Map<String, dynamic> doctorData;
  
  const DoctorReviewPage({super.key , required this.doctorData});

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
          "Dr. "+ doctorData["name"] +"’s Page",
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
            child: ListView.separated(
                          shrinkWrap: true, // Wrap content height
                          physics:
                              const NeverScrollableScrollPhysics(), // Disable internal scroll
                          itemCount: doctorData["reviews"].length,
                          separatorBuilder: (context, index) =>
                              const Divider(height: 16),
                          itemBuilder: (context, index) {
                            final review = doctorData["reviews"][index];
                            print(review);
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
                  MaterialPageRoute(builder: (context) => const AppointmentPage()),
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
                  children:  [
                    Text(
                      'Dr. '+ doctorData["name"] +' ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: mainColor,
                      ),
                    ),
                    Text(
                      '★' * double.parse(doctorData["avgRating"]).round() + "☆" * (5-double.parse(doctorData["avgRating"]).round()) ,
                      style: TextStyle(fontSize: 14, color: mainColor),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                 Text(
                  doctorData["doctor_data"]["Specialization"],
                  style: TextStyle(fontSize: 13, color: mainColor),
                ),
                const SizedBox(height: 6),
                 Text(
                  doctorData["doctor_data"]["Description"],
                  style: TextStyle(fontSize: 12, color: mainColor,),
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
          '★' * double.parse(doctorData["avgRating"]).round() + "☆" * (5-double.parse(doctorData["avgRating"]).round()) ,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: mainColor,
            ),
          ),
          const SizedBox(height: 6),
          const SizedBox(height: 4),
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
}
