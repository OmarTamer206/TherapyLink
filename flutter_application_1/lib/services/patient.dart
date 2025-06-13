import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class PatientApi {
  final String baseUrl ='http://localhost:3000';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  PatientApi();

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
      // Handle unauthorized or token expired if needed globally
      throw Exception('Unauthorized: ${response.body}');
    }
    return response;
  }

  // Change therapist preference
  Future<bool> changeTherapistPreference(String choice) async {
    final url = Uri.parse('$baseUrl/patient/change-therapist-preference');
    final headers = await _headers();
    final body = jsonEncode({'choice': choice});

    final response = await _handleRequest(http.put(url, headers: headers, body: body));

    return response.statusCode == 200;
  }

  // Submit feedback
  Future<bool> submitFeedback({
    required var session,
    required int rating,
    required String feedback,
    required bool editState,
  }) async {
    final url = Uri.parse('$baseUrl/patient/submit-feedback');
    final headers = await _headers();
    final body = jsonEncode({
      'session': session,
      'rating': rating,
      'feedback': feedback,
      'editState': editState,
    });

    final response = await _handleRequest(http.post(url, headers: headers, body: body));
    return response.statusCode == 200;
  }

  // Check feedback
  Future<Map<String, dynamic>> checkFeedback(var sessionID, var sessionType) async {
    final url = Uri.parse('$baseUrl/patient/check-feedback/$sessionID/$sessionType');
    final headers = await _headers();

    final response = await _handleRequest(http.get(url, headers: headers));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to get feedback');
  }

  // Make appointment
  Future<bool> makeAppointment(Map<String, dynamic> sessionData) async {
    final url = Uri.parse('$baseUrl/patient/make-appointment');
    final headers = await _headers();
    final body = jsonEncode({'sessionData': sessionData});

    final response = await _handleRequest(http.post(url, headers: headers, body: body));
    return response.statusCode == 201;
  }

  // Get doctor sessions taken
  Future<Map<String, dynamic>> getDoctorSessionsTaken() async {
    final url = Uri.parse('$baseUrl/patient/doctor-sessions');
    final headers = await _headers();

    final response = await _handleRequest(http.get(url, headers: headers));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to get doctor sessions');
  }

  // Get group sessions taken
  Future<Map<String, dynamic>> getGroupSessionsTaken() async {
    final url = Uri.parse('$baseUrl/patient/group-sessions');
    final headers = await _headers();

    final response = await _handleRequest(http.get(url, headers: headers));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to get group sessions');
  }

  // Get emergency team sessions taken
  Future<Map<String, dynamic>> getEmergencyTeamSessionsTaken() async {
    final url = Uri.parse('$baseUrl/patient/emergency-team-sessions');
    final headers = await _headers();

    final response = await _handleRequest(http.get(url, headers: headers));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to get emergency team sessions');
  }

  // Write in journal
  Future<bool> writeInJournal(String entryContent) async {
    final url = Uri.parse('$baseUrl/patient/write-journal');
    final headers = await _headers();
    final body = jsonEncode({'entry_content': entryContent});

    final response = await _handleRequest(http.post(url, headers: headers, body: body));
    return response.statusCode == 201;
  }

  // Delete from journal
  Future<bool> deleteFromJournal(String journalId) async {
    final url = Uri.parse('$baseUrl/patient/delete-journal-entry/$journalId');
    final headers = await _headers();

    final response = await _handleRequest(http.delete(url, headers: headers));
    return response.statusCode == 200;
  }

  // Get profile data
  Future<Map<String, dynamic>> getProfileData() async {
    final url = Uri.parse('$baseUrl/patient/get-profile-data');
    final headers = await _headers();

    final response = await _handleRequest(http.get(url, headers: headers));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to get profile data');
  }
}
