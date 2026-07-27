import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/habits/habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';

void main() {
  test(
    'habit, body, progress, and graph data survive a database reopen',
    () async {
      final tempDirectory = await Directory.systemTemp.createTemp(
        'visualyou_offline_test_',
      );
      final databaseFile = File(
        '${tempDirectory.path}${Platform.pathSeparator}visualyou.sqlite',
      );

      AppDatabase? firstDatabase;
      AppDatabase? reopenedDatabase;
      addTearDown(() async {
        await firstDatabase?.close();
        await reopenedDatabase?.close();
        if (await tempDirectory.exists()) {
          await tempDirectory.delete(recursive: true);
        }
      });

      firstDatabase = AppDatabase(NativeDatabase(databaseFile));
      final firstRepository = DriftHabitRepository(firstDatabase);
      await firstRepository.initialize();

      await firstRepository.recordHabit(
        'Alcohol',
        occurredAt: DateTime(2026, 7, 27, 8),
      );
      await firstRepository.recordHabit(
        'Arm workout',
        occurredAt: DateTime(2026, 7, 27, 9),
      );
      await firstRepository.recordHabit(
        'Arm',
        occurredAt: DateTime(2026, 7, 27, 10),
      );
      await firstDatabase.close();
      firstDatabase = null;

      reopenedDatabase = AppDatabase(NativeDatabase(databaseFile));
      final reopenedRepository = DriftHabitRepository(reopenedDatabase);
      await reopenedRepository.initialize();
      final restoredBody = await reopenedRepository.loadBodyState();

      expect(restoredBody.parts[BodyPartKey.brain]?.colorValue, 0xFFE53935);
      expect(restoredBody.parts[BodyPartKey.heart]?.colorValue, 0xFFFFCA28);
      expect(restoredBody.parts[BodyPartKey.liver]?.colorValue, 0xFFE53935);
      expect(restoredBody.parts[BodyPartKey.arms]?.level, 2);
      expect(restoredBody.parts[BodyPartKey.arms]?.colorValue, 0xFFFB8C00);

      final logs = await reopenedDatabase
          .select(reopenedDatabase.habitLogEntries)
          .get();
      expect(logs.length, 3);

      final graph = await reopenedRepository.watchGraphHistory().first;
      expect(graph.length, 1);
      expect(graph.single.metricKey, 'total_actions');
      expect(graph.single.value, 3);
    },
  );
}
