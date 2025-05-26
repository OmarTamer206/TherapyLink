// lib/api/therapist_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class TherapistApi {
static const String baseUrl = 'http://localhost:3000';

static Future<http.Response> getTodaySessions(String token) {
return http.get(
Uri.parse('$baseUrl/therapist/today-sessions'),
headers: {'Authorization': 'Bearer $token'},
);
}

static Future<http.Response> getUpcomingSessions(String token) {
return http.get(
Uri.parse('$baseUrl/therapist/upcoming-sessions'),
headers: {'Authorization': 'Bearer $token'},
);
}

static Future<http.Response> getNewPatientsThisMonth(String token) {
return http.get(
Uri.parse('$baseUrl/therapist/new-patients-this-month'),
headers: {'Authorization': 'Bearer $token'},
);
}

static Future<http.Response> getTotalPatients(String token) {
return http.get(
Uri.parse('$baseUrl/therapist/total-patients'),
headers: {'Authorization': 'Bearer $token'},
);
}

static Future<http.Response> getPatientsData(String token, String sessionId) {
return http.get(
Uri.parse('$baseUrl/therapist/patients-data/$sessionId'),
headers: {'Authorization': 'Bearer $token'},
);
}

static Future<http.Response> getPatientData(String patientId) {
return http.get(
Uri.parse('$baseUrl/therapist/patient-data/$patientId'),
);
}

static Future<http.Response> updatePatientReport(
String token, String report, Map<String, dynamic> sessionData) {
return http.put(
Uri.parse('$baseUrl/therapist/update-patient-report'),
headers: {
'Authorization': 'Bearer $token',
'Content-Type': 'application/json'
},
body: jsonEncode({'report': report, 'session_data': sessionData}),
);
}

static Future<http.Response> viewAvailableTime(
String token, String date, String id, String type) {
return http.get(
Uri.parse('$baseUrl/therapist/available-time/$date/$id/$type'),
headers: {'Authorization': 'Bearer $token'},
);
}

static Future<http.Response> viewAvailableTimeOwn(String token, String date) {
return http.get(
Uri.parse('$baseUrl/therapist/available-time/$date'),
headers: {'Authorization': 'Bearer $token'},
);
}

static Future<http.Response> updateAvailableTime(
String token, String timestamp, String topic) {
return http.put(
Uri.parse('$baseUrl/therapist/update-available-time'),
headers: {
'Authorization': 'Bearer $token',
'Content-Type': 'application/json'
},
body: jsonEncode({'timestamp': timestamp, 'topic': topic}),
);
}

static Future<http.Response> deleteAvailableTime(
String token, String timestamp) {
return http.delete(
Uri.parse('$baseUrl/therapist/delete-available-time'),
headers: {
'Authorization': 'Bearer $token',
'Content-Type': 'application/json'
},
body: jsonEncode({'timestamp': timestamp}),
);
}

static Future<http.Response> getPatientAnalytics(String token) {
return http.get(
Uri.parse('$baseUrl/therapist/patient-analytics'),
headers: {'Authorization': 'Bearer $token'},
);
}

static Future<http.Response> getTherapistData(String token) {
return http.get(
Uri.parse('$baseUrl/therapist/get-therapist-data'),
headers: {'Authorization': 'Bearer $token'},
);
}

static Future<http.Response> viewAllDoctors(
String doctorType, String doctorSpecialization) {
return http.get(
Uri.parse(
'$baseUrl/therapist/all-doctors/$doctorType/$doctorSpecialization'),
);
}
}