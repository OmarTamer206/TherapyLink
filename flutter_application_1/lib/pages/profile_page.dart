import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/patient.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final PatientApi _patientApi = PatientApi();

  var userData;
  var sessionData;
  var _patientName;
  var _patientPhoto;
  var _therapistSessionsTaken;
  var _groupSessionsTaken;
  var _emergencySessionsTaken;
  var _wallet;
  late DateTime _patientJoinDate;

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    userData = await _patientApi.getProfileData();
    _therapistSessionsTaken = await _patientApi.getDoctorSessionsTaken();
    _groupSessionsTaken = await _patientApi.getGroupSessionsTaken();
    _emergencySessionsTaken = await _patientApi.getEmergencyTeamSessionsTaken();

    setState(() {
      _patientName = userData["data"]["patient"][0]["Name"];
      _wallet = userData["data"]["patient"][0]["wallet"];
      _patientJoinDate = DateTime.parse(userData["data"]["patient"][0]["Created_at"]).toLocal();
      if(userData["data"]["patient"][0]["Profile_pic_url"] != null){
        _patientPhoto =  NetworkImage('http://localhost:3000/uploads/${userData["data"]["patient"][0]["Profile_pic_url"]}');
        print(_patientPhoto);
      }
      else{
         _patientPhoto = AssetImage('assets/images/profile png.png');
      }
     
     _therapistSessionsTaken = _therapistSessionsTaken["data"].length;
    _groupSessionsTaken = _groupSessionsTaken["data"].length;
    _emergencySessionsTaken = _emergencySessionsTaken["data"].length;
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
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
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
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Log Out', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 48),
                     CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.transparent,
                      backgroundImage: _patientPhoto,
                    ),
                    const SizedBox(height: 28),
                    Text(
                      '$_patientName',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Joined at : ${_patientJoinDate.day} - ${_patientJoinDate.month} - ${_patientJoinDate.year}',
                      style: const TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Wallet : ${_wallet} ',
                      style: const TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 26),
                    SizedBox(
                      width: 204,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/edit-profile').then((result)=>{
                            if(result == true){
                              _fetchData()
                            }
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF1F2937)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Edit profile',
                          style: TextStyle(color: Color(0xFF1F2937), fontWeight: FontWeight.bold),
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
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('My Journal', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 80),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 76,
                              child: _StatItem(
                                icon: Icons.calendar_today,
                                count: _therapistSessionsTaken.toString(),
                                label: 'Therapy\nSessions',
                              )),
                          const SizedBox(width: 40),
                          SizedBox(
                              width: 76,
                              child: _StatItem(
                                icon: Icons.groups,
                                count: _groupSessionsTaken.toString(),
                                label: 'Group\nSessions',
                              )),
                          const SizedBox(width: 40),
                          SizedBox(
                              width: 76,
                              child: _StatItem(
                                icon: Icons.warning,
                                count: _emergencySessionsTaken.toString(),
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
          radius: 32,
          backgroundColor: const Color(0xFF1F2937),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(count, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
