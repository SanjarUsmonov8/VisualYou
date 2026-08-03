import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/habits/habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/calendar/calendar_models.dart';
import 'package:visualyou/features/calendar/calendar_repository.dart';
import 'package:visualyou/features/custom_graph/custom_graph_models.dart';
import 'package:visualyou/features/custom_graph/custom_graph_repository.dart';
import 'package:visualyou/features/reduction_calendar/reduction_calendar_repository.dart';

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
      final firstGraphRepository = DriftCustomGraphRepository(firstDatabase);
      await firstRepository.initialize();
      expect(await firstRepository.isOnboardingComplete(), isFalse);
      await firstRepository.completeOnboarding();
      await firstRepository.saveAppPreferences(
        PersistedAppPreferences(
          themeMode: 'dark',
          accent: 'pink',
          gender: 'female',
          language: 'uzbek',
          profileName: 'Alex',
          birthDate: DateTime(2008, 4, 12),
          profileImageBase64: 'AQID',
        ),
      );
      final initialBody = await firstRepository.loadBodyState();
      for (final partKey in [
        BodyPartKey.brain,
        BodyPartKey.lungs,
        BodyPartKey.heart,
        BodyPartKey.liver,
        BodyPartKey.stomach,
        BodyPartKey.kidneys,
        BodyPartKey.gut,
      ]) {
        expect(initialBody.parts[partKey]?.level, 3);
        expect(initialBody.parts[partKey]?.colorValue, isNull);
      }
      final initialPreferences = await firstRepository
          .watchHabitPreferences()
          .first
          .timeout(const Duration(seconds: 5));
      expect(
        initialPreferences.where((habit) => habit.id == 'smoke_free'),
        isEmpty,
      );
      expect(
        initialPreferences
            .singleWhere((habit) => habit.id == 'consuming_sugar')
            .category,
        'reduction',
      );
      await firstGraphRepository.saveRules([
        const CustomGraphRule(
          slot: 0,
          habitId: 'alcohol',
          habitNameKey: 'Alcohol',
          completedPoints: -6,
          missedPoints: 5,
        ),
      ]);
      await firstGraphRepository.saveSpecialHabit(slot: 0, habitId: 'water');
      final firstReductionRepository = DriftReductionCalendarRepository(
        firstDatabase,
      );
      await firstReductionRepository.createHardPlan(
        habitId: 'smoking',
        startedOn: DateTime(2026, 7, 27),
      );
      await firstRepository.setHabitActive('water', false);
      await firstRepository.setHabitFavorite('smoking', true);

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
      final reopenedGraphRepository = DriftCustomGraphRepository(
        reopenedDatabase,
      );
      final calendarRepository = DriftCalendarRepository(reopenedDatabase);
      final reductionRepository = DriftReductionCalendarRepository(
        reopenedDatabase,
      );
      await reopenedRepository.initialize();
      expect(await reopenedRepository.isOnboardingComplete(), isTrue);
      final appPreferences = await reopenedRepository.loadAppPreferences();
      expect(appPreferences.themeMode, 'dark');
      expect(appPreferences.accent, 'pink');
      expect(appPreferences.gender, 'female');
      expect(appPreferences.language, 'uzbek');
      expect(appPreferences.profileName, 'Alex');
      expect(appPreferences.birthDate, DateTime(2008, 4, 12));
      expect(appPreferences.profileImageBase64, 'AQID');
      final restoredBody = await reopenedRepository.loadBodyState();
      final restoredPreferences = await reopenedRepository
          .watchHabitPreferences()
          .first
          .timeout(const Duration(seconds: 5));

      expect(
        restoredPreferences
            .singleWhere((habit) => habit.id == 'water')
            .isActive,
        isFalse,
      );
      expect(
        restoredPreferences
            .singleWhere((habit) => habit.id == 'water')
            .isFavorite,
        isFalse,
      );
      expect(
        restoredPreferences
            .singleWhere((habit) => habit.id == 'smoking')
            .isFavorite,
        isTrue,
      );

      expect(restoredBody.parts[BodyPartKey.brain]?.colorValue, 0xFFE53935);
      expect(restoredBody.parts[BodyPartKey.heart]?.colorValue, 0xFFE53935);
      expect(restoredBody.parts[BodyPartKey.liver]?.colorValue, 0xFFE53935);
      expect(restoredBody.parts[BodyPartKey.stomach]?.colorValue, 0xFFE53935);
      expect(restoredBody.parts[BodyPartKey.gut]?.colorValue, 0xFFE53935);
      expect(restoredBody.parts[BodyPartKey.kidneys]?.colorValue, 0xFFFB8C00);
      expect(restoredBody.parts[BodyPartKey.lungs]?.colorValue, isNull);
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

      final customRules = await reopenedGraphRepository.loadRules();
      expect(customRules.single.habitId, 'alcohol');
      expect(customRules.single.completedPoints, -6);
      expect(customRules.single.missedPoints, 5);

      final customSnapshot = await reopenedGraphRepository
          .watchSnapshot()
          .first
          .timeout(const Duration(seconds: 5));
      expect(customSnapshot.rules.single.habitId, 'alcohol');
      expect(customSnapshot.days.length, 7);

      final specialGraphs = await reopenedGraphRepository
          .watchSpecialHabitGraphs()
          .first
          .timeout(const Duration(seconds: 5));
      expect(specialGraphs.single.habitId, 'water');
      expect(specialGraphs.single.days.length, 7);

      final calendar = await calendarRepository
          .watchMonth(DateTime(2026, 7))
          .first
          .timeout(const Duration(seconds: 5));
      expect(calendar.single.score, 1);
      expect(calendar.single.level, CalendarPerformanceLevel.good);
      expect(calendar.single.activities.length, 2);

      final reductionPlan = await reductionRepository
          .watchMonth(DateTime(2026, 7))
          .first
          .timeout(const Duration(seconds: 5));
      expect(reductionPlan?.habitId, 'smoking');
      expect(reductionPlan?.mode, 'hard');
      expect(reductionPlan?.startedOn, DateTime(2026, 7, 27));

      await reductionRepository.createMediumPlan(
        habitId: 'vaping',
        startedOn: DateTime(2026, 7, 20),
      );
      var reductionPlans = await reductionRepository
          .watchPlansMonth(DateTime(2026, 7))
          .first
          .timeout(const Duration(seconds: 5));
      expect(reductionPlans, hasLength(1));
      expect(reductionPlans.single.habitId, 'vaping');

      final vapingPlan = reductionPlans.single;
      final selectedDay = DateTime(2026, 7, 29);
      await reductionRepository.setDayStatus(
        planId: vapingPlan.planId,
        day: selectedDay,
        didHabit: true,
      );
      reductionPlans = await reductionRepository
          .watchPlansMonth(DateTime(2026, 7))
          .first
          .timeout(const Duration(seconds: 5));
      expect(reductionPlans.single.countOn(selectedDay), 1);

      await reductionRepository.setDayStatus(
        planId: vapingPlan.planId,
        day: selectedDay,
        didHabit: false,
      );
      reductionPlans = await reductionRepository
          .watchPlansMonth(DateTime(2026, 7))
          .first
          .timeout(const Duration(seconds: 5));
      expect(reductionPlans.single.countOn(selectedDay), 0);
    },
  );
}
