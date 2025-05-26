import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000'; // Replace with your IP and port

  // LOGIN
  static Future<http.Response> loginStaff(String email, String password) {
    return http.post(
      Uri.parse('$baseUrl/login-staff'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
  }

  // REFRESH TOKEN
  static Future<http.Response> refreshToken(String refreshToken) {
    return http.post(
      Uri.parse('$baseUrl/refresh-token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    );
  }

  // PATIENT REGISTRATION
  static Future<http.Response> registerPatient(Map<String, dynamic> data) {
    return http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }

  // THERAPIST REGISTRATION
  static Future<http.Response> registerTherapist(Map<String, dynamic> data) {
    return http.post(
      Uri.parse('$baseUrl/register-therapist'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }

  // ADMIN REGISTRATION
  static Future<http.Response> registerAdmin(Map<String, dynamic> data) {
    return http.post(
      Uri.parse('$baseUrl/register-admin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }

  // EMERGENCY TEAM REGISTRATION
  static Future<http.Response> registerEmergencyTeam(Map<String, dynamic> data) {
    return http.post(
      Uri.parse('$baseUrl/register-emergency-member'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }

  // UPDATES
  static Future<http.Response> updatePatient(Map<String, dynamic> data) {
    return http.put(
      Uri.parse('$baseUrl/update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }

  static Future<http.Response> updateTherapist(Map<String, dynamic> data) {
    return http.put(
      Uri.parse('$baseUrl/update-therapist'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }

  static Future<http.Response> updateAdmin(Map<String, dynamic> data) {
    return http.put(
      Uri.parse('$baseUrl/update-admin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }

  static Future<http.Response> updateEmergencyTeam(Map<String, dynamic> data) {
    return http.put(
      Uri.parse('$baseUrl/update-emergency-member'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }

  // DELETE USER
  static Future<http.Response> deleteUser(String id, String role) {
    return http.delete(
      Uri.parse('$baseUrl/delete-user'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id, 'role': role}),
    );
  }

  // CHECK EMAIL
  static Future<http.Response> checkEmail(String email) {
    return http.post(
      Uri.parse('$baseUrl/check-email'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
  }

  // UPLOAD PROFILE PICTURE
  static Future<http.StreamedResponse> uploadProfilePicture(String filePath) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/upload-profile-pic'),
    );
    request.files.add(await http.MultipartFile.fromPath('file', filePath));
    return request.send();
  }
}
