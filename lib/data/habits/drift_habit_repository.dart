import 'dart:math' as math;

import 'package:drift/drift.dart';
import 'package:visualyou/data/habits/habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/numerical_habits/numerical_habit_config.dart';

class DriftHabitRepository implements HabitRepository {
  DriftHabitRepository(this.database);

  final AppDatabase database;

  static const _habitSeeds = <String, _HabitSeed>{
    'Water': _HabitSeed('water', 'Drinking water', 'good'),
    'Drinking water': _HabitSeed('water', 'Drinking water', 'good'),
    'Healthy meal': _HabitSeed('healthy_eating', 'Eating healthy', 'good'),
    'Eating healthy': _HabitSeed('healthy_eating', 'Eating healthy', 'good'),
    'Studying': _HabitSeed('studying', 'Studying', 'good'),
    'Brushing teeth': _HabitSeed('brushing_teeth', 'Brushing teeth', 'good'),
    'Skin care': _HabitSeed('skin_care', 'Skin care', 'good'),
    'Good sleep': _HabitSeed('good_sleep', 'Good sleep', 'good'),
    'Meditation': _HabitSeed('meditation', 'Meditation', 'good'),
    'Reading': _HabitSeed('reading', 'Reading', 'good'),
    'Consistent routine': _HabitSeed(
      'consistent_routine',
      'Consistent routine',
      'good',
    ),
    'Practising gratitude': _HabitSeed(
      'practising_gratitude',
      'Practising gratitude',
      'good',
    ),
    'Productive work': _HabitSeed('productive_work', 'Productive work', 'good'),
    'Arm workout': _HabitSeed('workout_arms', 'Arm', 'exercise'),
    'Arm': _HabitSeed('workout_arms', 'Arm', 'exercise'),
    'Shoulder workout': _HabitSeed(
      'workout_shoulders',
      'Shoulder workout',
      'exercise',
    ),
    'Back workout': _HabitSeed('workout_back', 'Back workout', 'exercise'),
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
    'Excessive screen time': _HabitSeed(
      'excessive_screen_time',
      'Excessive screen time',
      'reduction',
    ),
    'Excessive caffeine': _HabitSeed(
      'excessive_caffeine',
      'Excessive caffeine',
      'reduction',
    ),
    'Social media overuse': _HabitSeed(
      'social_media_overuse',
      'Social media overuse',
      'reduction',
    ),
    'Nail biting': _HabitSeed('nail_biting', 'Nail biting', 'reduction'),
    'Gaming overuse': _HabitSeed(
      'gaming_overuse',
      'Gaming overuse',
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

  // New catalog habits should not suddenly appear in an existing user's
  // active list after an app update. They remain available from habit editing
  // and can still be selected during onboarding.
  static const _initiallyInactiveHabitIds = {
    'brushing_teeth',
    'skin_care',
    'good_sleep',
    'meditation',
    'reading',
    'consistent_routine',
    'practising_gratitude',
    'productive_work',
    'excessive_screen_time',
    'excessive_caffeine',
    'social_media_overuse',
    'nail_biting',
    'gaming_overuse',
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
  static const _customEffectValues = [-1.5, -1.0, -.5, 0.0, .5, 1.0, 1.5];

  static const _muscleKeys = {
    BodyPartKey.arms,
    BodyPartKey.shoulders,
    BodyPartKey.back,
    BodyPartKey.chest,
    BodyPartKey.abs,
    BodyPartKey.legs,
  };

  static const _exerciseMuscleParts = <String, String>{
    'workout_arms': BodyPartKey.arms,
    'workout_shoulders': BodyPartKey.shoulders,
    'workout_back': BodyPartKey.back,
    'workout_chest': BodyPartKey.chest,
    'workout_abs': BodyPartKey.abs,
    'workout_legs': BodyPartKey.legs,
  };

  static const _organEffects = <String, Map<String, double>>{
    'smoking': {
      BodyPartKey.lungs: -1.5,
      BodyPartKey.heart: -1,
      BodyPartKey.brain: -.5,
      BodyPartKey.liver: -.5,
      BodyPartKey.stomach: -.5,
      BodyPartKey.kidneys: -.5,
      BodyPartKey.gut: -.5,
    },
    'vaping': {
      BodyPartKey.lungs: -1.5,
      BodyPartKey.heart: -1,
      BodyPartKey.brain: -.5,
      BodyPartKey.gut: -.5,
      BodyPartKey.stomach: -.5,
    },
    'alcohol': {
      BodyPartKey.liver: -1.5,
      BodyPartKey.brain: -1,
      BodyPartKey.heart: -1,
      BodyPartKey.stomach: -1,
      BodyPartKey.gut: -1,
      BodyPartKey.kidneys: -.5,
    },
    'unhealthy_eating': {
      BodyPartKey.gut: -1.5,
      BodyPartKey.heart: -1,
      BodyPartKey.liver: -1,
      BodyPartKey.brain: -.5,
      BodyPartKey.stomach: -.5,
      BodyPartKey.kidneys: -.5,
    },
    'consuming_sugar': {
      BodyPartKey.liver: -1.5,
      BodyPartKey.gut: -1,
      BodyPartKey.heart: -.5,
      BodyPartKey.brain: -.5,
      BodyPartKey.kidneys: -.5,
      BodyPartKey.stomach: -.5,
    },
    'adult_videos': {BodyPartKey.brain: -1.5},
    'masturbation': {BodyPartKey.brain: -1.5},
    'water': {
      BodyPartKey.kidneys: 1.5,
      BodyPartKey.gut: 1,
      BodyPartKey.brain: 1,
      BodyPartKey.heart: 1,
      BodyPartKey.stomach: .5,
      BodyPartKey.liver: .5,
      BodyPartKey.lungs: .5,
    },
    'healthy_eating': {
      BodyPartKey.gut: 1.5,
      BodyPartKey.brain: .5,
      BodyPartKey.heart: 1,
      BodyPartKey.liver: 1,
      BodyPartKey.stomach: 1,
      BodyPartKey.kidneys: 1,
      BodyPartKey.lungs: .5,
    },
    'studying': {BodyPartKey.brain: 1},
    'brushing_teeth': {BodyPartKey.brain: .25},
    'skin_care': {BodyPartKey.brain: .5},
    'good_sleep': {BodyPartKey.brain: 1},
    'meditation': {BodyPartKey.brain: 1},
    'reading': {BodyPartKey.brain: 1},
    'consistent_routine': {BodyPartKey.brain: 1},
    'practising_gratitude': {BodyPartKey.brain: 1},
    'productive_work': {BodyPartKey.brain: .5},
    'excessive_screen_time': {BodyPartKey.brain: -1.5},
    'excessive_caffeine': {
      BodyPartKey.brain: -.5,
      BodyPartKey.heart: -1,
      BodyPartKey.stomach: -.5,
      BodyPartKey.kidneys: -.25,
      BodyPartKey.gut: -.5,
    },
    'social_media_overuse': {BodyPartKey.brain: -1},
    'nail_biting': {BodyPartKey.brain: -.25},
    'gaming_overuse': {BodyPartKey.brain: -1.5},
  };

  static const _notDoneOrganEffects = <String, Map<String, double>>{
    'smoking': {
      BodyPartKey.lungs: 1,
      BodyPartKey.heart: .5,
      BodyPartKey.brain: .25,
      BodyPartKey.liver: .25,
      BodyPartKey.stomach: .25,
      BodyPartKey.kidneys: .25,
      BodyPartKey.gut: .25,
    },
    'vaping': {
      BodyPartKey.lungs: 1,
      BodyPartKey.heart: .5,
      BodyPartKey.brain: .25,
      BodyPartKey.gut: .25,
      BodyPartKey.stomach: .25,
    },
    'alcohol': {
      BodyPartKey.liver: 1,
      BodyPartKey.brain: .5,
      BodyPartKey.stomach: .5,
      BodyPartKey.gut: .5,
      BodyPartKey.heart: .5,
      BodyPartKey.kidneys: .25,
    },
    'unhealthy_eating': {
      BodyPartKey.gut: 1,
      BodyPartKey.heart: .5,
      BodyPartKey.liver: .5,
      BodyPartKey.brain: .25,
      BodyPartKey.stomach: .25,
      BodyPartKey.kidneys: .25,
    },
    'consuming_sugar': {
      BodyPartKey.liver: 1,
      BodyPartKey.gut: .5,
      BodyPartKey.brain: .5,
      BodyPartKey.heart: .25,
      BodyPartKey.kidneys: .25,
      BodyPartKey.stomach: .25,
    },
    'adult_videos': {BodyPartKey.brain: 1},
    'masturbation': {BodyPartKey.brain: 1},
    'water': {
      BodyPartKey.kidneys: -1.5,
      BodyPartKey.gut: -1,
      BodyPartKey.brain: -1,
      BodyPartKey.heart: -1,
      BodyPartKey.stomach: -.5,
      BodyPartKey.liver: -.5,
      BodyPartKey.lungs: -.5,
    },
    'healthy_eating': {
      BodyPartKey.gut: -1.25,
      BodyPartKey.brain: -.25,
      BodyPartKey.heart: -.75,
      BodyPartKey.liver: -.75,
      BodyPartKey.stomach: -.75,
      BodyPartKey.kidneys: -.75,
      BodyPartKey.lungs: -.5,
    },
    'studying': {BodyPartKey.brain: -.5},
    'brushing_teeth': {BodyPartKey.brain: -.25},
    'skin_care': {BodyPartKey.brain: -.25},
    'good_sleep': {BodyPartKey.brain: -1},
    'meditation': {BodyPartKey.brain: -.5},
    'consistent_routine': {BodyPartKey.brain: -1},
    'excessive_screen_time': {BodyPartKey.brain: 1},
    'excessive_caffeine': {
      BodyPartKey.brain: .5,
      BodyPartKey.heart: .5,
      BodyPartKey.stomach: .25,
      BodyPartKey.kidneys: .25,
      BodyPartKey.gut: .25,
    },
    'social_media_overuse': {BodyPartKey.brain: 1},
    'nail_biting': {BodyPartKey.brain: .25},
    'gaming_overuse': {BodyPartKey.brain: 1},
  };

  static const _overnightRecovery = <String, double>{
    BodyPartKey.brain: .5,
    BodyPartKey.heart: .5,
    BodyPartKey.lungs: .25,
    BodyPartKey.liver: .5,
    BodyPartKey.kidneys: .5,
    BodyPartKey.gut: .5,
    BodyPartKey.stomach: .25,
  };

  @override
  Future<void> initialize() async {
    final now = DateTime.now();
    final existingHabits = await database
        .select(database.habitDefinitions)
        .get();
    final existingHabitIds = {for (final habit in existingHabits) habit.id};
    final legacyShoulderBack = existingHabits
        .where((habit) => habit.id == 'workout_shoulders_back')
        .firstOrNull;
    final legacyMuscle =
        await (database.select(database.bodyPartStates)
              ..where((part) => part.partKey.equals(BodyPartKey.shouldersBack)))
            .getSingleOrNull();
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
            isActive: Value(!_initiallyInactiveHabitIds.contains(seed.id)),
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
            score: const Value(3.0),
            colorValue: const Value(null),
            updatedAt: now,
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
      for (final partKey in const [BodyPartKey.shoulders, BodyPartKey.back]) {
        batch.insert(
          database.bodyPartStates,
          BodyPartStatesCompanion.insert(
            partKey: partKey,
            level: Value(legacyMuscle?.level ?? 0),
            score: Value(legacyMuscle?.score ?? 0),
            colorValue: Value(legacyMuscle?.colorValue),
            updatedAt: now,
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
    });
    if (legacyShoulderBack != null) {
      if (!existingHabitIds.contains('workout_shoulders')) {
        await (database.update(
          database.habitDefinitions,
        )..where((habit) => habit.id.equals('workout_shoulders'))).write(
          HabitDefinitionsCompanion(
            isActive: Value(legacyShoulderBack.isActive),
            isFavorite: Value(legacyShoulderBack.isFavorite),
            numericalTrackingEnabled: Value(
              legacyShoulderBack.numericalTrackingEnabled,
            ),
            numericalTarget: Value(legacyShoulderBack.numericalTarget),
            updatedAt: Value(now),
          ),
        );
      }
      if (!existingHabitIds.contains('workout_back')) {
        await (database.update(
          database.habitDefinitions,
        )..where((habit) => habit.id.equals('workout_back'))).write(
          HabitDefinitionsCompanion(
            isActive: Value(legacyShoulderBack.isActive),
            numericalTrackingEnabled: Value(
              legacyShoulderBack.numericalTrackingEnabled,
            ),
            numericalTarget: Value(legacyShoulderBack.numericalTarget),
            updatedAt: Value(now),
          ),
        );
      }
      await (database.update(
        database.habitDefinitions,
      )..where((habit) => habit.id.equals('workout_shoulders_back'))).write(
        HabitDefinitionsCompanion(
          isActive: const Value(false),
          isFavorite: const Value(false),
          numericalTrackingEnabled: const Value(false),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
    }
    await _applyOvernightRecovery(now);
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
  Future<bool> isOnboardingComplete() async {
    final setting = await (database.select(
      database.appSettings,
    )..where((row) => row.key.equals('onboarding_complete'))).getSingleOrNull();
    return setting?.value == 'true';
  }

  @override
  Future<void> completeOnboarding() {
    final now = DateTime.now();
    return database
        .into(database.appSettings)
        .insertOnConflictUpdate(
          AppSettingsCompanion.insert(
            key: 'onboarding_complete',
            value: 'true',
            updatedAt: now,
          ),
        );
  }

  @override
  Future<PersistedAppPreferences> loadAppPreferences() async {
    final rows = await database.select(database.appSettings).get();
    final values = {for (final row in rows) row.key: row.value};
    final rawBirthDate = values['profile_birth_date'];
    return PersistedAppPreferences(
      themeMode: values['theme_mode'] ?? 'system',
      accent: values['accent'] ?? 'blue',
      gender: values['gender'] ?? 'male',
      language: values['language'] ?? 'english',
      profileName: values['profile_name'] ?? '',
      birthDate: rawBirthDate == null ? null : DateTime.tryParse(rawBirthDate),
      profileImageBase64: values['profile_image_base64'] ?? '',
      profileImageAlignmentX:
          double.tryParse(values['profile_image_alignment_x'] ?? '') ?? 0,
      profileImageAlignmentY:
          double.tryParse(values['profile_image_alignment_y'] ?? '') ?? 0,
      profileImageScale:
          double.tryParse(values['profile_image_scale'] ?? '') ?? 1,
      termsAccepted: values['terms_accepted'] == 'true',
    );
  }

  @override
  Future<void> saveAppPreferences(PersistedAppPreferences preferences) async {
    final now = DateTime.now();
    final values = <String, String>{
      'theme_mode': preferences.themeMode,
      'accent': preferences.accent,
      'gender': preferences.gender,
      'language': preferences.language,
      'profile_name': preferences.profileName,
      'profile_birth_date': preferences.birthDate?.toIso8601String() ?? '',
      'profile_image_base64': preferences.profileImageBase64,
      'profile_image_alignment_x': '${preferences.profileImageAlignmentX}',
      'profile_image_alignment_y': '${preferences.profileImageAlignmentY}',
      'profile_image_scale': '${preferences.profileImageScale}',
      'terms_accepted': '${preferences.termsAccepted}',
    };
    await database.transaction(() async {
      for (final entry in values.entries) {
        await database
            .into(database.appSettings)
            .insertOnConflictUpdate(
              AppSettingsCompanion.insert(
                key: entry.key,
                value: entry.value,
                updatedAt: now,
              ),
            );
      }
    });
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
            numericalTrackingEnabled: row.numericalTrackingEnabled,
            numericalTarget: row.numericalTarget,
            numericalUnit: row.numericalUnit,
            updatedAt: row.updatedAt,
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
  Future<void> setHabitNumericalTracking(
    String habitId, {
    required bool enabled,
    required int target,
    String? unitKey,
  }) async {
    final now = DateTime.now();
    final existing =
        await (database.select(database.habitDefinitions)..where(
              (habit) => habit.id.equals(habitId) & habit.deletedAt.isNull(),
            ))
            .getSingleOrNull();
    if (existing == null) throw StateError('Habit not found.');
    final selectedUnit =
        unitKey ??
        existing.numericalUnit ??
        defaultNumericalUnitForHabit(habitId);
    final config = numericalConfigForHabit(
      habitId: habitId,
      category: existing.category,
      unitKey: selectedUnit,
    );
    if (target < 1 || target > config.maximum) {
      throw ArgumentError.value(target, 'target');
    }
    if (enabled && !existing.numericalTrackingEnabled) {
      final limit = await _loadNumericalHabitLimit(now);
      if (limit == 0) {
        throw StateError('Numerical tracking requires a paid plan.');
      }
      if (limit != null) {
        final enabledHabits =
            await (database.select(database.habitDefinitions)..where(
                  (habit) =>
                      habit.numericalTrackingEnabled.equals(true) &
                      habit.deletedAt.isNull(),
                ))
                .get();
        final enabledCount = enabledHabits.length;
        if (enabledCount >= limit) {
          throw StateError(
            'This plan allows numerical tracking for $limit habits.',
          );
        }
      }
    }
    await (database.update(database.habitDefinitions)..where(
          (habit) => habit.id.equals(habitId) & habit.deletedAt.isNull(),
        ))
        .write(
          HabitDefinitionsCompanion(
            numericalTrackingEnabled: Value(enabled),
            numericalTarget: Value(target),
            numericalUnit: Value(selectedUnit),
            updatedAt: Value(now),
            syncStatus: const Value('pending'),
          ),
        );
  }

  @override
  Stream<List<DailyNumericalHabitValue>> watchNumericalHabitValues(
    DateTime day,
  ) {
    final localDay = DateTime(day.year, day.month, day.day);
    final query = database.select(database.numericalHabitEntries)
      ..where((entry) => entry.localDay.equals(localDay));
    return query.watch().map(
      (rows) => [
        for (final row in rows)
          DailyNumericalHabitValue(
            habitId: row.habitId,
            value: row.value,
            outcomeFactor: row.outcomeFactor,
          ),
      ],
    );
  }

  @override
  Future<PersistedBodyState> recordNumericalHabit(
    String habitId,
    int value, {
    DateTime? occurredAt,
  }) async {
    final now = occurredAt ?? DateTime.now();
    await applyDailyRecovery(now: now);
    final habit =
        await (database.select(database.habitDefinitions)
              ..where((row) => row.id.equals(habitId) & row.deletedAt.isNull()))
            .getSingleOrNull();
    if (habit == null || !await _canUseNumericalTracking(habit, now)) {
      throw StateError('Numerical tracking is not enabled for this habit.');
    }
    final config = numericalConfigForHabit(
      habitId: habit.id,
      category: habit.category,
      unitKey: habit.numericalUnit,
    );
    if (value < 0 || value > config.maximum) {
      throw ArgumentError.value(value, 'value');
    }
    final target = habit.numericalTarget ?? config.defaultTarget;
    final factor = config.outcomeFactor(value, target);
    final actualDidHabit = switch (config.kind) {
      NumericalHabitKind.occurrences => value > 0,
      NumericalHabitKind.limitedDuration => value > target,
      _ => factor > 0,
    };
    return _recordNumericalOutcome(
      habit: habit,
      value: value,
      factor: factor,
      actualDidHabit: actualDidHabit,
      now: now,
    );
  }

  @override
  Future<String> createCustomHabit({
    required String name,
    required bool isUnwanted,
    List<CustomHabitOrganEffect> organEffects = const [],
  }) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) throw ArgumentError.value(name, 'name');
    final customHabits =
        await (database.select(database.habitDefinitions)..where(
              (habit) =>
                  habit.category.isIn(const ['custom_good', 'custom_bad']) &
                  habit.deletedAt.isNull(),
            ))
            .get();
    final customHabitLimit = await _loadCustomHabitLimit();
    if (customHabits.length >= customHabitLimit) {
      throw StateError(
        'Only $customHabitLimit custom habits are allowed for this plan.',
      );
    }
    final now = DateTime.now();
    final id = 'custom_${_slug(trimmed)}_${now.microsecondsSinceEpoch}';
    await _validateCustomOrganEffects(organEffects);
    await database.transaction(() async {
      await database
          .into(database.habitDefinitions)
          .insert(
            HabitDefinitionsCompanion.insert(
              id: id,
              nameKey: trimmed,
              category: isUnwanted ? 'custom_bad' : 'custom_good',
              createdAt: now,
              updatedAt: now,
            ),
          );
      await _replaceCustomOrganEffects(id, organEffects, now);
    });
    return id;
  }

  Future<int> _loadCustomHabitLimit() async {
    final rewardState = await (database.select(
      database.rewardStates,
    )..where((row) => row.id.equals(1))).getSingleOrNull();
    return switch (rewardState?.plan) {
      'free' => 0,
      'plus' => 2,
      'pro' => 5,
      'ultra' => 10,
      // A missing rewards row is used by isolated repository tests and older
      // local databases. Plus and that legacy state retain the original cap.
      null => 2,
      _ => 0,
    };
  }

  @override
  Future<void> updateCustomHabit({
    required String habitId,
    required String name,
    required bool isUnwanted,
    List<CustomHabitOrganEffect> organEffects = const [],
  }) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) throw ArgumentError.value(name, 'name');
    final existing =
        await (database.select(database.habitDefinitions)..where(
              (habit) => habit.id.equals(habitId) & habit.deletedAt.isNull(),
            ))
            .getSingleOrNull();
    if (existing == null ||
        !const ['custom_good', 'custom_bad'].contains(existing.category)) {
      throw StateError('Custom habit not found.');
    }
    final now = DateTime.now();
    await _validateCustomOrganEffects(organEffects, excludingHabitId: habitId);
    await database.transaction(() async {
      await (database.update(
        database.habitDefinitions,
      )..where((habit) => habit.id.equals(habitId))).write(
        HabitDefinitionsCompanion(
          nameKey: Value(trimmed),
          category: Value(isUnwanted ? 'custom_bad' : 'custom_good'),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
      await _replaceCustomOrganEffects(habitId, organEffects, now);
    });
  }

  @override
  Future<List<CustomHabitOrganEffect>> loadCustomHabitOrganEffects(
    String habitId,
  ) async {
    final rows = await (database.select(
      database.customHabitOrganEffects,
    )..where((row) => row.habitId.equals(habitId))).get();
    return [
      for (final row in rows)
        CustomHabitOrganEffect(
          partKey: row.partKey,
          thumbUpPoints: row.thumbUpPoints,
          thumbDownPoints: row.thumbDownPoints,
        ),
    ];
  }

  @override
  Future<int> countCustomHabitsWithOrganEffects() async {
    final rows = await database.select(database.customHabitOrganEffects).get();
    return rows
        .where((row) => row.thumbUpPoints != 0 || row.thumbDownPoints != 0)
        .map((row) => row.habitId)
        .toSet()
        .length;
  }

  @override
  Future<StandardHabitOrganEffectSettings> loadStandardHabitOrganEffects(
    String habitId,
  ) async {
    final habit =
        await (database.select(database.habitDefinitions)
              ..where((row) => row.id.equals(habitId) & row.deletedAt.isNull()))
            .getSingleOrNull();
    if (habit == null || habit.id.startsWith('custom_')) {
      throw StateError('Standard habit not found.');
    }
    final rows = await (database.select(
      database.standardHabitOrganEffects,
    )..where((row) => row.habitId.equals(habitId))).get();
    if (rows.isEmpty) {
      return StandardHabitOrganEffectSettings(
        effects: _defaultThumbEffects(habit.id, habit.category),
        isCustomized: false,
      );
    }
    return StandardHabitOrganEffectSettings(
      effects: [
        for (final row in rows)
          CustomHabitOrganEffect(
            partKey: row.partKey,
            thumbUpPoints: row.thumbUpPoints,
            thumbDownPoints: row.thumbDownPoints,
          ),
      ],
      isCustomized: true,
    );
  }

  @override
  Future<int> countStandardHabitsWithOrganEffects() async {
    final rows = await database
        .select(database.standardHabitOrganEffects)
        .get();
    return rows.map((row) => row.habitId).toSet().length;
  }

  @override
  Future<void> saveStandardHabitOrganEffects(
    String habitId,
    List<CustomHabitOrganEffect> organEffects,
  ) async {
    final habit =
        await (database.select(database.habitDefinitions)
              ..where((row) => row.id.equals(habitId) & row.deletedAt.isNull()))
            .getSingleOrNull();
    if (habit == null || habit.id.startsWith('custom_')) {
      throw StateError('Standard habit not found.');
    }
    final defaults = _defaultThumbEffects(habit.id, habit.category);
    _validateStandardEffectValues(organEffects, defaults);
    final values = {for (final effect in organEffects) effect.partKey: effect};
    final matchesDefaults = defaults.every((effect) {
      final selected = values[effect.partKey];
      return selected != null &&
          selected.thumbUpPoints == effect.thumbUpPoints &&
          selected.thumbDownPoints == effect.thumbDownPoints;
    });
    final existing = await (database.select(
      database.standardHabitOrganEffects,
    )..where((row) => row.habitId.equals(habitId))).get();
    if (!matchesDefaults && existing.isEmpty) {
      final limit = await _loadStandardHabitOrganEffectLimit();
      if (await countStandardHabitsWithOrganEffects() >= limit) {
        throw StateError(
          'Only $limit standard habits can customize organ effects.',
        );
      }
    }
    final now = DateTime.now();
    await database.transaction(() async {
      await (database.delete(
        database.standardHabitOrganEffects,
      )..where((row) => row.habitId.equals(habitId))).go();
      if (matchesDefaults) return;
      for (final effect in organEffects) {
        await database
            .into(database.standardHabitOrganEffects)
            .insert(
              StandardHabitOrganEffectsCompanion.insert(
                habitId: habitId,
                partKey: effect.partKey,
                thumbUpPoints: Value(effect.thumbUpPoints),
                thumbDownPoints: Value(effect.thumbDownPoints),
                updatedAt: now,
              ),
            );
      }
    });
  }

  void _validateStandardEffectValues(
    List<CustomHabitOrganEffect> effects,
    List<CustomHabitOrganEffect> defaults,
  ) {
    final partKeys = <String>{};
    if (effects.length != _organKeys.length) {
      throw ArgumentError('Every organ needs an effect value.');
    }
    final defaultsByPart = {
      for (final effect in defaults) effect.partKey: effect,
    };
    for (final effect in effects) {
      final original = defaultsByPart[effect.partKey];
      if (!_organKeys.contains(effect.partKey) ||
          !partKeys.add(effect.partKey) ||
          (!_customEffectValues.contains(effect.thumbUpPoints) &&
              effect.thumbUpPoints != original?.thumbUpPoints) ||
          (!_customEffectValues.contains(effect.thumbDownPoints) &&
              effect.thumbDownPoints != original?.thumbDownPoints)) {
        throw ArgumentError('Invalid habit organ effect.');
      }
    }
  }

  List<CustomHabitOrganEffect> _defaultThumbEffects(
    String habitId,
    String category,
  ) {
    final performed = _organEffects[habitId] ?? const <String, double>{};
    final notDone = _notDoneOrganEffects[habitId] ?? const <String, double>{};
    final unwanted = category == 'reduction';
    return [
      for (final partKey in _organKeys)
        CustomHabitOrganEffect(
          partKey: partKey,
          thumbUpPoints: (unwanted ? notDone : performed)[partKey] ?? 0,
          thumbDownPoints: (unwanted ? performed : notDone)[partKey] ?? 0,
        ),
    ];
  }

  Future<int> _loadStandardHabitOrganEffectLimit() async {
    final rewardState = await (database.select(
      database.rewardStates,
    )..where((row) => row.id.equals(1))).getSingleOrNull();
    return switch (rewardState?.plan) {
      'pro' => 2,
      'ultra' => 4,
      _ => 0,
    };
  }

  Future<void> _validateCustomOrganEffects(
    List<CustomHabitOrganEffect> effects, {
    String? excludingHabitId,
  }) async {
    final partKeys = <String>{};
    for (final effect in effects) {
      if (!_organKeys.contains(effect.partKey) ||
          !partKeys.add(effect.partKey) ||
          !_customEffectValues.contains(effect.thumbUpPoints) ||
          !_customEffectValues.contains(effect.thumbDownPoints)) {
        throw ArgumentError('Invalid custom habit organ effect.');
      }
    }
    if (!effects.any((effect) => effect.hasEffect)) return;
    final limit = await _loadCustomHabitOrganEffectLimit();
    final rows = await database.select(database.customHabitOrganEffects).get();
    final affectedHabits = rows
        .where(
          (row) =>
              row.habitId != excludingHabitId &&
              (row.thumbUpPoints != 0 || row.thumbDownPoints != 0),
        )
        .map((row) => row.habitId)
        .toSet();
    final alreadyAffected =
        excludingHabitId != null &&
        rows.any(
          (row) =>
              row.habitId == excludingHabitId &&
              (row.thumbUpPoints != 0 || row.thumbDownPoints != 0),
        );
    if (!alreadyAffected && affectedHabits.length >= limit) {
      throw StateError(
        'Only $limit custom habits can affect organs for this plan.',
      );
    }
  }

  Future<int> _loadCustomHabitOrganEffectLimit() async {
    final rewardState = await (database.select(
      database.rewardStates,
    )..where((row) => row.id.equals(1))).getSingleOrNull();
    return switch (rewardState?.plan) {
      'pro' => 3,
      'ultra' => 6,
      _ => 0,
    };
  }

  Future<void> _replaceCustomOrganEffects(
    String habitId,
    List<CustomHabitOrganEffect> effects,
    DateTime now,
  ) async {
    await (database.delete(
      database.customHabitOrganEffects,
    )..where((row) => row.habitId.equals(habitId))).go();
    for (final effect in effects.where((effect) => effect.hasEffect)) {
      await database
          .into(database.customHabitOrganEffects)
          .insert(
            CustomHabitOrganEffectsCompanion.insert(
              habitId: habitId,
              partKey: effect.partKey,
              thumbUpPoints: Value(effect.thumbUpPoints),
              thumbDownPoints: Value(effect.thumbDownPoints),
              updatedAt: now,
            ),
          );
    }
  }

  @override
  Future<void> deleteCustomHabit(String habitId) async {
    final existing =
        await (database.select(database.habitDefinitions)..where(
              (habit) => habit.id.equals(habitId) & habit.deletedAt.isNull(),
            ))
            .getSingleOrNull();
    if (existing == null ||
        !const ['custom_good', 'custom_bad'].contains(existing.category)) {
      throw StateError('Custom habit not found.');
    }
    final now = DateTime.now();
    await database.transaction(() async {
      await (database.delete(
        database.customHabitOrganEffects,
      )..where((row) => row.habitId.equals(habitId))).go();
      await (database.delete(
        database.customGraphRules,
      )..where((row) => row.habitId.equals(habitId))).go();
      await (database.delete(
        database.specialHabitGraphs,
      )..where((row) => row.habitId.equals(habitId))).go();
      await (database.update(database.reductionPlans)..where(
            (row) => row.habitId.equals(habitId) & row.deletedAt.isNull(),
          ))
          .write(
            ReductionPlansCompanion(
              isActive: const Value(false),
              deletedAt: Value(now),
              updatedAt: Value(now),
              syncStatus: const Value('pending'),
            ),
          );
      await (database.update(
        database.habitDefinitions,
      )..where((habit) => habit.id.equals(habitId))).write(
        HabitDefinitionsCompanion(
          isActive: const Value(false),
          isFavorite: const Value(false),
          deletedAt: Value(now),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
    });
  }

  @override
  Future<PersistedBodyState> recordHabit(
    String actionKey, {
    DateTime? occurredAt,
    bool didHabit = true,
  }) async {
    await applyDailyRecovery();
    final now = occurredAt ?? DateTime.now();
    final day = DateTime(now.year, now.month, now.day);
    final storedHabit =
        await (database.select(database.habitDefinitions)..where(
              (habit) =>
                  habit.id.equals(actionKey) | habit.nameKey.equals(actionKey),
            ))
            .getSingleOrNull();
    final seed = storedHabit == null
        ? _resolveSeed(actionKey)
        : _HabitSeed(storedHabit.id, storedHabit.nameKey, storedHabit.category);

    if (storedHabit != null &&
        await _canUseNumericalTracking(storedHabit, now)) {
      final positiveOutcome = seed.category == 'reduction'
          ? !didHabit
          : didHabit;
      return _recordNumericalOutcome(
        habit: storedHabit,
        value: null,
        factor: positiveOutcome ? 1 : -1,
        actualDidHabit: didHabit,
        now: now,
      );
    }

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

      if (seed.category == 'custom_good' || seed.category == 'custom_bad') {
        final usedThumbUp = seed.category == 'custom_good'
            ? didHabit
            : !didHabit;
        await _applyCustomOrganEffects(seed.id, usedThumbUp, now);
      } else {
        final usedThumbUp = seed.category == 'reduction' ? !didHabit : didHabit;
        final customized = await _applyStandardOrganEffects(
          seed.id,
          usedThumbUp,
          now,
        );
        if (didHabit) {
          await _applyBodyProgress(seed.id, now, skipOrganEffects: customized);
        } else {
          await _applyNotDoneProgress(
            seed.id,
            now,
            skipOrganEffects: customized,
          );
        }
      }
      await _updateBodyHistory(day, now);
      await _updateGraphHistory(seed.id, day, now);
    });

    return loadBodyState();
  }

  Future<int?> _loadNumericalHabitLimit(DateTime now) async {
    final rewards = await (database.select(
      database.rewardStates,
    )..where((row) => row.id.equals(1))).getSingleOrNull();
    // A missing rewards row is retained as an unlimited legacy/test state.
    if (rewards == null) return null;
    if (rewards.planExpiresAt?.isBefore(now) == true) return 0;
    return switch (rewards.plan) {
      'free' => 0,
      'plus' => 4,
      'pro' || 'ultra' => null,
      _ => 0,
    };
  }

  Future<bool> _canUseNumericalTracking(
    HabitDefinition habit,
    DateTime now,
  ) async {
    if (!habit.numericalTrackingEnabled) {
      return false;
    }
    final limit = await _loadNumericalHabitLimit(now);
    if (limit == null) return true;
    if (limit == 0) return false;
    final enabled =
        await (database.select(database.habitDefinitions)
              ..where(
                (row) =>
                    row.numericalTrackingEnabled.equals(true) &
                    row.deletedAt.isNull(),
              )
              ..orderBy([(row) => OrderingTerm.asc(row.updatedAt)]))
            .get();
    return enabled.take(limit).any((row) => row.id == habit.id);
  }

  Future<PersistedBodyState> _recordNumericalOutcome({
    required HabitDefinition habit,
    required int? value,
    required double factor,
    required bool actualDidHabit,
    required DateTime now,
  }) async {
    final day = DateTime(now.year, now.month, now.day);
    final entryId = 'numerical:${habit.id}:${_dayKey(day)}';
    await database.transaction(() async {
      final previous = await (database.select(
        database.numericalBodyContributions,
      )..where((row) => row.entryId.equals(entryId))).get();
      for (final contribution in previous) {
        await _changeBodyPartScore(
          contribution.partKey,
          -contribution.points,
          now,
        );
      }
      await (database.delete(
        database.numericalBodyContributions,
      )..where((row) => row.entryId.equals(entryId))).go();

      final contributions = await _numericalContributions(habit, factor);
      await database
          .into(database.numericalHabitEntries)
          .insertOnConflictUpdate(
            NumericalHabitEntriesCompanion.insert(
              id: entryId,
              habitId: habit.id,
              localDay: day,
              value: Value(value),
              outcomeFactor: factor,
              actualDidHabit: actualDidHabit,
              updatedAt: now,
            ),
          );
      for (final contribution in contributions.entries) {
        if (contribution.value == 0) continue;
        await _changeBodyPartScore(contribution.key, contribution.value, now);
        await database
            .into(database.numericalBodyContributions)
            .insert(
              NumericalBodyContributionsCompanion.insert(
                entryId: entryId,
                partKey: contribution.key,
                points: contribution.value,
              ),
            );
      }
      await database
          .into(database.habitLogEntries)
          .insertOnConflictUpdate(
            HabitLogEntriesCompanion.insert(
              id: 'numerical_status:${habit.id}:${_dayKey(day)}',
              habitId: habit.id,
              loggedAt: now,
              localDay: day,
              quantity: Value(actualDidHabit ? 1 : 0),
              createdAt: now,
              updatedAt: now,
            ),
          );
      await _upsertGraphPoint(
        id: 'habit_quantity:${habit.id}:${_dayKey(day)}',
        metricKey: 'habit_quantity',
        habitId: habit.id,
        day: day,
        value: (value ?? (actualDidHabit ? 1 : 0)).toDouble(),
        now: now,
      );
      await _updateBodyHistory(day, now);
      await _updateGraphHistory(habit.id, day, now);
    });
    return loadBodyState();
  }

  Future<Map<String, double>> _numericalContributions(
    HabitDefinition habit,
    double factor,
  ) async {
    final musclePart = switch (habit.id) {
      'workout_arms' => BodyPartKey.arms,
      'workout_shoulders' => BodyPartKey.shoulders,
      'workout_back' => BodyPartKey.back,
      'workout_chest' => BodyPartKey.chest,
      'workout_abs' => BodyPartKey.abs,
      'workout_legs' => BodyPartKey.legs,
      _ => null,
    };
    if (musclePart != null) return {musclePart: factor};
    if (factor == 0) return const {};

    final effects = await _effectiveStandardEffects(habit);
    final useThumbUp = factor > 0;
    return {
      for (final effect in effects)
        if ((useThumbUp ? effect.thumbUpPoints : effect.thumbDownPoints) != 0)
          effect.partKey:
              (useThumbUp ? effect.thumbUpPoints : effect.thumbDownPoints) *
              factor.abs(),
    };
  }

  Future<List<CustomHabitOrganEffect>> _effectiveStandardEffects(
    HabitDefinition habit,
  ) async {
    final defaults = _defaultThumbEffects(habit.id, habit.category);
    final rows = await (database.select(
      database.standardHabitOrganEffects,
    )..where((row) => row.habitId.equals(habit.id))).get();
    if (rows.isEmpty) return defaults;
    final limit = await _loadStandardHabitOrganEffectLimit();
    if (limit == 0) return defaults;
    final allRows = await database
        .select(database.standardHabitOrganEffects)
        .get();
    final ids = allRows.map((row) => row.habitId).toSet();
    final enabled =
        await (database.select(database.habitDefinitions)
              ..where((row) => row.id.isIn(ids) & row.deletedAt.isNull())
              ..orderBy([(row) => OrderingTerm.asc(row.updatedAt)]))
            .get();
    if (!enabled.take(limit).any((row) => row.id == habit.id)) return defaults;
    return [
      for (final row in rows)
        CustomHabitOrganEffect(
          partKey: row.partKey,
          thumbUpPoints: row.thumbUpPoints,
          thumbDownPoints: row.thumbDownPoints,
        ),
    ];
  }

  Future<void> _applyCustomOrganEffects(
    String habitId,
    bool usedThumbUp,
    DateTime now,
  ) async {
    final limit = await _loadCustomHabitOrganEffectLimit();
    if (limit == 0) return;
    final effects = await (database.select(
      database.customHabitOrganEffects,
    )..where((row) => row.habitId.equals(habitId))).get();
    if (effects.isEmpty) return;
    final configuredRows = await database
        .select(database.customHabitOrganEffects)
        .get();
    final configuredHabitIds = configuredRows
        .where((row) => row.thumbUpPoints != 0 || row.thumbDownPoints != 0)
        .map((row) => row.habitId)
        .toSet();
    final customHabits =
        await (database.select(database.habitDefinitions)
              ..where(
                (habit) =>
                    habit.id.isIn(configuredHabitIds) &
                    habit.deletedAt.isNull(),
              )
              ..orderBy([(habit) => OrderingTerm.asc(habit.createdAt)]))
            .get();
    final enabledHabitIds = customHabits
        .take(limit)
        .map((habit) => habit.id)
        .toSet();
    if (!enabledHabitIds.contains(habitId)) return;
    for (final effect in effects) {
      final points = usedThumbUp
          ? effect.thumbUpPoints
          : effect.thumbDownPoints;
      if (points != 0) await _changeOrganScore(effect.partKey, points, now);
    }
  }

  Future<bool> _applyStandardOrganEffects(
    String habitId,
    bool usedThumbUp,
    DateTime now,
  ) async {
    final limit = await _loadStandardHabitOrganEffectLimit();
    if (limit == 0) return false;
    final rows = await (database.select(
      database.standardHabitOrganEffects,
    )..where((row) => row.habitId.equals(habitId))).get();
    if (rows.isEmpty) return false;
    final allRows = await database
        .select(database.standardHabitOrganEffects)
        .get();
    final configuredIds = allRows.map((row) => row.habitId).toSet();
    final configuredHabits =
        await (database.select(database.habitDefinitions)
              ..where(
                (habit) =>
                    habit.id.isIn(configuredIds) & habit.deletedAt.isNull(),
              )
              ..orderBy([(habit) => OrderingTerm.asc(habit.updatedAt)]))
            .get();
    if (!configuredHabits.take(limit).any((habit) => habit.id == habitId)) {
      return false;
    }
    for (final row in rows) {
      final points = usedThumbUp ? row.thumbUpPoints : row.thumbDownPoints;
      if (points != 0) await _changeOrganScore(row.partKey, points, now);
    }
    return true;
  }

  @override
  Future<PersistedBodyState> loadBodyState() async {
    final rows = await database.select(database.bodyPartStates).get();
    return PersistedBodyState({
      for (final row in rows)
        row.partKey: PersistedBodyPart(
          level: row.level,
          score: row.score ?? row.level.toDouble(),
          colorValue: row.colorValue,
        ),
    });
  }

  @override
  Future<PersistedBodyState> applyDailyRecovery({DateTime? now}) async {
    final current = now ?? DateTime.now();
    await _applyOvernightRecovery(current);
    await _applyInactivityDecay(current);
    await _updateBodyHistory(
      DateTime(current.year, current.month, current.day),
      current,
    );
    return loadBodyState();
  }

  @override
  Future<PersistedBodyState> applyBreathingReward({
    DateTime? occurredAt,
  }) async {
    final now = occurredAt ?? DateTime.now();
    await applyDailyRecovery(now: now);
    final day = DateTime(now.year, now.month, now.day);
    await database.transaction(() async {
      await _changeOrganScore(BodyPartKey.brain, 1.5, now);
      await _changeOrganScore(BodyPartKey.lungs, 1.5, now);
      await _updateBodyHistory(day, now);
    });
    return loadBodyState();
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

  Future<void> _applyOvernightRecovery(DateTime now) async {
    final today = DateTime(now.year, now.month, now.day);
    final setting =
        await (database.select(database.appSettings)
              ..where((row) => row.key.equals('last_organ_recovery_day')))
            .getSingleOrNull();
    final previousDay = setting == null
        ? null
        : DateTime.tryParse(setting.value);
    if (previousDay != null) {
      final todayUtc = DateTime.utc(today.year, today.month, today.day);
      final previousUtc = DateTime.utc(
        previousDay.year,
        previousDay.month,
        previousDay.day,
      );
      final elapsedDays = todayUtc.difference(previousUtc).inDays;
      if (elapsedDays > 0) {
        for (final recovery in _overnightRecovery.entries) {
          await _changeOrganScore(
            recovery.key,
            recovery.value * elapsedDays,
            now,
          );
        }
      }
    }
    await database
        .into(database.appSettings)
        .insertOnConflictUpdate(
          AppSettingsCompanion.insert(
            key: 'last_organ_recovery_day',
            value: _dayKey(today),
            updatedAt: now,
          ),
        );
  }

  Future<void> _applyInactivityDecay(DateTime now) async {
    final today = DateTime(now.year, now.month, now.day);
    final habits =
        await (database.select(database.habitDefinitions)..where(
              (habit) => habit.isActive.equals(true) & habit.deletedAt.isNull(),
            ))
            .get();
    final logs = await (database.select(
      database.habitLogEntries,
    )..where((entry) => entry.deletedAt.isNull())).get();
    final standardRows = await database
        .select(database.standardHabitOrganEffects)
        .get();
    final customRows = await database
        .select(database.customHabitOrganEffects)
        .get();
    final settings = {
      for (final setting in await database.select(database.appSettings).get())
        setting.key: setting.value,
    };

    final lastTrackedByHabit = <String, DateTime>{};
    final lastCompletedByHabit = <String, DateTime>{};
    for (final log in logs) {
      final day = DateTime(
        log.localDay.year,
        log.localDay.month,
        log.localDay.day,
      );
      if (day.isAfter(today)) continue;
      final previousTracked = lastTrackedByHabit[log.habitId];
      if (previousTracked == null || day.isAfter(previousTracked)) {
        lastTrackedByHabit[log.habitId] = day;
      }
      if (log.quantity > 0) {
        final previousCompleted = lastCompletedByHabit[log.habitId];
        if (previousCompleted == null || day.isAfter(previousCompleted)) {
          lastCompletedByHabit[log.habitId] = day;
        }
      }
    }

    final standardRowsByHabit = <String, List<StandardHabitOrganEffectRow>>{};
    for (final row in standardRows) {
      standardRowsByHabit.putIfAbsent(row.habitId, () => []).add(row);
    }
    final customRowsByHabit = <String, List<CustomHabitOrganEffectRow>>{};
    for (final row in customRows) {
      customRowsByHabit.putIfAbsent(row.habitId, () => []).add(row);
    }

    final activeOrganHabits = <String, Set<String>>{
      for (final partKey in _organKeys) partKey: <String>{},
    };
    for (final habit in habits) {
      final customEffects = customRowsByHabit[habit.id];
      if (customEffects != null && customEffects.isNotEmpty) {
        for (final effect in customEffects) {
          if (effect.thumbUpPoints != 0 || effect.thumbDownPoints != 0) {
            activeOrganHabits[effect.partKey]?.add(habit.id);
          }
        }
        continue;
      }

      final customizedEffects = standardRowsByHabit[habit.id];
      if (customizedEffects != null && customizedEffects.isNotEmpty) {
        for (final effect in customizedEffects) {
          if (effect.thumbUpPoints != 0 || effect.thumbDownPoints != 0) {
            activeOrganHabits[effect.partKey]?.add(habit.id);
          }
        }
        continue;
      }

      final partKeys = <String>{
        ...?_organEffects[habit.id]?.keys,
        ...?_notDoneOrganEffects[habit.id]?.keys,
      };
      for (final partKey in partKeys) {
        activeOrganHabits[partKey]?.add(habit.id);
      }
    }

    for (final partKey in _organKeys) {
      await _applyPeriodicPartDecay(
        partKey: partKey,
        relevantHabitIds: activeOrganHabits[partKey] ?? const {},
        lastActivityByHabit: lastTrackedByHabit,
        intervalDays: 2,
        today: today,
        now: now,
        settings: settings,
        isMuscle: false,
      );
    }

    for (final muscle in _exerciseMuscleParts.entries) {
      final legacyIds = switch (muscle.key) {
        'workout_shoulders' ||
        'workout_back' => const {'workout_shoulders_back'},
        _ => const <String>{},
      };
      await _applyPeriodicPartDecay(
        partKey: muscle.value,
        relevantHabitIds: {muscle.key, ...legacyIds},
        lastActivityByHabit: lastCompletedByHabit,
        intervalDays: 4,
        today: today,
        now: now,
        settings: settings,
        isMuscle: true,
      );
    }
  }

  Future<void> _applyPeriodicPartDecay({
    required String partKey,
    required Set<String> relevantHabitIds,
    required Map<String, DateTime> lastActivityByHabit,
    required int intervalDays,
    required DateTime today,
    required DateTime now,
    required Map<String, String> settings,
    required bool isMuscle,
  }) async {
    final settingKey = 'inactivity_decay_anchor:$partKey';
    var anchor = DateTime.tryParse(settings[settingKey] ?? '');

    // Organs with no active related habit are deliberately not penalized.
    if (relevantHabitIds.isEmpty) {
      await _saveInactivityAnchor(settingKey, today, now);
      settings[settingKey] = _dayKey(today);
      return;
    }

    if (anchor == null) {
      await _saveInactivityAnchor(settingKey, today, now);
      settings[settingKey] = _dayKey(today);
      return;
    }
    var effectiveAnchor = DateTime(anchor.year, anchor.month, anchor.day);

    for (final habitId in relevantHabitIds) {
      final activityDay = lastActivityByHabit[habitId];
      if (activityDay != null && activityDay.isAfter(effectiveAnchor)) {
        effectiveAnchor = activityDay;
      }
    }

    final elapsedDays = today.difference(effectiveAnchor).inDays;
    final periods = elapsedDays ~/ intervalDays;
    if (periods > 0) {
      if (isMuscle) {
        await _changeMuscleScore(partKey, -periods.toDouble(), now);
      } else {
        await _changeOrganScore(partKey, -periods.toDouble(), now);
      }
      effectiveAnchor = effectiveAnchor.add(
        Duration(days: periods * intervalDays),
      );
    }

    final storedAnchor = DateTime.tryParse(settings[settingKey] ?? '');
    if (storedAnchor == null || storedAnchor != effectiveAnchor) {
      await _saveInactivityAnchor(settingKey, effectiveAnchor, now);
      settings[settingKey] = _dayKey(effectiveAnchor);
    }
  }

  Future<void> _saveInactivityAnchor(String key, DateTime day, DateTime now) {
    return database
        .into(database.appSettings)
        .insertOnConflictUpdate(
          AppSettingsCompanion.insert(
            key: key,
            value: _dayKey(day),
            updatedAt: now,
          ),
        );
  }

  Future<void> _applyBodyProgress(
    String habitId,
    DateTime now, {
    bool skipOrganEffects = false,
  }) async {
    if (!skipOrganEffects) {
      final organEffects = _organEffects[habitId];
      if (organEffects != null) {
        for (final effect in organEffects.entries) {
          await _changeOrganScore(effect.key, effect.value, now);
        }
        return;
      }
    }
    switch (habitId) {
      case 'workout_arms':
        await _raiseMuscle(BodyPartKey.arms, now);
        return;
      case 'workout_shoulders':
        await _raiseMuscle(BodyPartKey.shoulders, now);
        return;
      case 'workout_back':
        await _raiseMuscle(BodyPartKey.back, now);
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

  Future<void> _applyNotDoneProgress(
    String habitId,
    DateTime now, {
    bool skipOrganEffects = false,
  }) async {
    if (!skipOrganEffects) {
      final organEffects = _notDoneOrganEffects[habitId];
      if (organEffects != null) {
        for (final effect in organEffects.entries) {
          await _changeOrganScore(effect.key, effect.value, now);
        }
        return;
      }
    }
    switch (habitId) {
      case 'workout_arms':
        await _lowerMuscle(BodyPartKey.arms, now);
      case 'workout_shoulders':
        await _lowerMuscle(BodyPartKey.shoulders, now);
      case 'workout_back':
        await _lowerMuscle(BodyPartKey.back, now);
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
    double points,
    DateTime now,
  ) async {
    final existing = await _bodyPart(partKey);
    final currentScore = existing?.score ?? existing?.level.toDouble() ?? 3.0;
    final maximumScore = await _maximumOrganScore(partKey, now);
    final nextScore = (currentScore + points)
        .clamp(1.0, maximumScore)
        .toDouble();
    final nextLevel = nextScore.round().clamp(1, maximumScore.round());
    await _upsertBodyPart(
      partKey: partKey,
      level: nextLevel,
      score: nextScore,
      colorValue: maximumScore == 10 && partKey == BodyPartKey.brain
          ? _premiumMindColor(nextLevel)
          : _organColor(nextLevel),
      updatedAt: now,
    );
  }

  Future<void> _changeBodyPartScore(
    String partKey,
    double points,
    DateTime now,
  ) {
    if (_muscleKeys.contains(partKey)) {
      return _changeMuscleScore(partKey, points, now);
    }
    return _changeOrganScore(partKey, points, now);
  }

  Future<void> _changeMuscleScore(
    String partKey,
    double points,
    DateTime now,
  ) async {
    final existing = await _bodyPart(partKey);
    final currentScore = existing?.score ?? existing?.level.toDouble() ?? 1;
    final nextScore = (currentScore + points).clamp(1.0, 5.0).toDouble();
    final nextLevel = nextScore.round().clamp(1, 5);
    await _upsertBodyPart(
      partKey: partKey,
      level: nextLevel,
      score: nextScore,
      colorValue: _muscleColor(nextLevel),
      updatedAt: now,
    );
  }

  Future<double> _maximumOrganScore(String partKey, DateTime now) async {
    if (partKey != BodyPartKey.brain) return 5;
    final rewards = await (database.select(
      database.rewardStates,
    )..where((row) => row.id.equals(1))).getSingleOrNull();
    final paidPlan = const {'plus', 'pro', 'ultra'}.contains(rewards?.plan);
    final active =
        rewards?.planExpiresAt == null || rewards!.planExpiresAt!.isAfter(now);
    return paidPlan && active ? 10 : 5;
  }

  Future<void> _raiseMuscle(String partKey, DateTime now) async {
    final existing = await _bodyPart(partKey);
    final nextLevel = math.min(5, (existing?.level ?? 0) + 1);
    await _upsertBodyPart(
      partKey: partKey,
      level: nextLevel,
      score: nextLevel.toDouble(),
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
      score: nextLevel.toDouble(),
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
    required double score,
    required int colorValue,
    required DateTime updatedAt,
  }) {
    return database
        .into(database.bodyPartStates)
        .insertOnConflictUpdate(
          BodyPartStatesCompanion.insert(
            partKey: partKey,
            level: Value(level),
            score: Value(score),
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

  Future<void> _updateBodyHistory(DateTime day, DateTime now) async {
    final rows = await database.select(database.bodyPartStates).get();
    final levels = {for (final row in rows) row.partKey: row.level};
    final organLevels = [for (final key in _organKeys) levels[key] ?? 3];
    final muscleLevels = [for (final key in _muscleKeys) levels[key] ?? 1];
    final dayKey = _dayKey(day);
    await _upsertGraphPoint(
      id: 'organ_min_level:$dayKey',
      metricKey: 'organ_min_level',
      day: day,
      value: organLevels.reduce(math.min).toDouble(),
      now: now,
    );
    await _upsertGraphPoint(
      id: 'organ_max_level:$dayKey',
      metricKey: 'organ_max_level',
      day: day,
      value: organLevels.reduce(math.max).toDouble(),
      now: now,
    );
    await _upsertGraphPoint(
      id: 'muscle_min_level:$dayKey',
      metricKey: 'muscle_min_level',
      day: day,
      value: muscleLevels.reduce(math.min).toDouble(),
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

  static int _premiumMindColor(int level) {
    return switch (level) {
      <= 1 => 0xFFE53935,
      2 => 0xFFFB8C00,
      <= 5 => 0xFFFFCA28,
      <= 8 => 0xFF43A047,
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
