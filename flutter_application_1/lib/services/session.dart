import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class SessionApi {
  final String baseUrl =  'http://localhost:3000';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  SessionApi();

  Future<String?> _getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  Future<Map<String, String>> _headers() async {
    final token = await _getToken();
    if (token == null) throw Exception('No token found');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> _handleRequest(Future<http.Response> future) async {
    final response = await future;
    if (response.statusCode == 401) {
      // handle unauthorized (token expired/invalid)
      throw Exception('Unauthorized: ${response.body}');
    }
    return response;
  }

  // View upcoming sessions for patient
  Future<List<dynamic>> getUpcomingSessionsPatient() async {
    final url = Uri.parse('$baseUrl/session/view-upcoming-sessions-patient');
    final headers = await _headers();
    final response = await _handleRequest(http.get(url, headers: headers));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'] ?? [];
    }
    throw Exception('Failed to get upcoming sessions for patient');
  }

  // View previous sessions for patient
  Future<List<dynamic>> getPreviousSessionsPatient() async {
    final url = Uri.parse('$baseUrl/session/view-previous-sessions-patient');
    final headers = await _headers();
    final response = await _handleRequest(http.get(url, headers: headers));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'] ?? [];
    }
    throw Exception('Failed to get previous sessions for patient');
  }

  // View upcoming sessions for doctor (requires doctor ID)
  Future<List<dynamic>> getUpcomingSessionsDoctor(String doctorId) async {
    final url = Uri.parse('$baseUrl/session/view-upcoming-sessions-doctor/$doctorId');
    final response = await http.get(url); // no token required as per backend
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'] ?? [];
    }
    throw Exception('Failed to get upcoming sessions for doctor');
  }

  // View old sessions for patient (requires patient ID)
  Future<List<dynamic>> getOldSessionsPatient(String patientId) async {
    final url = Uri.parse('$baseUrl/session/view-old-sessions/$patientId');
    final response = await http.get(url); // no token required per backend
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'] ?? [];
    }
    throw Exception('Failed to get old sessions for patient');
  }

  // Get chat messages for a chatId
  Future<List<dynamic>> getChatMessages(String chatId) async {
    final url = Uri.parse('$baseUrl/session/get-messages/$chatId');
    final response = await http.get(url); // no token required per backend
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'] ?? [];
    }
    throw Exception('Failed to get chat messages');
  }

  // View session details (requires sessionId)
  Future<Map<String, dynamic>> getSessionDetails(String sessionId) async {
    final url = Uri.parse('$baseUrl/session/view-session-details/$sessionId/');
    final headers = await _headers();
    final response = await _handleRequest(http.get(url, headers: headers));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'] ?? {};
    }
    throw Exception('Failed to get session details');
  }

  // Initialize communication (chat or video link)
  Future<Map<String, dynamic>> initializeCommunication({
    required String sessionId,
    required String sessionType,
  }) async {
    final url = Uri.parse('$baseUrl/session/initialize-communication');
    final body = jsonEncode({'session_id': sessionId, 'session_type': sessionType});
    final response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'] ?? {};
    }
    throw Exception('Failed to initialize communication');
  }

  // Initialize emergency session (requires patientId)
  Future<Map<String, dynamic>> initializeEmergencySession(String patientId) async {
    final url = Uri.parse('$baseUrl/session/initialize-emergency-session/$patientId');
    final response = await http.post(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'] ?? {};
    }
    throw Exception('Failed to initialize emergency session');
  }

  // Cancel a session
  Future<bool> cancelSession(String sessionId) async {
    final url = Uri.parse('$baseUrl/session/cancel-session');
    final headers = await _headers();
    final body = jsonEncode({'session_ID': sessionId});
    final response = await _handleRequest(http.post(url, headers: headers, body: body));
    return response.statusCode == 200;
  }
}
