import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthApiException implements Exception {
  const AuthApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class EmailSignupChallenge {
  const EmailSignupChallenge({
    required this.id,
    required this.expiresInSeconds,
  });

  final String id;
  final int expiresInSeconds;
}

class EmailAuthApi {
  EmailAuthApi({
    http.Client? client,
    FlutterSecureStorage? secureStorage,
    String? baseUrl,
  }) : _client = client ?? http.Client(),
       _secureStorage = secureStorage ?? const FlutterSecureStorage(),
       _baseUrl = (baseUrl ?? _configuredBaseUrl).replaceAll(RegExp(r'/$'), '');

  static const _environmentBaseUrl = String.fromEnvironment('API_BASE_URL');
  static String get _configuredBaseUrl {
    if (_environmentBaseUrl.isNotEmpty) return _environmentBaseUrl;
    return 'http://169.58.165.98:8000/api/v1';
  }

  static const _tokenKey = 'visualyou_auth_token';

  final http.Client _client;
  final FlutterSecureStorage _secureStorage;
  final String _baseUrl;

  void close() => _client.close();

  Future<EmailSignupChallenge> startSignup(String email) async {
    final data = await _post('/auth/email/start/', {'email': email});
    return EmailSignupChallenge(
      id: data['challenge_id'] as String,
      expiresInSeconds: data['expires_in_seconds'] as int,
    );
  }

  Future<String> verifyCode({
    required String challengeId,
    required String code,
  }) async {
    final data = await _post('/auth/email/verify/', {
      'challenge_id': challengeId,
      'code': code,
    });
    return data['setup_token'] as String;
  }

  Future<void> completeSignup({
    required String challengeId,
    required String setupToken,
    required String password,
  }) async {
    final data = await _post('/auth/email/complete/', {
      'challenge_id': challengeId,
      'setup_token': setupToken,
      'password': password,
    });
    await _saveToken(data);
  }

  Future<void> login({required String email, required String password}) async {
    final data = await _post('/auth/email/login/', {
      'email': email,
      'password': password,
    });
    await _saveToken(data);
  }

  Future<bool> logout() async {
    final token = await _secureStorage.read(key: _tokenKey);
    if (token == null || token.isEmpty) return false;
    try {
      await _client
          .post(
            Uri.parse('$_baseUrl/auth/logout/'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Token $token',
            },
          )
          .timeout(const Duration(seconds: 15));
    } catch (_) {
      // Local sign-out must still work while the backend is unavailable.
    } finally {
      await _secureStorage.delete(key: _tokenKey);
    }
    return true;
  }

  Future<void> _saveToken(Map<String, dynamic> data) async {
    final token = data['token'];
    if (token is! String || token.isEmpty) {
      throw const AuthApiException(
        'The server returned an invalid sign-in response.',
      );
    }
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  Future<Map<String, dynamic>> _post(
    String path,
    Map<String, dynamic> body,
  ) async {
    http.Response response;
    try {
      response = await _client
          .post(
            Uri.parse('$_baseUrl$path'),
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 15));
    } catch (_) {
      throw const AuthApiException(
        'Could not connect to Visual You. Check your internet connection and try again.',
      );
    }
    dynamic decoded;
    try {
      decoded = jsonDecode(response.body);
    } catch (_) {
      decoded = null;
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw AuthApiException(_errorMessage(decoded));
    }
    if (decoded is! Map<String, dynamic>) {
      throw const AuthApiException('The server returned an invalid response.');
    }
    return decoded;
  }

  String _errorMessage(dynamic decoded) {
    if (decoded is Map<String, dynamic>) {
      final detail = decoded['detail'];
      if (detail is String) return detail;
      for (final value in decoded.values) {
        if (value is List && value.isNotEmpty) return value.first.toString();
        if (value is String) return value;
      }
    }
    return 'Something went wrong. Please try again.';
  }
}
