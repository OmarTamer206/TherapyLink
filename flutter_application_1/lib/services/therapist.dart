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

  // Get all therapists
  Future<List<dynamic>?> getTherapists() async {
    final token = await _getToken();
    if (token == null) return null;

    final response = await http.get(
      Uri.parse('$_baseUrl/therapists'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // Get therapist by ID
  Future<Map<String, dynamic>?> getTherapistById(String id) async {
    final token = await _getToken();
    if (token == null) return null;

    final response = await http.get(
      Uri.parse('$_baseUrl/therapists/$id'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // Create therapist
  Future<bool> createTherapist(Map<String, dynamic> therapistData) async {
    final token = await _getToken();
    if (token == null) return false;

    final response = await http.post(
      Uri.parse('$_baseUrl/therapists'),
      headers: _headers(token),
      body: jsonEncode(therapistData),
    );

    return response.statusCode == 201;
  }

  // Update therapist
  Future<bool> updateTherapist(String id, Map<String, dynamic> therapistData) async {
    final token = await _getToken();
    if (token == null) return false;

    final response = await http.put(
      Uri.parse('$_baseUrl/therapists/$id'),
      headers: _headers(token),
      body: jsonEncode(therapistData),
    );

    return response.statusCode == 200;
  }

  // Delete therapist
  Future<bool> deleteTherapist(String id) async {
    final token = await _getToken();
    if (token == null) return false;

    final response = await http.delete(
      Uri.parse('$_baseUrl/therapists/$id'),
      headers: _headers(token),
    );

    return response.statusCode == 200;
  }
}
