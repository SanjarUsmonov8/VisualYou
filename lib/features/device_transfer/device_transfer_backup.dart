import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/auth/email_auth.dart';

enum DeviceTransferStage {
  idle,
  checking,
  exporting,
  uploading,
  ready,
  restoreAvailable,
  downloading,
  restoring,
  restored,
  error,
}

class DeviceTransferException implements Exception {
  const DeviceTransferException(this.message);
  final String message;

  @override
  String toString() => message;
}

class DeviceTransferBackupController extends ChangeNotifier {
  DeviceTransferBackupController({
    required AppDatabase database,
    required Future<void> Function() onRestored,
    http.Client? client,
    FlutterSecureStorage? secureStorage,
    String? baseUrl,
    Future<String?> Function()? tokenLoader,
    Future<String> Function()? deviceIdLoader,
  }) : _database = database,
       _onRestored = onRestored,
       _client = client ?? http.Client(),
       _secureStorage = secureStorage ?? const FlutterSecureStorage(),
       _tokenLoader = tokenLoader,
       _deviceIdLoader = deviceIdLoader,
       _baseUrl = (baseUrl ?? _configuredBaseUrl).replaceAll(RegExp(r'/$'), '');

  static const _environmentBaseUrl = String.fromEnvironment('API_BASE_URL');
  static String get _configuredBaseUrl => _environmentBaseUrl.isNotEmpty
      ? _environmentBaseUrl
      : 'http://169.58.165.98:8000/api/v1';

  static const _deviceIdKey = 'visualyou_device_transfer_id';

  final AppDatabase _database;
  final Future<void> Function() _onRestored;
  final http.Client _client;
  final FlutterSecureStorage _secureStorage;
  final String _baseUrl;
  final Future<String?> Function()? _tokenLoader;
  final Future<String> Function()? _deviceIdLoader;

  DeviceTransferStage stage = DeviceTransferStage.idle;
  double? progress;
  DateTime? expiresAt;
  String? errorMessage;
  String? _deviceId;

  bool get isBusy => switch (stage) {
    DeviceTransferStage.checking ||
    DeviceTransferStage.exporting ||
    DeviceTransferStage.uploading ||
    DeviceTransferStage.downloading ||
    DeviceTransferStage.restoring => true,
    _ => false,
  };

  Future<void> refreshAvailability() async {
    final token = await _token();
    if (token == null) {
      _setStage(DeviceTransferStage.idle);
      return;
    }
    _setStage(DeviceTransferStage.checking);
    try {
      final response = await _client
          .get(
            Uri.parse('$_baseUrl/device-transfer-backup/'),
            headers: {'Authorization': 'Token $token'},
          )
          .timeout(const Duration(seconds: 20));
      final data = _decodeResponse(response);
      if (data['available'] != true) {
        expiresAt = null;
        _setStage(DeviceTransferStage.idle);
        return;
      }
      expiresAt = DateTime.tryParse(data['expires_at']?.toString() ?? '');
      final currentDevice = await _loadDeviceId();
      _setStage(
        data['source_device'] == currentDevice
            ? DeviceTransferStage.ready
            : DeviceTransferStage.restoreAvailable,
      );
    } catch (error) {
      _fail(error);
    }
  }

  Future<void> upload() async {
    final token = await _token();
    if (token == null) {
      throw const DeviceTransferException('Sign in before creating a backup.');
    }
    try {
      progress = .05;
      _setStage(DeviceTransferStage.exporting);
      final snapshot = await _exportSnapshot();
      progress = .25;
      _setStage(DeviceTransferStage.uploading);
      final body = utf8.encode(
        jsonEncode({
          'payload': base64Encode(utf8.encode(snapshot)),
          'schema_version': _database.schemaVersion,
          'source_device': await _loadDeviceId(),
        }),
      );
      final request = http.Request(
        'PUT',
        Uri.parse('$_baseUrl/device-transfer-backup/'),
      )..headers.addAll({
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        });
      request.bodyBytes = body;
      progress = .45;
      notifyListeners();
      final streamed = await _client.send(request).timeout(
        const Duration(seconds: 60),
      );
      final response = await http.Response.fromStream(streamed);
      final data = _decodeResponse(response);
      expiresAt = DateTime.tryParse(data['expires_at']?.toString() ?? '');
      progress = 1;
      _setStage(DeviceTransferStage.ready);
    } catch (error) {
      _fail(error);
      rethrow;
    }
  }

  Future<void> restore() async {
    final token = await _token();
    if (token == null) {
      throw const DeviceTransferException('Sign in before restoring a backup.');
    }
    try {
      progress = .05;
      _setStage(DeviceTransferStage.downloading);
      final request = http.Request(
        'GET',
        Uri.parse('$_baseUrl/device-transfer-backup/download/'),
      )..headers['Authorization'] = 'Token $token';
      final streamed = await _client.send(request).timeout(
        const Duration(seconds: 60),
      );
      final total = streamed.contentLength ?? 0;
      final bytes = <int>[];
      await for (final chunk in streamed.stream) {
        bytes.addAll(chunk);
        if (total > 0) {
          progress = .05 + (.55 * bytes.length / total).clamp(0, 1);
          notifyListeners();
        }
      }
      final response = http.Response.bytes(
        bytes,
        streamed.statusCode,
        headers: streamed.headers,
      );
      final data = _decodeResponse(response);
      final encoded = data['payload'];
      if (encoded is! String) {
        throw const DeviceTransferException('The server returned an invalid backup.');
      }
      final snapshot = utf8.decode(base64Decode(encoded));
      progress = .65;
      _setStage(DeviceTransferStage.restoring);
      await _restoreSnapshot(snapshot);
      progress = 1;
      _setStage(DeviceTransferStage.restored);
      await _onRestored();
    } catch (error) {
      _fail(error);
      rethrow;
    }
  }

  Future<String?> _token() async {
    if (_tokenLoader != null) return _tokenLoader!();
    final api = EmailAuthApi(secureStorage: _secureStorage, baseUrl: _baseUrl);
    try {
      return await api.currentToken();
    } finally {
      api.close();
    }
  }

  Future<String> _loadDeviceId() async {
    if (_deviceIdLoader != null) return _deviceIdLoader!();
    if (_deviceId != null) return _deviceId!;
    final stored = await _secureStorage.read(key: _deviceIdKey);
    if (stored != null && stored.isNotEmpty) return _deviceId = stored;
    final random = Random.secure();
    final generated = List.generate(
      24,
      (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
    await _secureStorage.write(key: _deviceIdKey, value: generated);
    return _deviceId = generated;
  }

  Map<String, dynamic> _decodeResponse(http.Response response) {
    dynamic decoded;
    try {
      decoded = jsonDecode(response.body);
    } catch (_) {
      decoded = null;
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final detail = decoded is Map ? decoded['detail'] : null;
      throw DeviceTransferException(
        detail is String ? detail : 'Could not connect to the backup service.',
      );
    }
    if (decoded is! Map<String, dynamic>) {
      throw const DeviceTransferException('The server returned an invalid response.');
    }
    return decoded;
  }

  Future<String> _exportSnapshot() async {
    final tables = <String, dynamic>{};
    for (final table in _backupTables) {
      final rows = await _database.customSelect('SELECT * FROM $table').get();
      tables[table] = [for (final row in rows) row.data];
    }
    return jsonEncode({
      'format': 1,
      'schema_version': _database.schemaVersion,
      'created_at': DateTime.now().toUtc().toIso8601String(),
      'tables': tables,
    });
  }

  Future<void> _restoreSnapshot(String snapshot) async {
    final decoded = jsonDecode(snapshot);
    if (decoded is! Map<String, dynamic> || decoded['format'] != 1) {
      throw const DeviceTransferException('This backup format is not supported.');
    }
    final schemaVersion = decoded['schema_version'];
    if (schemaVersion is! int || schemaVersion > _database.schemaVersion) {
      throw const DeviceTransferException(
        'Update the app before restoring this newer backup.',
      );
    }
    final tableData = decoded['tables'];
    if (tableData is! Map<String, dynamic>) {
      throw const DeviceTransferException('This backup is incomplete.');
    }

    final knownColumns = <String, Set<String>>{};
    for (final table in _backupTables) {
      final info = await _database.customSelect('PRAGMA table_info($table)').get();
      knownColumns[table] = {
        for (final row in info) row.read<String>('name'),
      };
    }

    await _database.transaction(() async {
      await _database.customStatement('PRAGMA defer_foreign_keys = ON');
      for (final table in _backupTables.reversed) {
        await _database.customStatement('DELETE FROM $table');
      }
      for (final table in _backupTables) {
        final rows = tableData[table];
        if (rows == null) continue;
        if (rows is! List) {
          throw const DeviceTransferException('This backup contains invalid table data.');
        }
        for (final rawRow in rows) {
          if (rawRow is! Map) {
            throw const DeviceTransferException('This backup contains an invalid record.');
          }
          final row = <String, Object?>{};
          for (final entry in rawRow.entries) {
            final key = entry.key.toString();
            if (knownColumns[table]!.contains(key)) row[key] = entry.value;
          }
          if (row.isEmpty) continue;
          final columns = row.keys.toList();
          final placeholders = List.filled(columns.length, '?').join(', ');
          await _database.customStatement(
            'INSERT INTO $table (${columns.join(', ')}) VALUES ($placeholders)',
            [for (final column in columns) row[column]],
          );
        }
      }
    });
  }

  void _setStage(DeviceTransferStage value) {
    stage = value;
    if (value != DeviceTransferStage.error) errorMessage = null;
    notifyListeners();
  }

  void _fail(Object error) {
    errorMessage = error is DeviceTransferException
        ? error.message
        : 'The device-transfer backup could not be completed.';
    progress = null;
    stage = DeviceTransferStage.error;
    notifyListeners();
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }
}

class DeviceTransferScope extends InheritedNotifier<DeviceTransferBackupController> {
  const DeviceTransferScope({
    required DeviceTransferBackupController controller,
    required super.child,
    super.key,
  }) : super(notifier: controller);

  static DeviceTransferBackupController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<DeviceTransferScope>();
    assert(scope != null, 'No DeviceTransferScope found in context.');
    return scope!.notifier!;
  }
}

const _backupTables = <String>[
  'app_settings',
  'habit_definitions',
  'habit_log_entries',
  'body_part_states',
  'graph_history_entries',
  'custom_graph_rules',
  'special_habit_graphs',
  'named_custom_graphs',
  'named_custom_graph_rules',
  'reduction_plans',
  'growth_plans',
  'growth_plan_entries',
  'habit_streaks',
  'reward_states',
  'reward_events',
  'feature_unlocks',
  'custom_habit_organ_effects',
  'standard_habit_organ_effects',
  'numerical_habit_entries',
  'numerical_body_contributions',
  'numerical_habit_heatmaps',
];
