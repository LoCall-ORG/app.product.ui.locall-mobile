import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService extends GetxService {
  static const baseUrl = 'http://192.168.31.250:3200';
  // use this when runnung on emulator
  // static const baseUrl = 'http://localhost:3200';

  String _constructUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }

  Future<http.Response> postRequest(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    final url = _constructUrl(endpoint);
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers ?? {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getRequest(String endpoint,
      {Map<String, String>? headers}) async {
    final url = _constructUrl(endpoint);
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> putRequest(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    final url = _constructUrl(endpoint);
    try {
      final response =
          await http.put(Uri.parse(url), body: body, headers: headers);
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> deleteRequest(String endpoint,
      {Map<String, String>? headers}) async {
    final url = _constructUrl(endpoint);
    try {
      final response = await http.delete(Uri.parse(url), headers: headers);
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  http.Response _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response; // Success
    } else {
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  }
}
