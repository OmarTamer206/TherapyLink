import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/patient.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TherapistSelectionPage(),
  ));
}

class TherapistSelectionPage extends StatefulWidget {
  const TherapistSelectionPage({super.key});

  @override
  State<TherapistSelectionPage> createState() => _TherapistSelectionPageState();
}

class _TherapistSelectionPageState extends State<TherapistSelectionPage> {
  String? selectedTherapist;

  final List<String> therapistTitles = [
    "General Psychological Support",
    "Mood and Anxiety Disorder Specialist",
    "Clinical Depression and Crisis Prevention Specialist",
  ];

  PatientApi _patientApi = PatientApi();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final userData = await _patientApi.getProfileData();
    print(userData["data"]["patient"][0]["Therapist_Preference"]);
    if(userData["data"]["patient"][0]["Therapist_Preference"] != null)
      setState(() {
        selectedTherapist = userData["data"]["patient"][0]["Therapist_Preference"];
      });
    }

  Future<void> _changeTherapistPreference() async {
    final result = await _patientApi.changeTherapistPreference(selectedTherapist!);
    print(result);
    
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF0F4),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context); // Pop and go back to the Home Page
                },
              ),
            ),

            // Heading
            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Choose Your Therapist!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Type of Therapists',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),

            // Therapist List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: therapistTitles.length,
                itemBuilder: (context, index) {
                  final title = therapistTitles[index];
                  final isSelected = selectedTherapist == title;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTherapist = title;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? Color(0xFF1F2937)
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Confirm Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedTherapist != null
                      ? () {

                          _changeTherapistPreference();
                          // Show SnackBar to confirm selection
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Selected: $selectedTherapist'),
                          ));

                          // Go back to the Home Screen after confirming selection
                          Navigator.pop(context); // Pop this screen and return to Home
                        }
                      : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.grey.shade400;
                        }
                        return Color(0xFF1F2937);
                      },
                    ),
                    minimumSize:
                        MaterialStateProperty.all(const Size.fromHeight(50)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
