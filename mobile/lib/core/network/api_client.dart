import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final http.Client _client;

  ApiClient({required this.baseUrl}) : _client = http.Client();

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final response = await _client.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['error'] ?? 'An error occurred');
    }
  }

  void dispose() {
    _client.close();
  }
} 