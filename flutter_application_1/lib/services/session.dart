import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://localhost:3000';
Map<String, String> headers(String token) => {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer $token'
};

class SessionApi {
  static Future<http.Response> getUpcomingSessionsPatient(String token) {
    return http.get(
      Uri.parse('$baseUrl/api/sessions/view-upcoming-sessions-patient'),
      headers: headers(token),
    );
  }

  static Future<http.Response> getPreviousSessionsPatient(String token) {
    return http.get(
      Uri.parse('$baseUrl/api/sessions/view-previous-sessions-patient'),
      headers: headers(token),
    );
  }

  static Future<http.Response> getUpcomingSessionsDoctor(String doctorId) {
    return http.get(
      Uri.parse('$baseUrl/api/sessions/view-upcoming-sessions-doctor/$doctorId'),
    );
  }

  static Future<http.Response> getOldSessions(String patientId) {
    return http.get(
      Uri.parse('$baseUrl/api/sessions/view-old-sessions/$patientId'),
    );
  }

  static Future<http.Response> getSessionDetails(String sessionId, String token) {
    return http.get(
      Uri.parse('$baseUrl/api/sessions/view-session-details/$sessionId'),
      headers: headers(token),
    );
  }

  static Future<http.Response> initializeCommunication(String sessionId, String sessionType) {
    return http.post(
      Uri.parse('$baseUrl/api/sessions/initialize-communication'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'session_id': sessionId,
        'session_type': sessionType
      }),
    );
  }

  static Future<http.Response> initializeEmergencySession(String patientId) {
    return http.post(
      Uri.parse('$baseUrl/api/sessions/initialize-emergency-session/$patientId'),
    );
  }

  static Future<http.Response> cancelSession(String sessionId, String token) {
    return http.post(
      Uri.parse('$baseUrl/api/sessions/cancel-session'),
      headers: headers(token),
      body: jsonEncode({'session_ID': sessionId}),
    );
  }

  static Future<http.Response> getMessages(String chatId) {
    return http.get(
      Uri.parse('$baseUrl/api/sessions/get-messages/$chatId'),
    );
  }
}
