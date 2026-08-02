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
    'Consuming sugar': _HabitSeed(
      'consuming_sugar',
      'Consuming sugar',
      'reduction',
    ),
  };

  static const _defaultFavoriteIds = {
    'water',
    'healthy_eating',
    'workout_arms',
    'workout_abs',
    'alcohol',
  };

  static const _organKeys = {
    BodyPartKey.brain,
    BodyPartKey.lungs,
    BodyPartKey.heart,
    BodyPartKey.liver,
    BodyPartKey.stomach,
    BodyPartKey.kidneys,
    BodyPartKey.gut,
  };

  static const _organEffects = <String, Map<String, int>>{
    'smoking': {
      BodyPartKey.lungs: -3,
      BodyPartKey.heart: -2,
      BodyPartKey.brain: -1,
      BodyPartKey.liver: -1,
      BodyPartKey.stomach: -1,
      BodyPartKey.kidneys: -1,
      BodyPartKey.gut: -1,
    },
    'vaping': {
      BodyPartKey.lungs: -3,
      BodyPartKey.heart: -2,
      BodyPartKey.brain: -1,
      BodyPartKey.gut: -1,
      BodyPartKey.stomach: -1,
    },
    'alcohol': {
      BodyPartKey.liver: -3,
      BodyPartKey.brain: -2,
      BodyPartKey.heart: -2,
      BodyPartKey.stomach: -2,
      BodyPartKey.gut: -2,
      BodyPartKey.kidneys: -1,
    },
    'unhealthy_eating': {
      BodyPartKey.gut: -3,
      BodyPartKey.heart: -2,
      BodyPartKey.liver: -2,
      BodyPartKey.brain: -1,
      BodyPartKey.stomach: -1,
      BodyPartKey.kidneys: -1,
    },
    'consuming_sugar': {
      BodyPartKey.liver: -3,
      BodyPartKey.gut: -2,
      BodyPartKey.heart: -1,
      BodyPartKey.brain: -1,
      BodyPartKey.kidneys: -1,
      BodyPartKey.stomach: -1,
    },
    'adult_videos': {BodyPartKey.brain: -3},
    'masturbation': {BodyPartKey.brain: -3},
    'water': {
      BodyPartKey.kidneys: 3,
      BodyPartKey.gut: 2,
      BodyPartKey.brain: 2,
      BodyPartKey.heart: 2,
      BodyPartKey.stomach: 1,
      BodyPartKey.liver: 1,
      BodyPartKey.lungs: 1,
    },
    'healthy_eating': {
      BodyPartKey.gut: 3,
      BodyPartKey.brain: 2,
      BodyPartKey.heart: 2,
      BodyPartKey.liver: 2,
      BodyPartKey.stomach: 2,
      BodyPartKey.kidneys: 2,
      BodyPartKey.lungs: 1,
    },
  };

  static const _notDoneOrganEffects = <String, Map<String, int>>{
    'smoking': {
      BodyPartKey.lungs: 3,
      BodyPartKey.heart: 2,
      BodyPartKey.brain: 1,
      BodyPartKey.liver: 1,
      BodyPartKey.stomach: 1,
      BodyPartKey.kidneys: 1,
      BodyPartKey.gut: 1,
    },
    'vaping': {
      BodyPartKey.lungs: 3,
      BodyPartKey.heart: 2,
      BodyPartKey.brain: 1,
      BodyPartKey.gut: 1,
      BodyPartKey.stomach: 1,
    },
    'alcohol': {
      BodyPartKey.liver: 3,
      BodyPartKey.brain: 2,
      BodyPartKey.stomach: 2,
      BodyPartKey.gut: 2,
      BodyPartKey.heart: 2,
      BodyPartKey.kidneys: 1,
    },
    'unhealthy_eating': {
      BodyPartKey.gut: 3,
      BodyPartKey.heart: 2,
      BodyPartKey.liver: 2,
      BodyPartKey.brain: 1,
      BodyPartKey.stomach: 1,
      BodyPartKey.kidneys: 1,
    },
    'consuming_sugar': {
      BodyPartKey.liver: 3,
      BodyPartKey.gut: 2,
      BodyPartKey.brain: 2,
      BodyPartKey.heart: 1,
      BodyPartKey.kidneys: 1,
      BodyPartKey.stomach: 1,
    },
    'adult_videos': {BodyPartKey.brain: 3},
    'masturbation': {BodyPartKey.brain: 3},
    'water': {
      BodyPartKey.kidneys: -3,
      BodyPartKey.gut: -2,
      BodyPartKey.brain: -2,
      BodyPartKey.heart: -2,
      BodyPartKey.stomach: -1,
      BodyPartKey.liver: -1,
      BodyPartKey.lungs: -1,
    },
    'healthy_eating': {
      BodyPartKey.gut: -3,
      BodyPartKey.brain: -2,
      BodyPartKey.heart: -2,
      BodyPartKey.liver: -2,
      BodyPartKey.stomach: -2,
      BodyPartKey.kidneys: -2,
      BodyPartKey.lungs: -1,
    },
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
            isFavorite: Value(_defaultFavoriteIds.contains(seed.id)),
            createdAt: now,
            updatedAt: now,
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
      for (final partKey in _organKeys) {
        batch.insert(
          database.bodyPartStates,
          BodyPartStatesCompanion.insert(
            partKey: partKey,
            level: const Value(3),
            colorValue: const Value(null),
            updatedAt: now,
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
    });
    await (database.update(
      database.habitDefinitions,
    )..where((habit) => habit.id.equals('smoke_free'))).write(
      HabitDefinitionsCompanion(
        isActive: const Value(false),
        isFavorite: const Value(false),
        updatedAt: Value(now),
        syncStatus: const Value('pending'),
      ),
    );
  }

  @override
  Stream<List<HabitPreference>> watchHabitPreferences() {
    final query = database.select(database.habitDefinitions)
      ..where((habit) => habit.deletedAt.isNull())
      ..orderBy([
        (habit) => OrderingTerm.asc(habit.category),
        (habit) => OrderingTerm.asc(habit.nameKey),
      ]);
    return query.watch().map(
      (rows) => [
        for (final row in rows)
          HabitPreference(
            id: row.id,
            nameKey: row.nameKey,
            category: row.category,
            isActive: row.isActive,
            isFavorite: row.isFavorite,
          ),
      ],
    );
  }

  @override
  Future<void> setHabitActive(String habitId, bool isActive) async {
    final now = DateTime.now();
    await (database.update(
      database.habitDefinitions,
    )..where((habit) => habit.id.equals(habitId))).write(
      HabitDefinitionsCompanion(
        isActive: Value(isActive),
        isFavorite: isActive ? const Value.absent() : const Value(false),
        updatedAt: Value(now),
        syncStatus: const Value('pending'),
      ),
    );
  }

  @override
  Future<void> setHabitFavorite(String habitId, bool isFavorite) async {
    final now = DateTime.now();
    await (database.update(database.habitDefinitions)..where(
          (habit) => habit.id.equals(habitId) & habit.isActive.equals(true),
        ))
        .write(
          HabitDefinitionsCompanion(
            isFavorite: Value(isFavorite),
            updatedAt: Value(now),
            syncStatus: const Value('pending'),
          ),
        );
  }

  @override
  Future<PersistedBodyState> recordHabit(
    String actionKey, {
    DateTime? occurredAt,
    bool didHabit = true,
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
              quantity: Value(didHabit ? 1 : 0),
              createdAt: now,
              updatedAt: now,
            ),
          );

      if (didHabit) {
        await _applyBodyProgress(seed.id, now);
      } else {
        await _applyNotDoneProgress(seed.id, now);
      }
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
    final organEffects = _organEffects[habitId];
    if (organEffects != null) {
      for (final effect in organEffects.entries) {
        await _changeOrganScore(effect.key, effect.value, now);
      }
      return;
    }
    switch (habitId) {
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

  Future<void> _applyNotDoneProgress(String habitId, DateTime now) async {
    final organEffects = _notDoneOrganEffects[habitId];
    if (organEffects != null) {
      for (final effect in organEffects.entries) {
        await _changeOrganScore(effect.key, effect.value, now);
      }
      return;
    }
    switch (habitId) {
      case 'workout_arms':
        await _lowerMuscle(BodyPartKey.arms, now);
      case 'workout_shoulders_back':
        await _lowerMuscle(BodyPartKey.shouldersBack, now);
      case 'workout_chest':
        await _lowerMuscle(BodyPartKey.chest, now);
      case 'workout_abs':
        await _lowerMuscle(BodyPartKey.abs, now);
      case 'workout_legs':
        await _lowerMuscle(BodyPartKey.legs, now);
    }
  }

  Future<void> _changeOrganScore(
    String partKey,
    int points,
    DateTime now,
  ) async {
    final existing = await _bodyPart(partKey);
    final nextLevel = ((existing?.level ?? 3) + points).clamp(1, 5);
    await _upsertBodyPart(
      partKey: partKey,
      level: nextLevel,
      colorValue: _organColor(nextLevel),
      updatedAt: now,
    );
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

  Future<void> _lowerMuscle(String partKey, DateTime now) async {
    final existing = await _bodyPart(partKey);
    final nextLevel = math.max(1, (existing?.level ?? 1) - 1);
    await _upsertBodyPart(
      partKey: partKey,
      level: nextLevel,
      colorValue: _muscleColor(nextLevel),
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
    return (await query.get()).fold<int>(
      0,
      (total, entry) => total + entry.quantity,
    );
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

  static int _organColor(int level) {
    return switch (level) {
      <= 1 => 0xFFE53935,
      2 => 0xFFFB8C00,
      3 => 0xFFFFCA28,
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
