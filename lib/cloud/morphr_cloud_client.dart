// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

/// Exception thrown when a cloud operation fails.
class MorphrCloudException implements Exception {
  final String message;
  final int? statusCode;

  const MorphrCloudException(this.message, {this.statusCode});

  @override
  String toString() =>
      'MorphrCloudException: $message${statusCode != null ? ' (Status code: $statusCode)' : ''}';
}

/// Authentication method used with Morphr Cloud
enum MorphrAuthMethod {
  /// JWT token-based authentication (for CLI and developer tools)
  jwt,

  /// API client credentials (for application integration)
  apiKey
}

/// Client for interacting with the Morphr Cloud API.
class MorphrCloudClient {
  /// Creates a new [MorphrCloudClient] instance with JWT authentication.
  ///
  /// The [baseUrl] parameter is the base URL of the Morphr Cloud API.
  /// The [onTokenRefreshed] callback is called when the access token is refreshed.
  MorphrCloudClient({
    required this.baseUrl,
    this.accessToken,
    this.refreshToken,
    this.onTokenRefreshed,
    this.timeout = const Duration(seconds: 30),
  })  : authMethod = MorphrAuthMethod.jwt,
        _clientId = null,
        _clientSecret = null;

  /// Creates a new [MorphrCloudClient] instance with API key authentication.
  ///
  /// The [baseUrl] parameter is the base URL of the Morphr Cloud API.
  /// The [clientId] and [clientSecret] are the API credentials for the app.
  factory MorphrCloudClient.withApiKey({
    required String baseUrl,
    required String clientId,
    required String clientSecret,
    Duration timeout = const Duration(seconds: 30),
  }) {
    return MorphrCloudClient._apiKey(
      baseUrl: baseUrl,
      clientId: clientId,
      clientSecret: clientSecret,
      timeout: timeout,
    );
  }

  /// Private constructor for API key authentication
  MorphrCloudClient._apiKey({
    required this.baseUrl,
    required String clientId,
    required String clientSecret,
    this.timeout = const Duration(seconds: 30),
  })  : authMethod = MorphrAuthMethod.apiKey,
        accessToken = null,
        refreshToken = null,
        onTokenRefreshed = null,
        _clientId = clientId,
        _clientSecret = clientSecret;

  /// Base URL of the Morphr Cloud API.
  final String baseUrl;

  /// Authentication method being used
  final MorphrAuthMethod authMethod;

  /// Current access token for JWT authentication.
  String? accessToken;

  /// Current refresh token for obtaining a new access token with JWT auth.
  String? refreshToken;

  /// Client ID for API key authentication
  final String? _clientId;

  /// Client Secret for API key authentication
  final String? _clientSecret;

  /// Callback that is called when the access token is refreshed.
  final void Function(String accessToken, String refreshToken)?
      onTokenRefreshed;

  /// Request timeout
  final Duration timeout;

  /// Flag to prevent multiple token refreshes at the same time
  bool _isRefreshing = false;

  /// Flag to track if the client is authenticated
  bool get isAuthenticated {
    if (authMethod == MorphrAuthMethod.jwt) {
      return accessToken != null && refreshToken != null;
    } else {
      return _clientId != null && _clientSecret != null;
    }
  }

  /// Makes a GET request to the specified [endpoint].
  ///
  /// If [requiresAuth] is true, authentication will be included in the request.
  /// Additional [headers] and [queryParams] can be provided.
  /// If a response is received, the body is parsed as JSON and returned.
  Future<Map<String, dynamic>> get(
    String endpoint, {
    bool requiresAuth = true,
    Map<String, String>? headers,
    Map<String, String>? queryParams,
  }) async {
    return _makeRequest(
      method: 'GET',
      endpoint: endpoint,
      requiresAuth: requiresAuth,
      headers: headers,
      queryParams: queryParams,
    );
  }

  /// Makes a POST request to the specified [endpoint] with the given [body].
  ///
  /// If [requiresAuth] is true, authentication will be included in the request.
  /// Additional [headers] can be provided.
  /// If a response is received, the body is parsed as JSON and returned.
  Future<Map<String, dynamic>> post(
    String endpoint, {
    dynamic body,
    bool requiresAuth = true,
    Map<String, String>? headers,
  }) async {
    return _makeRequest(
      method: 'POST',
      endpoint: endpoint,
      body: body,
      requiresAuth: requiresAuth,
      headers: headers,
    );
  }

  /// Makes an HTTP request with automatic token refresh on 401 responses.
  Future<Map<String, dynamic>> _makeRequest({
    required String method,
    required String endpoint,
    dynamic body,
    bool requiresAuth = true,
    Map<String, String>? headers,
    Map<String, String>? queryParams,
  }) async {
    try {
      // First attempt
      final response = await _executeRequest(
        method: method,
        endpoint: endpoint,
        body: body,
        requiresAuth: requiresAuth,
        headers: headers,
        queryParams: queryParams,
      );

      // Only try token refresh for JWT auth method
      if (response.statusCode == 401 &&
          authMethod == MorphrAuthMethod.jwt &&
          refreshToken != null) {
        final refreshed = await _refreshAccessToken();
        if (refreshed) {
          return _parseResponseBody(await _executeRequest(
            method: method,
            endpoint: endpoint,
            body: body,
            requiresAuth: requiresAuth,
            headers: headers,
            queryParams: queryParams,
          ));
        }
      }

      return _parseResponseBody(response);
    } on SocketException catch (_) {
      throw const MorphrCloudException(
          'Network error. Please check your internet connection.');
    } on http.ClientException catch (e) {
      throw MorphrCloudException('HTTP client error: ${e.message}');
    } catch (e) {
      throw MorphrCloudException('Unexpected error: $e');
    }
  }

  /// Executes the HTTP request and returns the response.
  Future<http.Response> _executeRequest({
    required String method,
    required String endpoint,
    dynamic body,
    bool requiresAuth = true,
    Map<String, String>? headers,
    Map<String, String>? queryParams,
  }) async {
    final uri = Uri.parse('$baseUrl/$endpoint').replace(
      queryParameters: queryParams,
    );

    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      ...headers ?? {},
    };

    if (requiresAuth) {
      if (authMethod == MorphrAuthMethod.jwt && accessToken != null) {
        // JWT authentication with Bearer token
        requestHeaders['Authorization'] = 'Bearer $accessToken';
      } else if (authMethod == MorphrAuthMethod.apiKey &&
          _clientId != null &&
          _clientSecret != null) {
        // API key authentication with Basic auth
        final credentials =
            base64Encode(utf8.encode('$_clientId:$_clientSecret'));
        requestHeaders['Authorization'] = 'Basic $credentials';
      }
    }

    final bodyJson = body != null ? jsonEncode(body) : null;

    http.Response response;
    switch (method) {
      case 'GET':
        response =
            await http.get(uri, headers: requestHeaders).timeout(timeout);
        break;
      case 'POST':
        response = await http
            .post(uri, headers: requestHeaders, body: bodyJson)
            .timeout(timeout);
        break;
      default:
        throw MorphrCloudException('Unsupported HTTP method: $method');
    }

    return response;
  }

  /// Parses the response body as JSON and handles error responses.
  Map<String, dynamic> _parseResponseBody(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        if (response.body.isEmpty) {
          return {};
        }
        return jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        throw MorphrCloudException('Failed to parse response: $e');
      }
    } else {
      final message = _extractErrorMessage(response);
      throw MorphrCloudException(message, statusCode: response.statusCode);
    }
  }

  /// Extracts an error message from the response.
  String _extractErrorMessage(http.Response response) {
    try {
      final body = jsonDecode(response.body);
      if (body is Map<String, dynamic>) {
        if (body.containsKey('message')) {
          return body['message'] as String;
        } else if (body.containsKey('error')) {
          return body['error'] as String;
        }
      }
      return 'Server error: ${response.statusCode}';
    } catch (_) {
      if (response.statusCode >= 400) return response.body;
      return 'Server error: ${response.statusCode}';
    }
  }

  /// Refreshes the access token using the refresh token.
  ///
  /// Returns true if the token was successfully refreshed, otherwise false.
  Future<bool> _refreshAccessToken() async {
    if (_isRefreshing || refreshToken == null) {
      return false;
    }

    try {
      _isRefreshing = true;

      final uri = Uri.parse('$baseUrl/refresh');
      final response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'refreshToken': refreshToken}),
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        accessToken = data['token'] as String;

        onTokenRefreshed?.call(accessToken!, refreshToken!);
        return true;
      }

      accessToken = null;
      refreshToken = null;
      return false;
    } catch (e) {
      accessToken = null;
      refreshToken = null;
      return false;
    } finally {
      _isRefreshing = false;
    }
  }

  /// Synchronizes a project with the development environment.
  ///
  /// [projectId] is the ID of the project to synchronize.
  /// [figmaFileHash] is the hash of the current Figma file state.
  /// If provided, the server will only send patches if there are changes.
  ///
  /// Returns a map containing patches and the updated file hash.
  Future<Map<String, dynamic>> syncDev({
    required int projectId,
    String? figmaFileHash,
  }) async {
    return get(
      'projects/$projectId/sync/dev',
      queryParams:
          figmaFileHash != null ? {'figmaFileHash': figmaFileHash} : {},
    );
  }
}
