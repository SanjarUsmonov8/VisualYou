import 'package:flutter/material.dart';
import 'package:visualyou/features/calendar/calendar_models.dart';
import 'package:visualyou/features/calendar/calendar_repository.dart';
import 'package:visualyou/features/rewards/rewards_controller.dart';
import 'package:visualyou/features/rewards/rewards_widgets.dart';
import 'package:visualyou/l10n/app_strings.dart';

class HabitCalendar extends StatefulWidget {
  const HabitCalendar({
    required this.repository,
    required this.rewardsController,
    super.key,
  });

  final CalendarRepository repository;
  final RewardsController rewardsController;

  @override
  State<HabitCalendar> createState() => _HabitCalendarState();
}

class _HabitCalendarState extends State<HabitCalendar> {
  late DateTime _visibleMonth;
  late DateTime _selectedDay;
  late Stream<List<CalendarDaySummary>> _monthStream;
  bool _olderMonthsUnlocked = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _visibleMonth = DateTime(now.year, now.month);
    _selectedDay = DateTime(now.year, now.month, now.day);
    _monthStream = widget.repository.watchMonth(_visibleMonth);
  }

  @override
  void didUpdateWidget(HabitCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.repository != widget.repository) {
      _monthStream = widget.repository.watchMonth(_visibleMonth);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return StreamBuilder<List<CalendarDaySummary>>(
      stream: _monthStream,
      builder: (context, snapshot) {
        final summaries = {
          for (final summary in snapshot.data ?? const <CalendarDaySummary>[])
            _dayKey(summary.day): summary,
        };
        final selectedSummary = summaries[_dayKey(_selectedDay)];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF24272E)
                    : const Color(0xFFF0F2F5),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: .14),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        tooltip: context.tr('Previous month'),
                        onPressed: () => _changeMonth(-1),
                        icon: const Icon(Icons.chevron_left_rounded),
                      ),
                      Expanded(
                        child: Text(
                          MaterialLocalizations.of(
                            context,
                          ).formatMonthYear(_visibleMonth),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: context.tr('Next month'),
                        onPressed: () => _changeMonth(1),
                        icon: const Icon(Icons.chevron_right_rounded),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  _WeekdayHeader(),
                  const SizedBox(height: 5),
                  _MonthGrid(
                    month: _visibleMonth,
                    selectedDay: _selectedDay,
                    summaries: summaries,
                    onSelected: (day) => setState(() => _selectedDay = day),
                  ),
                  const SizedBox(height: 12),
                  _CalendarLegend(),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _SelectedDayCard(day: _selectedDay, summary: selectedSummary),
          ],
        );
      },
    );
  }

  Future<void> _changeMonth(int offset) async {
    final nextMonth = DateTime(
      _visibleMonth.year,
      _visibleMonth.month + offset,
    );
    final now = DateTime.now();
    final previousMonth = DateTime(now.year, now.month - 1);
    final isOlder = nextMonth.isBefore(previousMonth);
    if (isOlder && !widget.rewardsController.isPlus && !_olderMonthsUnlocked) {
      final paid = await confirmTokenOrAdPurchase(
        context,
        controller: widget.rewardsController,
        amount: 35,
        reason: 'older-calendar-session',
        title: context.tr('Open older calendar history?'),
      );
      if (!paid || !mounted) return;
      _olderMonthsUnlocked = true;
    }
    if (!mounted) return;
    setState(() {
      _visibleMonth = nextMonth;
      _selectedDay = DateTime(nextMonth.year, nextMonth.month, 1);
      _monthStream = widget.repository.watchMonth(nextMonth);
    });
  }

  static String _dayKey(DateTime day) => '${day.year}-${day.month}-${day.day}';
}

class _WeekdayHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sundayFirst = MaterialLocalizations.of(context).narrowWeekdays;
    final mondayFirst = [...sundayFirst.skip(1), sundayFirst.first];
    return Row(
      children: [
        for (final weekday in mondayFirst)
          Expanded(
            child: Text(
              weekday,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
      ],
    );
  }
}

class _MonthGrid extends StatelessWidget {
  const _MonthGrid({
    required this.month,
    required this.selectedDay,
    required this.summaries,
    required this.onSelected,
  });

  final DateTime month;
  final DateTime selectedDay;
  final Map<String, CalendarDaySummary> summaries;
  final ValueChanged<DateTime> onSelected;

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(month.year, month.month);
    final leadingDays = firstDay.weekday - 1;
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final usedCells = leadingDays + daysInMonth;
    final cellCount = usedCells <= 35 ? 35 : 42;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cellCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        final dayNumber = index - leadingDays + 1;
        if (dayNumber < 1 || dayNumber > daysInMonth) {
          return const SizedBox.shrink();
        }
        final day = DateTime(month.year, month.month, dayNumber);
        final summary = summaries[_dayKey(day)];
        final selected = _sameDay(day, selectedDay);
        final theme = Theme.of(context);
        final backgroundColor = summary?.hasActivity == true
            ? _levelColor(summary!.level)
            : theme.colorScheme.surfaceContainerHighest;
        return Semantics(
          button: true,
          selected: selected,
          label: '$dayNumber',
          child: InkWell(
            borderRadius: BorderRadius.circular(13),
            onTap: () => onSelected(day),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(13),
                border: selected
                    ? Border.all(color: theme.colorScheme.onSurface, width: 2)
                    : null,
              ),
              alignment: Alignment.center,
              child: Text(
                '$dayNumber',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: summary?.hasActivity == true
                      ? Colors.white
                      : theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static String _dayKey(DateTime day) => '${day.year}-${day.month}-${day.day}';
}

class _CalendarLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final level in CalendarPerformanceLevel.values)
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 7,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: _levelColor(level),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  context.tr(_levelLabel(level)),
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _SelectedDayCard extends StatelessWidget {
  const _SelectedDayCard({required this.day, required this.summary});

  final DateTime day;
  final CalendarDaySummary? summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hasActivity = summary?.hasActivity == true;
    final level = summary?.level;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? theme.colorScheme.primaryContainer.withValues(alpha: .55)
            : theme.colorScheme.primaryContainer.withValues(alpha: .72),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: .14),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                hasActivity ? _levelSticker(level!) : '🗓️',
                style: const TextStyle(fontSize: 42),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      MaterialLocalizations.of(context).formatMediumDate(day),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      hasActivity
                          ? context.tr(_levelLabel(level!))
                          : context.tr('No habits logged'),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: hasActivity
                            ? _levelColor(level!)
                            : theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              if (hasActivity)
                Text(
                  summary!.score > 0
                      ? '+${summary!.score}'
                      : '${summary!.score}',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: _levelColor(level!),
                    fontWeight: FontWeight.w900,
                  ),
                ),
            ],
          ),
          if (hasActivity) ...[
            const SizedBox(height: 12),
            Text(
              context.tr('What you did'),
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            for (final activity in summary!.activities)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Icon(
                      activity.isUnwanted
                          ? Icons.remove_circle_rounded
                          : Icons.add_circle_rounded,
                      size: 20,
                      color: activity.isUnwanted
                          ? const Color(0xFFE85D5D)
                          : const Color(0xFF43A047),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        context.tr(activity.habitNameKey),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      '${activity.isUnwanted ? '−' : '+'}${activity.count}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

Color _levelColor(CalendarPerformanceLevel level) {
  return switch (level) {
    CalendarPerformanceLevel.terrible => const Color(0xFFE53935),
    CalendarPerformanceLevel.bad => const Color(0xFFFB8C00),
    CalendarPerformanceLevel.okay => const Color(0xFFFBC02D),
    CalendarPerformanceLevel.good => const Color(0xFF43A047),
    CalendarPerformanceLevel.excellent => const Color(0xFF1E88E5),
  };
}

String _levelLabel(CalendarPerformanceLevel level) {
  return switch (level) {
    CalendarPerformanceLevel.terrible => 'Terrible',
    CalendarPerformanceLevel.bad => 'Bad',
    CalendarPerformanceLevel.okay => 'OK',
    CalendarPerformanceLevel.good => 'Good',
    CalendarPerformanceLevel.excellent => 'Excellent',
  };
}

String _levelSticker(CalendarPerformanceLevel level) {
  return switch (level) {
    CalendarPerformanceLevel.terrible => '😣',
    CalendarPerformanceLevel.bad => '😕',
    CalendarPerformanceLevel.okay => '🙂',
    CalendarPerformanceLevel.good => '😊',
    CalendarPerformanceLevel.excellent => '🥳',
  };
}

bool _sameDay(DateTime first, DateTime second) {
  return first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}
