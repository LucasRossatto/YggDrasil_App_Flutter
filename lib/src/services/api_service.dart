import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  Future<dynamic> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.get(url);

    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      // sucesso
      return jsonDecode(response.body);
    } else if (statusCode == 400) {
      throw Exception("Requisição inválida (400): ${response.body}");
    } else if (statusCode == 401) {
      throw Exception("Não autorizado (401). Verifique sua autenticação.");
    } else if (statusCode == 403) {
      throw Exception("Acesso negado (403).");
    } else if (statusCode == 404) {
      throw Exception("Recurso não encontrado (404).");
    } else if (statusCode >= 500) {
      throw Exception("Erro no servidor ($statusCode).");
    } else {
      throw Exception("Erro inesperado: $statusCode");
    }
  }
}
