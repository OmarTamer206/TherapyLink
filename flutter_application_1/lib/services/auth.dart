import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthApi {
  static const _baseUrl = 'http://localhost:3000';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Token storage
  Future<void> saveToken(String token) async => await _storage.write(key: 'jwt_token', value: token);
  Future<String?> getToken() async => await _storage.read(key: 'jwt_token');
  Future<void> deleteToken() async => await _storage.delete(key: 'jwt_token');

    Future<Map<String, String>> _headers() async {
    final token = await getToken();
    if (token == null) throw Exception('No token found');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Login (patient)
  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/auth/login');
    final res = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password})
    );
    
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final token = data['token']; // Adjust key based on your backend response
      if (token != null) {
        await saveToken(token);
        return true;
      }
  }
    return false;
  }
  // Login (staff)
  Future<Map<String, dynamic>?> loginStaff(String email, String password) async {
    final url = Uri.parse('$_baseUrl/auth/login-staff');
    final res = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password})
    );
    if (res.statusCode == 200) return jsonDecode(res.body);
    return null;
  }

  // Refresh token
  Future<String?> refreshToken(String refreshToken) async {
    final url = Uri.parse('$_baseUrl/auth/refresh-token');
    final res = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken})
    );
    if (res.statusCode == 200) return jsonDecode(res.body)['token'];
    return null;
  }

  // Upload profile picture
  Future<String?> uploadProfilePic(String filePath) async {
    final url = Uri.parse('$_baseUrl/auth/upload-profile-pic');
    final request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('file', filePath));

    final res = await request.send();
    if (res.statusCode == 200) {
      final body = await res.stream.bytesToString();
      return jsonDecode(body)['fileName'];
    }
    return null;
  }

  // Register (patient)
  Future<bool> registerPatient(Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/auth/register');
    final res = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return res.statusCode == 201;
  }

  // Register therapist
  Future<bool> registerTherapist(Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/auth/register-therapist');
    final res = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return res.statusCode == 201;
  }

  // Register admin
  Future<bool> registerAdmin(Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/auth/register-admin');
    final res = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return res.statusCode == 201;
  }

  // Register emergency member
  Future<bool> registerEmergencyMember(Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/auth/register-emergency-member');
    final res = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return res.statusCode == 201;
  }

  // Update patient
  Future<bool> updatePatient(Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/auth/update');
    final res = await http.put(url,
      headers: await _headers(),
      body: jsonEncode(data),
    );
    return res.statusCode == 201;
  }


  // Delete user
  Future<bool> deleteUser(String id) async {
    final url = Uri.parse('$_baseUrl/auth/delete-user');
    final res = await http.delete(url,
      headers: await _headers(),
      body: jsonEncode({'id': id, 'role': "patient"}),
    );
    return res.statusCode == 201;
  }

  // Check if email exists
  Future<String> checkEmail(String email) async {
    final url = Uri.parse('$_baseUrl/auth/check-email');
    final res = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body)['data'];
    }
    return "error";
  }
}
