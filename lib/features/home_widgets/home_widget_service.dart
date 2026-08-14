import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:home_widget/home_widget.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/habits/habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/calendar/calendar_models.dart';
import 'package:visualyou/features/calendar/calendar_repository.dart';
import 'package:visualyou/features/reduction_calendar/reduction_calendar_repository.dart';
import 'package:visualyou/features/reduction_calendar/reduction_calendar.dart'
    show isReductionAllowedDay, isReductionViolation;
import 'package:visualyou/features/reduction_calendar/reduction_calendar_models.dart';
import 'package:visualyou/features/rewards/rewards_repository.dart';

const _androidWidgetNames = <String>[
  'QuickAddWidgetProvider',
  'SingleHabitWidgetProvider',
  'ReductionCalendarWidgetProvider',
  'MainCalendarWidgetProvider',
  'StreakCalendarWidgetProvider',
];

@pragma('vm:entry-point')
Future<void> visualYouWidgetBackgroundCallback(Uri? uri) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (uri == null || uri.host != 'action') return;

  final database = AppDatabase.defaults();
  final habitRepository = DriftHabitRepository(database);
  final reductionRepository = DriftReductionCalendarRepository(database);
  final rewardsRepository = RewardsRepository(database);
  try {
    await habitRepository.initialize();
    await rewardsRepository.initialize();
    final rewards = await rewardsRepository.loadSnapshot();
    // The native UI also redirects free users into the app. This second check
    // prevents a forged background URI from bypassing the Plus restriction.
    if (!rewards.isPlus) return;

    switch (uri.pathSegments.firstOrNull) {
      case 'habit':
        final habitId = uri.queryParameters['habitId'];
        final didHabit = uri.queryParameters['didHabit'];
        if (habitId == null || didHabit == null) return;
        await habitRepository.recordHabit(
          habitId,
          didHabit: didHabit == 'true',
        );
        break;
      case 'reduction':
        final planId = uri.queryParameters['planId'];
        final didHabit = uri.queryParameters['didHabit'];
        if (planId == null || didHabit == null) return;
        await reductionRepository.setDayStatus(
          planId: planId,
          day: DateTime.now(),
          didHabit: didHabit == 'true',
        );
        break;
      default:
        return;
    }
    await rewardsRepository.refresh();
    await HomeWidgetService.syncFromDatabase(database);
  } catch (error, stackTrace) {
    debugPrint('Visual You widget action failed: $error\n$stackTrace');
  } finally {
    await database.close();
  }
}

class HomeWidgetService {
  const HomeWidgetService._();

  static Future<void> initialize() async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
    await HomeWidget.registerInteractivityCallback(
      visualYouWidgetBackgroundCallback,
    );
  }

  static Future<void> syncFromDatabase(AppDatabase database) async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
    final habitRepository = DriftHabitRepository(database);
    final rewardsRepository = RewardsRepository(database);
    final calendarRepository = DriftCalendarRepository(database);
    final reductionRepository = DriftReductionCalendarRepository(database);
    await sync(
      habitRepository: habitRepository,
      rewardsRepository: rewardsRepository,
      calendarRepository: calendarRepository,
      reductionRepository: reductionRepository,
    );
  }

  static Future<void> sync({
    required HabitRepository habitRepository,
    required RewardsRepository rewardsRepository,
    required CalendarRepository calendarRepository,
    required ReductionCalendarRepository reductionRepository,
  }) async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
    final now = DateTime.now();
    final preferences = await habitRepository.watchHabitPreferences().first;
    final appPreferences = await habitRepository.loadAppPreferences();
    final rewards = await rewardsRepository.loadSnapshot(now: now);
    final summaries = await calendarRepository.watchMonth(now).first;
    final plans = await reductionRepository.watchPlansMonth(now).first;
    final favorites = preferences
        .where((habit) => habit.isActive && habit.isFavorite)
        .where(
          (habit) =>
              rewards.isPlus ||
              (habit.id != 'consuming_sugar' &&
                  habit.id != 'studying' &&
                  !habit.id.startsWith('custom_')),
        )
        .take(3)
        .toList();

    await HomeWidget.saveWidgetData<bool>('is_plus', rewards.isPlus);
    await HomeWidget.saveWidgetData<String>(
      'widget_accent',
      appPreferences.accent,
    );
    await HomeWidget.saveWidgetData<String>(
      'widget_theme_mode',
      appPreferences.themeMode,
    );
    await HomeWidget.saveWidgetData<int>('quick_count', favorites.length);
    for (var index = 0; index < 3; index++) {
      final habit = index < favorites.length ? favorites[index] : null;
      await HomeWidget.saveWidgetData<String>('quick_${index}_id', habit?.id);
      await HomeWidget.saveWidgetData<String>(
        'quick_${index}_name',
        habit?.nameKey,
      );
      await HomeWidget.saveWidgetData<bool>(
        'quick_${index}_unwanted',
        habit == null ? null : _isUnwanted(habit),
      );
    }

    final single = favorites.firstOrNull;
    await HomeWidget.saveWidgetData<String>('single_id', single?.id);
    await HomeWidget.saveWidgetData<String>('single_name', single?.nameKey);
    await HomeWidget.saveWidgetData<bool>(
      'single_unwanted',
      single == null ? null : _isUnwanted(single),
    );

    final plan = plans.firstOrNull;
    await HomeWidget.saveWidgetData<String>('reduction_plan_id', plan?.planId);
    await HomeWidget.saveWidgetData<String>(
      'reduction_habit_name',
      plan?.habitNameKey,
    );
    await HomeWidget.saveWidgetData<String>('reduction_mode', plan?.mode);
    await HomeWidget.saveWidgetData<bool>(
      'reduction_tracked_today',
      plan?.hasStatusOn(now) ?? false,
    );
    await HomeWidget.saveWidgetData<String>(
      'reduction_levels',
      [
        for (
          var day = 1;
          day <= DateTime(now.year, now.month + 1, 0).day;
          day++
        )
          if (plan == null)
            -1
          else
            _reductionLevel(plan, DateTime(now.year, now.month, day)),
      ].join(','),
    );

    final scores = <int>[for (var day = 1; day <= 31; day++) 99];
    for (final summary in summaries) {
      scores[summary.day.day - 1] = _levelNumber(summary.level);
    }
    await HomeWidget.saveWidgetData<int>('calendar_year', now.year);
    await HomeWidget.saveWidgetData<int>('calendar_month', now.month);
    await HomeWidget.saveWidgetData<String>(
      'calendar_levels',
      scores.join(','),
    );
    await HomeWidget.saveWidgetData<int>(
      'calendar_days_in_month',
      DateTime(now.year, now.month + 1, 0).day,
    );
    await HomeWidget.saveWidgetData<int>(
      'calendar_first_weekday',
      DateTime(now.year, now.month, 1).weekday,
    );

    await HomeWidget.saveWidgetData<int>(
      'streak_current',
      rewards.currentStreak,
    );
    await HomeWidget.saveWidgetData<String>(
      'streak_activity_days',
      rewards.activityDays
          .where((day) => day.year == now.year && day.month == now.month)
          .map((day) => day.day)
          .join(','),
    );
    await HomeWidget.saveWidgetData<int>(
      'streak_joined_year',
      rewards.joinedAt.year,
    );
    await HomeWidget.saveWidgetData<int>(
      'streak_joined_month',
      rewards.joinedAt.month,
    );
    await HomeWidget.saveWidgetData<int>(
      'streak_joined_day',
      rewards.joinedAt.day,
    );

    await Future.wait([
      for (final name in _androidWidgetNames)
        HomeWidget.updateWidget(androidName: name),
    ]);
  }

  static Stream<Uri?> get clicked {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return const Stream<Uri?>.empty();
    }
    return HomeWidget.widgetClicked.handleError((Object error) {
      debugPrint('Home-screen widget click stream unavailable: $error');
    });
  }

  static Future<Uri?> initiallyLaunched() {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return Future.value();
    }
    return HomeWidget.initiallyLaunchedFromHomeWidget().catchError((
      Object error,
    ) {
      debugPrint('Could not read the initial widget launch: $error');
      return null;
    });
  }

  static bool _isUnwanted(HabitPreference habit) =>
      habit.category == 'reduction' || habit.category == 'custom_bad';

  static int _levelNumber(CalendarPerformanceLevel level) => switch (level) {
    CalendarPerformanceLevel.terrible => 0,
    CalendarPerformanceLevel.bad => 1,
    CalendarPerformanceLevel.okay => 2,
    CalendarPerformanceLevel.good => 3,
    CalendarPerformanceLevel.excellent => 4,
  };

  static int _reductionLevel(ReductionCalendarData plan, DateTime day) {
    if (day.isBefore(plan.startedOn)) return -1;
    if (isReductionViolation(plan, day)) return 3;
    if (plan.hasStatusOn(day)) return plan.countOn(day) > 0 ? 2 : 4;
    return isReductionAllowedDay(plan, day) ? 1 : 0;
  }
}
