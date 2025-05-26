import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://localhost:3000';

class AgentApi {
  static Future<http.Response> startChat(Map<String, dynamic> body) {
    return http.post(
      Uri.parse('$baseUrl/api/chat/start'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> getQuestion(Map<String, dynamic> body) {
    return http.post(
      Uri.parse('$baseUrl/api/chat/ask'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> respondToChat(Map<String, dynamic> body) {
    return http.post(
      Uri.parse('$baseUrl/api/chat/respond'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> getSummary(Map<String, dynamic> body) {
    return http.post(
      Uri.parse('$baseUrl/api/chat/summary'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
  }
}
