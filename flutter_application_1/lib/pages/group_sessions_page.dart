import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/life_coach_review.dart';
import 'doctor_review.dart'; // Import the doctor review page
import 'package:flutter_application_1/services/patient.dart';   // Your patient API service
import 'package:flutter_application_1/services/therapist.dart'; // Your therapist API service
import 'dart:js_util' as js_util;

class GroupSessionsPage extends StatefulWidget {
  const GroupSessionsPage({super.key});

  @override
  State<GroupSessionsPage> createState() => _GroupSessionsPageState();
}

class _GroupSessionsPageState extends State<GroupSessionsPage> {
  List<Map<String, dynamic>> doctors = [];
  bool _loading = true;
  String? _therapistPreference;

  final PatientApi _patientApi = PatientApi();
  final TherapistApi _therapistApi = TherapistApi();

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }


Future<void> _fetchDoctors() async {
  setState(() => _loading = true);

  final patientData = await _patientApi.getProfileData();
  _therapistPreference = patientData["data"]?["patient"][0]["Therapist_Preference"];
  print(_therapistPreference);

  if (_therapistPreference == null) {
    setState(() {
      doctors = [];
      _loading = false;
    });
    return;
  }

  final doctorListRaw = await _therapistApi.viewAllDoctors("life_coach", _therapistPreference!);
  if (doctorListRaw == null) {
    setState(() {
      doctors = [];
      _loading = false;
    });
    return;
  }

  
// Extract the list inside the response map
final List<dynamic> doctorList = doctorListRaw['data'] ?? [];

print("doctor List : " + doctorList.toString());
// Now map doctorList safely
setState(() {
  doctors = doctorList.map<Map<String, dynamic>>((doc) {
    final doctorMap = Map<String, dynamic>.from(doc);
    return {
      "name": doctorMap["doctor_data"]["Name"] ?? "Unknown",
      "rating": doctorMap["avgRating"] ?? 0.0,
      ...doctorMap
    };
  }).toList();
  _loading = false;
});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF0F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFF0F4),
        elevation: 0,
        
        title: const Text(
          'Life Coaches',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : doctors.isEmpty
              ? const Center(
                  child: Text(
                    "No doctors found for your therapist preference.",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        _therapistPreference ?? 'Clinical Psychologist',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true, // Wrap content height
                          physics:
                              const NeverScrollableScrollPhysics(), // Disable internal scroll
                          itemCount: doctors.length,
                          separatorBuilder: (context, index) =>
                              const Divider(height: 16),
                          itemBuilder: (context, index) {
                            final doctor = doctors[index];
                            print(doctor);
                            return Row(
                              children: [
                                const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    doctor['name'],
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.black, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      doctor['rating'].toString(),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               LifeCoachReviewPage(doctorData:doctor)),
                                    );
                                  },
                                  child: const Text(
                                    'View Doctor',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 24, 41, 125),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
    );
  }
}
