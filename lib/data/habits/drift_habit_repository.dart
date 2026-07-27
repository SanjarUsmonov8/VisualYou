import 'dart:math' as math;

import 'package:drift/drift.dart';
import 'package:visualyou/data/habits/habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';

class DriftHabitRepository implements HabitRepository {
  DriftHabitRepository(this.database);

  final AppDatabase database;

  static const _habitSeeds = <String, _HabitSeed>{
    'Water': _HabitSeed('water', 'Drinking water', 'good'),
    'Drinking water': _HabitSeed('water', 'Drinking water', 'good'),
    'Healthy meal': _HabitSeed('healthy_eating', 'Eating healthy', 'good'),
    'Eating healthy': _HabitSeed('healthy_eating', 'Eating healthy', 'good'),
    'Arm workout': _HabitSeed('workout_arms', 'Arm', 'exercise'),
    'Arm': _HabitSeed('workout_arms', 'Arm', 'exercise'),
    'Shoulder / Back': _HabitSeed(
      'workout_shoulders_back',
      'Shoulder / Back',
      'exercise',
    ),
    'Chest': _HabitSeed('workout_chest', 'Chest', 'exercise'),
    'Abs workout': _HabitSeed('workout_abs', 'Abs', 'exercise'),
    'Abs': _HabitSeed('workout_abs', 'Abs', 'exercise'),
    'Legs': _HabitSeed('workout_legs', 'Legs', 'exercise'),
    'Smoke-free': _HabitSeed('smoke_free', 'Smoke-free', 'good'),
    'Smoking': _HabitSeed('smoking', 'Smoking', 'reduction'),
    'Vaping': _HabitSeed('vaping', 'Vaping', 'reduction'),
    'Alcohol': _HabitSeed('alcohol', 'Alcohol', 'reduction'),
    'Unhealthy eating': _HabitSeed(
      'unhealthy_eating',
      'Unhealthy eating',
      'reduction',
    ),
    'Adult videos': _HabitSeed('adult_videos', 'Adult videos', 'reduction'),
    'Masturbation': _HabitSeed('masturbation', 'Masturbation', 'reduction'),
  };

  @override
  Future<void> initialize() async {
    final now = DateTime.now();
    final uniqueSeeds = <String, _HabitSeed>{
      for (final seed in _habitSeeds.values) seed.id: seed,
    };
    await database.batch((batch) {
      for (final seed in uniqueSeeds.values) {
        batch.insert(
          database.habitDefinitions,
          HabitDefinitionsCompanion.insert(
            id: seed.id,
            nameKey: seed.nameKey,
            category: seed.category,
            createdAt: now,
            updatedAt: now,
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
    });
  }

  @override
  Future<PersistedBodyState> recordHabit(
    String actionKey, {
    DateTime? occurredAt,
  }) async {
    final now = occurredAt ?? DateTime.now();
    final day = DateTime(now.year, now.month, now.day);
    final seed = _resolveSeed(actionKey);

    await database.transaction(() async {
      await database
          .into(database.habitDefinitions)
          .insert(
            HabitDefinitionsCompanion.insert(
              id: seed.id,
              nameKey: seed.nameKey,
              category: seed.category,
              createdAt: now,
              updatedAt: now,
            ),
            mode: InsertMode.insertOrIgnore,
          );

      await database
          .into(database.habitLogEntries)
          .insert(
            HabitLogEntriesCompanion.insert(
              id: _newLocalId(seed.id, now),
              habitId: seed.id,
              loggedAt: now,
              localDay: day,
              createdAt: now,
              updatedAt: now,
            ),
          );

      await _applyBodyProgress(seed.id, now);
      await _updateGraphHistory(seed.id, day, now);
    });

    return loadBodyState();
  }

  @override
  Future<PersistedBodyState> loadBodyState() async {
    final rows = await database.select(database.bodyPartStates).get();
    return PersistedBodyState({
      for (final row in rows)
        row.partKey: PersistedBodyPart(
          level: row.level,
          colorValue: row.colorValue,
        ),
    });
  }

  @override
  Stream<List<DailyProgressPoint>> watchGraphHistory({
    String metricKey = 'total_actions',
    String? habitId,
  }) {
    final query = database.select(database.graphHistoryEntries)
      ..where((entry) {
        var predicate = entry.metricKey.equals(metricKey);
        if (habitId != null) {
          predicate = predicate & entry.habitId.equals(habitId);
        }
        return predicate & entry.deletedAt.isNull();
      })
      ..orderBy([(entry) => OrderingTerm.asc(entry.localDay)]);

    return query.watch().map(
      (rows) => [
        for (final row in rows)
          DailyProgressPoint(
            day: row.localDay,
            value: row.value,
            metricKey: row.metricKey,
            habitId: row.habitId,
          ),
      ],
    );
  }

  Future<void> _applyBodyProgress(String habitId, DateTime now) async {
    switch (habitId) {
      case 'alcohol':
        await _raiseBodyPart(BodyPartKey.brain, 0xFFE53935, now);
        await _raiseBodyPart(BodyPartKey.heart, 0xFFFFCA28, now);
        await _raiseBodyPart(BodyPartKey.liver, 0xFFE53935, now);
        return;
      case 'healthy_eating':
        await _raiseBodyPart(BodyPartKey.gut, 0xFF2979FF, now);
        await _raiseBodyPart(BodyPartKey.stomach, 0xFF2979FF, now);
        await _raiseBodyPart(BodyPartKey.liver, 0xFF43A047, now);
        return;
      case 'workout_arms':
        await _raiseMuscle(BodyPartKey.arms, now);
        return;
      case 'workout_shoulders_back':
        await _raiseMuscle(BodyPartKey.shouldersBack, now);
        return;
      case 'workout_chest':
        await _raiseMuscle(BodyPartKey.chest, now);
        return;
      case 'workout_abs':
        await _raiseMuscle(BodyPartKey.abs, now);
        return;
      case 'workout_legs':
        await _raiseMuscle(BodyPartKey.legs, now);
        return;
    }
  }

  Future<void> _raiseMuscle(String partKey, DateTime now) async {
    final existing = await _bodyPart(partKey);
    final nextLevel = math.min(5, (existing?.level ?? 0) + 1);
    await _upsertBodyPart(
      partKey: partKey,
      level: nextLevel,
      colorValue: _muscleColor(nextLevel),
      updatedAt: now,
    );
  }

  Future<void> _raiseBodyPart(
    String partKey,
    int colorValue,
    DateTime now,
  ) async {
    final existing = await _bodyPart(partKey);
    await _upsertBodyPart(
      partKey: partKey,
      level: math.min(5, (existing?.level ?? 0) + 1),
      colorValue: colorValue,
      updatedAt: now,
    );
  }

  Future<BodyPartState?> _bodyPart(String partKey) {
    return (database.select(
      database.bodyPartStates,
    )..where((part) => part.partKey.equals(partKey))).getSingleOrNull();
  }

  Future<void> _upsertBodyPart({
    required String partKey,
    required int level,
    required int colorValue,
    required DateTime updatedAt,
  }) {
    return database
        .into(database.bodyPartStates)
        .insertOnConflictUpdate(
          BodyPartStatesCompanion.insert(
            partKey: partKey,
            level: Value(level),
            colorValue: Value(colorValue),
            updatedAt: updatedAt,
          ),
        );
  }

  Future<void> _updateGraphHistory(
    String habitId,
    DateTime day,
    DateTime now,
  ) async {
    final habitCount = await _logCount(day: day, habitId: habitId);
    final totalCount = await _logCount(day: day);
    await _upsertGraphPoint(
      id: 'habit_count:$habitId:${_dayKey(day)}',
      metricKey: 'habit_count',
      habitId: habitId,
      day: day,
      value: habitCount.toDouble(),
      now: now,
    );
    await _upsertGraphPoint(
      id: 'total_actions:${_dayKey(day)}',
      metricKey: 'total_actions',
      day: day,
      value: totalCount.toDouble(),
      now: now,
    );
  }

  Future<int> _logCount({required DateTime day, String? habitId}) async {
    final query = database.select(database.habitLogEntries)
      ..where((entry) {
        var predicate = entry.localDay.equals(day) & entry.deletedAt.isNull();
        if (habitId != null) {
          predicate = predicate & entry.habitId.equals(habitId);
        }
        return predicate;
      });
    return (await query.get()).length;
  }

  Future<void> _upsertGraphPoint({
    required String id,
    required String metricKey,
    required DateTime day,
    required double value,
    required DateTime now,
    String? habitId,
  }) {
    return database
        .into(database.graphHistoryEntries)
        .insertOnConflictUpdate(
          GraphHistoryEntriesCompanion.insert(
            id: id,
            metricKey: metricKey,
            habitId: Value(habitId),
            localDay: day,
            value: value,
            recordedAt: now,
            updatedAt: now,
          ),
        );
  }

  static _HabitSeed _resolveSeed(String actionKey) {
    return _habitSeeds[actionKey] ??
        _HabitSeed(_slug(actionKey), actionKey, 'custom');
  }

  static String _slug(String value) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll(RegExp('[^a-z0-9]+'), '_')
        .replaceAll(RegExp('^_+|_+\$'), '');
  }

  static String _newLocalId(String habitId, DateTime time) {
    return '$habitId:${time.microsecondsSinceEpoch}';
  }

  static String _dayKey(DateTime day) {
    final month = day.month.toString().padLeft(2, '0');
    final date = day.day.toString().padLeft(2, '0');
    return '${day.year}-$month-$date';
  }

  static int _muscleColor(int level) {
    return switch (level) {
      1 => 0xFFE53935,
      2 => 0xFFFB8C00,
      3 => 0xFFFDD835,
      4 => 0xFF43A047,
      _ => 0xFF1E88E5,
    };
  }
}

class _HabitSeed {
  const _HabitSeed(this.id, this.nameKey, this.category);

  final String id;
  final String nameKey;
  final String category;
}
