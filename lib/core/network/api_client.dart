import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../errors/network_exception.dart';

class ApiClient {
  static const String _baseUrl = 'https://your-api-domain.com'; // Replace with your actual API URL
  static const String _apiVersion = '/api';
  
  final http.Client _client;
  String? _accessToken;
  String? _refreshToken;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  String get baseUrl => _baseUrl + _apiVersion;

  // Set tokens after login
  void setTokens(String accessToken, String refreshToken) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  // Clear tokens on logout
  void clearTokens() {
    _accessToken = null;
    _refreshToken = null;
  }

  // Get headers with auth token
  Map<String, String> get _headers {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (_accessToken != null) {
      headers['Authorization'] = 'Bearer $_accessToken';
    }

    return headers;
  }

  // Load tokens from storage
  Future<void> loadTokensFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('access_token');
    _refreshToken = prefs.getString('refresh_token');
  }

  // Save tokens to storage
  Future<void> saveTokensToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    if (_accessToken != null) {
      await prefs.setString('access_token', _accessToken!);
    }
    if (_refreshToken != null) {
      await prefs.setString('refresh_token', _refreshToken!);
    }
  }

  // GET request
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? queryParameters,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final response = await _client.get(uri, headers: _headers);
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // POST request
  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final response = await _client.post(
        uri,
        headers: _headers,
        body: body != null ? jsonEncode(body) : null,
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // PUT request
  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final response = await _client.put(
        uri,
        headers: _headers,
        body: body != null ? jsonEncode(body) : null,
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // PATCH request
  Future<Map<String, dynamic>> patch(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final response = await _client.patch(
        uri,
        headers: _headers,
        body: body != null ? jsonEncode(body) : null,
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE request
  Future<Map<String, dynamic>?> delete(
    String endpoint, {
    Map<String, String>? queryParameters,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final response = await _client.delete(uri, headers: _headers);
      
      // DELETE requests might return empty body (204 No Content)
      if (response.statusCode == 204) {
        return null;
      }
      
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Multipart request for file uploads
  Future<Map<String, dynamic>> multipartRequest(
    String endpoint,
    String method, {
    Map<String, String>? fields,
    Map<String, File>? files,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final request = http.MultipartRequest(method, uri);
      
      // Add headers (excluding Content-Type as it's set automatically)
      final headers = Map<String, String>.from(_headers);
      headers.remove('Content-Type');
      request.headers.addAll(headers);

      // Add fields
      if (fields != null) {
        request.fields.addAll(fields);
      }

      // Add files
      if (files != null) {
        for (final entry in files.entries) {
          final file = entry.value;
          final multipartFile = await http.MultipartFile.fromPath(
            entry.key,
            file.path,
          );
          request.files.add(multipartFile);
        }
      }

      final streamedResponse = await _client.send(request);
      final response = await http.Response.fromStream(streamedResponse);
      
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Refresh access token
  Future<void> refreshAccessToken() async {
    if (_refreshToken == null) {
      throw const NetworkException(
        message: 'No refresh token available',
        statusCode: 401,
      );
    }

    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/users/token/refresh/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refresh': _refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _accessToken = data['access'];
        await saveTokensToStorage();
      } else {
        throw const NetworkException(
          message: 'Failed to refresh token',
          statusCode: 401,
        );
      }
    } catch (e) {
      clearTokens();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');
      await prefs.remove('refresh_token');
      rethrow;
    }
  }

  // Build URI with query parameters
  Uri _buildUri(String endpoint, Map<String, String>? queryParameters) {
    final path = endpoint.startsWith('/') ? endpoint : '/$endpoint';
    return Uri.parse('$baseUrl$path').replace(
      queryParameters: queryParameters,
    );
  }

  // Handle HTTP response
  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {};
      }
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw NetworkException.fromResponse(response);
    }
  }

  // Handle errors
  NetworkException _handleError(dynamic error) {
    if (error is NetworkException) {
      return error;
    } else if (error is SocketException) {
      return const NetworkException(
        message: 'No internet connection',
        statusCode: 0,
      );
    } else if (error is HttpException) {
      return NetworkException(
        message: error.message,
        statusCode: 0,
      );
    } else {
      return NetworkException(
        message: 'An unexpected error occurred: ${error.toString()}',
        statusCode: 0,
      );
    }
  }

  // Dispose client
  void dispose() {
    _client.close();
  }
}
