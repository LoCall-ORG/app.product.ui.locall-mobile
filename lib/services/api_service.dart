import 'package:locall/config/app_config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final AppConfig appConfig;

  ApiService({required this.appConfig});

  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('${appConfig.baseUrl}$endpoint'));

    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    final response = await http.post(
      Uri.parse('${appConfig.baseUrl}$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    final responseBody = json.decode(response.body);

    switch (response.statusCode) {
      case 200:
        return responseBody;
      case 201:
        return responseBody;
      case 400:
      case 401:
      case 403:
      case 404:
      case 500:
        String errorMessage =
            responseBody['error'] ?? 'An unexpected error occurred.';
        throw Exception(errorMessage);
      default:
        throw Exception('Error: ${response.statusCode}');
    }
  }
}
