import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';
  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<Map<String, dynamic>> get(String endpoint) async {
    final url = Uri.parse(baseUrl).replace(path: endpoint);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return _handleResponse(response);
    } else {
      throw Exception(
        "Erro na requisição: ${response.statusCode} ${response.body}",
      );
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final url = Uri.parse(baseUrl).replace(path: endpoint);
    final response = await client.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    }
    throw Exception("Erro HTTP ${response.statusCode}: ${response.body}");
  }
}
