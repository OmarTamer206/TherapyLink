import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthApi {
  static const _baseUrl = 'http://localhost:3000'; // <-- Change this to your backend base URL
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Save JWT token securely
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  // Get JWT token
  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  // Delete JWT token (logout)
  Future<void> deleteToken() async {
    await _storage.delete(key: 'jwt_token');
  }

  // Login method - expects username & password, returns true if successful
  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/auth/login');
    final data = <String, dynamic>{'email': email, 'password': password};
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token']; // Adjust key based on your backend response
      if (token != null) {
        await saveToken(token);
        return true;
      }
    }
    return false;
  }

  // Register method example (adjust fields as needed)
  Future<bool> register(Map<String, dynamic> userData) async {
    final url = Uri.parse('$_baseUrl/auth/register');
    final data = userData;
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return response.statusCode == 201;
  }

  // Example: Get current user profile with token auth
  Future<Map<String, dynamic>?> getProfile() async {
    final url = Uri.parse('$_baseUrl/auth/profile');
    final token = await getToken();
    if (token == null) return null;

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // Logout
  Future<void> logout() async {
    await deleteToken();
  }


  // Check if email is already registered (adjust endpoint as per your backend)
  Future<String> checkEmailExists(String email) async {
    final url = Uri.parse('$_baseUrl/auth/check-email');
    final data = {"email":email};
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    }
    return "error"; // Assume not existing on failure
  }

}
