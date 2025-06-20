import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TherapistApi {
  static const _baseUrl = 'http://localhost:3000'; // Update backend URL
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> _getToken() async => await _storage.read(key: 'jwt_token');

  Map<String, String> _headers(String token) => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

  Future<List<dynamic>?> getTodaySessions() async {
    final token = await _getToken();
    if (token == null) return null;

    final response = await http.get(
      Uri.parse('$_baseUrl/therapist/today-sessions'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  Future<List<dynamic>?> getUpcomingSessions() async {
    final token = await _getToken();
    if (token == null) return null;

    final response = await http.get(
      Uri.parse('$_baseUrl/therapist/upcoming-sessions'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  Future<List<dynamic>?> getNewPatientsThisMonth() async {
    final token = await _getToken();
    if (token == null) return null;

    final response = await http.get(
      Uri.parse('$_baseUrl/therapist/new-patients-this-month'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  Future<dynamic> getTotalPatients() async {
    final token = await _getToken();
    if (token == null) return null;

    final response = await http.get(
      Uri.parse('$_baseUrl/therapist/total-patients'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  Future<List<dynamic>?> getPatientsData(String sessionId) async {
    final token = await _getToken();
    if (token == null) return null;

    final response = await http.get(
      Uri.parse('$_baseUrl/therapist/patients-data/$sessionId'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  Future<dynamic> getPatientData(String patientId) async {
    // Note: Your backend does not require auth here. Add headers if needed.
    final response =
        await http.get(Uri.parse('$_baseUrl/therapist/patient-data/$patientId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  Future<bool> updatePatientReport(
      Map<String, dynamic> sessionData, Map<String, dynamic> report) async {
    final token = await _getToken();
    if (token == null) return false;

    final body = jsonEncode({'session_data': sessionData, 'report': report});

    final response = await http.put(
      Uri.parse('$_baseUrl/therapist/update-patient-report'),
      headers: _headers(token),
      body: body,
    );

    return response.statusCode == 200;
  }

  Future<Map<String, dynamic>?> viewAvailableDays( String? doctorId, String? doctorType) async {
    final token = await _getToken();
    if (token == null) return null;

    Uri url;
      url = Uri.parse('$_baseUrl/therapist/available-days/$doctorId/$doctorType');
    
    final response = await http.get(url, headers: _headers(token));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  Future<Map<String, dynamic>?> viewAvailableTime(String date, String? doctorId, String? doctorType) async {
    final token = await _getToken();
    if (token == null) return null;

    Uri url;
    if (doctorId != null && doctorType != null) {
      url = Uri.parse('$_baseUrl/therapist/available-time/$date/$doctorId/$doctorType');
    } else {
      url = Uri.parse('$_baseUrl/therapist/available-time/$date');
    }

    final response = await http.get(url, headers: _headers(token));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  Future<bool> updateAvailableTime(String timestamp, {String? topic}) async {
    final token = await _getToken();
    if (token == null) return false;

    final body = jsonEncode({'timestamp': timestamp, 'topic': topic});

    final response = await http.put(
      Uri.parse('$_baseUrl/therapist/update-available-time'),
      headers: _headers(token),
      body: body,
    );

    return response.statusCode == 200;
  }

  Future<bool> deleteAvailableTime(String timestamp) async {
    final token = await _getToken();
    if (token == null) return false;

    final body = jsonEncode({'timestamp': timestamp});

    final response = await http.delete(
      Uri.parse('$_baseUrl/therapist/delete-available-time'),
      headers: _headers(token),
      body: body,
    );

    return response.statusCode == 200;
  }

  Future<dynamic> getPatientAnalytics() async {
    final token = await _getToken();
    if (token == null) return null;

    final response = await http.get(
      Uri.parse('$_baseUrl/therapist/patient-analytics'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  Future<dynamic> getTherapistData() async {
    final token = await _getToken();
    if (token == null) return null;

    final response = await http.get(
      Uri.parse('$_baseUrl/therapist/get-therapist-data'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  Future<dynamic>? viewAllDoctors(
      String doctorType, String doctorSpecialization) async {
            final token = await _getToken();
    if (token == null) return null;

    final response = await http.get(
      Uri.parse('$_baseUrl/therapist/all-doctors/$doctorType/$doctorSpecialization'),
      headers: _headers(token),

    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }
}
