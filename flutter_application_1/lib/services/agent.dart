import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AgentApi {
  static const _baseUrl = 'http://localhost:3000'; // Update accordingly
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> _getToken() async => await _storage.read(key: 'jwt_token');

  Map<String, String> _headers(String token) => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

  // Get all agents
  Future<List<dynamic>?> getAgents() async {
    final token = await _getToken();
    if (token == null) return null;

    final response = await http.get(
      Uri.parse('$_baseUrl/agents'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // Get agent by ID
  Future<Map<String, dynamic>?> getAgentById(String id) async {
    final token = await _getToken();
    if (token == null) return null;

    final response = await http.get(
      Uri.parse('$_baseUrl/agents/$id'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // Create new agent
  Future<bool> createAgent(Map<String, dynamic> agentData) async {
    final token = await _getToken();
    if (token == null) return false;

    final response = await http.post(
      Uri.parse('$_baseUrl/agents'),
      headers: _headers(token),
      body: jsonEncode(agentData),
    );

    return response.statusCode == 201;
  }

  // Update agent
  Future<bool> updateAgent(String id, Map<String, dynamic> agentData) async {
    final token = await _getToken();
    if (token == null) return false;

    final response = await http.put(
      Uri.parse('$_baseUrl/agents/$id'),
      headers: _headers(token),
      body: jsonEncode(agentData),
    );

    return response.statusCode == 200;
  }

  // Delete agent
  Future<bool> deleteAgent(String id) async {
    final token = await _getToken();
    if (token == null) return false;

    final response = await http.delete(
      Uri.parse('$_baseUrl/agents/$id'),
      headers: _headers(token),
    );

    return response.statusCode == 200;
  }
}
