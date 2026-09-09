import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/device_transfer/device_transfer_backup.dart';

void main() {
  test('a device transfer restores filled local records', () async {
    final source = AppDatabase(NativeDatabase.memory());
    final sourceHabits = DriftHabitRepository(source);
    await sourceHabits.initialize();
    await sourceHabits.recordHabit('water', didHabit: true);

    String? payload;
    final uploadClient = MockClient((request) async {
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      payload = body['payload'] as String;
      return http.Response(
        jsonEncode({
          'available': true,
          'expires_at': '2026-09-19T12:00:00Z',
          'source_device': 'old-phone',
        }),
        201,
        headers: {'content-type': 'application/json'},
      );
    });
    final uploader = DeviceTransferBackupController(
      database: source,
      client: uploadClient,
      baseUrl: 'https://example.test/api/v1',
      tokenLoader: () async => 'token',
      deviceIdLoader: () async => 'old-phone',
      onRestored: () async {},
    );
    await uploader.upload().timeout(
      const Duration(seconds: 5),
      onTimeout: () => throw StateError('upload timed out at ${uploader.stage}'),
    );
    expect(payload, isNotNull);
    uploader.dispose();
    await source.close();

    final destination = AppDatabase(NativeDatabase.memory());
    addTearDown(destination.close);
    final destinationHabits = DriftHabitRepository(destination);
    await destinationHabits.initialize();

    var restoredCallback = false;
    final downloadClient = MockClient((request) async {
      return http.Response(
        jsonEncode({
          'payload': payload,
          'schema_version': source.schemaVersion,
          'expires_at': '2026-09-19T12:00:00Z',
        }),
        200,
        headers: {'content-type': 'application/json'},
      );
    });
    final restorer = DeviceTransferBackupController(
      database: destination,
      client: downloadClient,
      baseUrl: 'https://example.test/api/v1',
      tokenLoader: () async => 'token',
      deviceIdLoader: () async => 'new-phone',
      onRestored: () async => restoredCallback = true,
    );
    addTearDown(restorer.dispose);
    await restorer.restore().timeout(
      const Duration(seconds: 5),
      onTimeout: () => throw StateError('restore timed out at ${restorer.stage}'),
    );

    final logs = await destination.customSelect(
      "SELECT habit_id, quantity FROM habit_log_entries WHERE habit_id = 'water'",
    ).get();
    expect(logs, hasLength(1));
    expect(logs.single.read<String>('habit_id'), 'water');
    expect(logs.single.read<int>('quantity'), 1);
    expect(restoredCallback, isTrue);
    expect(restorer.stage, DeviceTransferStage.restored);
  });
}
