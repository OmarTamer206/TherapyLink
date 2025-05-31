import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AgentApi {
  final String baseUrl  ='http://localhost:3000';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> _getToken() async => await _storage.read(key: 'jwt_token');

  Map<String, String> _headers(String token) => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

  AgentApi();



  // POST /chat/start
  Future<Map<String, dynamic>?> startChat(String sessionId) async {
    final token = await _getToken();
    if (token == null) return null;

    final url = Uri.parse('$baseUrl/agent/start');
    final response = await http.post(url,
        headers: _headers(token),
        body: jsonEncode({"sessionId" : sessionId}));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to start chat: ${response.body}');
    }
  }

  // POST /chat/ask
  Future<Map<String, dynamic>?> getQuestion(String sessionId) async {
    final token = await _getToken();
    if (token == null) return null;
    
    final url = Uri.parse('$baseUrl/agent/ask');
    final response = await http.post(url,
        headers: _headers(token),
        body: jsonEncode({"sessionId" : sessionId}));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get question: ${response.body}');
    }
  }

  // POST /chat/respond
  Future<Map<String, dynamic>?> respondToChat(String sessionId , String userInput) async {
    final token = await _getToken();
    if (token == null) return null;

    final url = Uri.parse('$baseUrl/agent/respond');
    final response = await http.post(url,
        headers: _headers(token),
        body: jsonEncode({"sessionId" : sessionId,"userInput" :userInput}));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to respond to chat: ${response.body}');
    }
  }

  // POST /chat/summary
  Future<Map<String, dynamic>?> getSummary(String sessionId) async {
    final token = await _getToken();
    if (token == null) return null;

    final url = Uri.parse('$baseUrl/agent/summary');
    final response = await http.post(url,
        headers: _headers(token),
        body: jsonEncode({"sessionId" : sessionId}));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get summary: ${response.body}');
    }
  }
}
