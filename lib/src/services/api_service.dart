import 'dart:convert';
import 'dart:io'; // <- necessário para SocketException
import 'dart:async'; // <- necessário para TimeoutException
import 'package:http/http.dart' as http;

class ApiService {
static const String baseUrl = 'https://api1.yggdrasil.eco.br/'; // troque pelo seu IP
  //final String baseUrl  = 'https://api1.yggdrasil.eco.br/';

  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final url = Uri.parse(baseUrl).replace(path: endpoint);
      final response = await client
          .get(url)
          .timeout(const Duration(seconds: 30)); // timeout de 10s
      return _handleResponse(response);
    } on SocketException {
      throw Exception("Sem conexão com a internet");
    } on TimeoutException {
      throw Exception("Tempo de requisição expirado");
    } catch (e) {
      throw Exception("Erro inesperado: $e");
    }
  }

  Future<Map<String, dynamic>> getWithQuery(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse(baseUrl).replace(
        path: endpoint,
        queryParameters: queryParameters,
      );

      final response = await client
          .get(uri)
          .timeout(const Duration(seconds: 30));
      return _handleResponse(response);
    } on SocketException {
      throw Exception("Sem conexão com a internet");
    } on TimeoutException {
      throw Exception("Tempo de requisição expirado");
    } catch (e) {
      throw Exception("Erro inesperado: $e");
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final url = Uri.parse(baseUrl).replace(path: endpoint);
      final response = await client
          .post(
            url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 30));
      return _handleResponse(response);
    } on SocketException {
      throw Exception("Sem conexão com a internet");
    } on TimeoutException {
      throw Exception("Tempo de requisição expirado");
    } catch (e) {
      throw Exception("Erro inesperado: $e");
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    }
    throw Exception("Erro HTTP ${response.statusCode}: ${response.body}");
  }
}
