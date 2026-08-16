import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AiApiException implements Exception {
  const AiApiException(this.message);
  final String message;

  @override
  String toString() => message;
}

class AiConversationSummary {
  const AiConversationSummary({
    required this.id,
    required this.title,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final DateTime updatedAt;

  factory AiConversationSummary.fromJson(Map<String, dynamic> json) {
    return AiConversationSummary(
      id: json['id'] as String,
      title: (json['title'] as String?)?.trim() ?? '',
      updatedAt:
          DateTime.tryParse(json['updated_at'] as String? ?? '') ??
          DateTime.now(),
    );
  }
}

class AiRemoteMessage {
  const AiRemoteMessage({required this.role, required this.content});
  final String role;
  final String content;

  factory AiRemoteMessage.fromJson(Map<String, dynamic> json) {
    return AiRemoteMessage(
      role: json['role'] as String? ?? 'assistant',
      content: json['content'] as String? ?? '',
    );
  }
}

class AiChatApi {
  AiChatApi({FlutterSecureStorage? secureStorage, String? baseUrl})
    : _secureStorage = secureStorage ?? const FlutterSecureStorage(),
      _baseUrl = (baseUrl ?? _configuredBaseUrl).replaceAll(RegExp(r'/$'), '');

  static const _environmentBaseUrl = String.fromEnvironment('API_BASE_URL');
  static String get _configuredBaseUrl => _environmentBaseUrl.isNotEmpty
      ? _environmentBaseUrl
      : 'http://169.58.165.98:8000/api/v1';
  static const _tokenKey = 'visualyou_auth_token';

  final FlutterSecureStorage _secureStorage;
  final String _baseUrl;
  http.Client? _activeClient;

  void cancelActiveRequest() {
    _activeClient?.close();
    _activeClient = null;
  }

  void close() => cancelActiveRequest();

  Future<String> createConversation({required String title}) async {
    final normalizedTitle = title.trim();
    final decoded = await _request(
      'POST',
      '/ai/conversations/',
      body: {
        'title': normalizedTitle.length > 160
            ? normalizedTitle.substring(0, 160)
            : normalizedTitle,
      },
    );
    if (decoded is! Map<String, dynamic> || decoded['id'] is! String) {
      throw const AiApiException(
        'The server returned an invalid AI conversation.',
      );
    }
    return decoded['id'] as String;
  }

  Future<List<AiConversationSummary>> listConversations() async {
    final decoded = await _request('GET', '/ai/conversations/');
    final list = decoded is Map<String, dynamic> && decoded['results'] is List
        ? decoded['results'] as List
        : decoded;
    if (list is! List) {
      throw const AiApiException('The server returned invalid AI history.');
    }
    return [
      for (final item in list)
        if (item is Map<String, dynamic>) AiConversationSummary.fromJson(item),
    ];
  }

  Future<List<AiRemoteMessage>> loadMessages(String conversationId) async {
    final decoded = await _request(
      'GET',
      '/ai/conversations/$conversationId/messages/',
    );
    if (decoded is! List) {
      throw const AiApiException('The server returned invalid AI messages.');
    }
    return [
      for (final item in decoded)
        if (item is Map<String, dynamic>) AiRemoteMessage.fromJson(item),
    ];
  }

  Future<AiRemoteMessage> sendMessage({
    required String conversationId,
    required String content,
    Uint8List? imageBytes,
    String? imageMimeType,
  }) async {
    final decoded = await _request(
      'POST',
      '/ai/conversations/$conversationId/messages/',
      body: {
        'content': content,
        if (imageBytes != null) 'image_base64': base64Encode(imageBytes),
        if (imageBytes != null)
          'image_mime_type': imageMimeType ?? 'image/jpeg',
      },
      timeout: const Duration(seconds: 65),
    );
    if (decoded is! Map<String, dynamic> ||
        decoded['assistant_message'] is! Map<String, dynamic>) {
      throw const AiApiException('The server returned an invalid AI response.');
    }
    return AiRemoteMessage.fromJson(
      decoded['assistant_message'] as Map<String, dynamic>,
    );
  }

  Future<dynamic> _request(
    String method,
    String path, {
    Map<String, dynamic>? body,
    Duration timeout = const Duration(seconds: 20),
  }) async {
    String? token;
    try {
      token = await _secureStorage.read(key: _tokenKey);
    } catch (_) {
      throw const AiApiException('Sign in to use the AI coach.');
    }
    if (token == null || token.isEmpty) {
      throw const AiApiException('Sign in to use the AI coach.');
    }
    cancelActiveRequest();
    final client = http.Client();
    _activeClient = client;
    http.Response response;
    try {
      final uri = Uri.parse('$_baseUrl$path');
      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Token $token',
        if (body != null) 'Content-Type': 'application/json',
      };
      response =
          await (method == 'GET'
                  ? client.get(uri, headers: headers)
                  : client.post(uri, headers: headers, body: jsonEncode(body)))
              .timeout(timeout);
    } catch (_) {
      throw const AiApiException(
        'Could not connect to the AI coach. Check your connection and try again.',
      );
    } finally {
      if (identical(_activeClient, client)) _activeClient = null;
      client.close();
    }

    dynamic decoded;
    try {
      decoded = response.body.isEmpty ? null : jsonDecode(response.body);
    } catch (_) {
      decoded = null;
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final detail = decoded is Map<String, dynamic> ? decoded['detail'] : null;
      throw AiApiException(
        detail is String && detail.isNotEmpty
            ? detail
            : 'The AI coach could not complete that request.',
      );
    }
    return decoded;
  }
}
