import 'dart:convert';
import 'package:http/http.dart' as http;

class PatientApi {
  static const String baseUrl = 'http://localhost:3000/patient';
  final Map<String, String> headers;

  PatientApi(String token)
      : headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

  Future<http.Response> changeTherapistPreference(String choice) {
    return http.put(
      Uri.parse('$baseUrl/change-therapist-preference'),
      headers: headers,
      body: jsonEncode({'choice': choice}),
    );
  }

  Future<http.Response> submitFeedback(String session, int rating, String feedback, bool editState) {
    return http.post(
      Uri.parse('$baseUrl/submit-feedback'),
      headers: headers,
      body: jsonEncode({
        'session': session,
        'rating': rating,
        'feedback': feedback,
        'editState': editState,
      }),
    );
  }

  Future<http.Response> checkFeedback(String sessionId, String sessionType) {
    return http.get(
      Uri.parse('$baseUrl/check-feedback/$sessionId/$sessionType'),
      headers: headers,
    );
  }

  Future<http.Response> makeAppointment(Map<String, dynamic> sessionData) {
    return http.post(
      Uri.parse('$baseUrl/make-appointment'),
      headers: headers,
      body: jsonEncode({'sessionData': sessionData}),
    );
  }

  Future<http.Response> getDoctorSessions() {
    return http.get(
      Uri.parse('$baseUrl/doctor-sessions'),
      headers: headers,
    );
  }

  Future<http.Response> getGroupSessions() {
    return http.get(
      Uri.parse('$baseUrl/group-sessions'),
      headers: headers,
    );
  }

  Future<http.Response> getEmergencyTeamSessions() {
    return http.get(
      Uri.parse('$baseUrl/emergency-team-sessions'),
      headers: headers,
    );
  }

  Future<http.Response> writeJournal(String content) {
    return http.post(
      Uri.parse('$baseUrl/write-journal'),
      headers: headers,
      body: jsonEncode({'entry_content': content}),
    );
  }

  Future<http.Response> deleteJournalEntry(String journalId) {
    return http.delete(
      Uri.parse('$baseUrl/delete-journal-entry/$journalId'),
      headers: headers,
    );
  }

  Future<http.Response> getProfileData() {
    return http.get(
      Uri.parse('$baseUrl/get-profile-data'),
      headers: headers,
    );
  }
}
