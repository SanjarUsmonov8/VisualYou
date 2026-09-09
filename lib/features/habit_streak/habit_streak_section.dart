import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:visualyou/data/habits/habit_repository.dart';
import 'package:visualyou/features/habit_streak/habit_streak_models.dart';
import 'package:visualyou/features/habit_streak/habit_streak_repository.dart';
import 'package:visualyou/features/rewards/premium_page.dart';
import 'package:visualyou/features/rewards/rewards_controller.dart';
import 'package:visualyou/features/rewards/rewards_models.dart';
import 'package:visualyou/l10n/app_strings.dart';

const habitStreakColors = <Color>[
  Color(0xFFE53935),
  Color(0xFFFB8C00),
  Color(0xFFFBC02D),
  Color(0xFF43A047),
  Color(0xFF00897B),
  Color(0xFF00ACC1),
  Color(0xFF1E88E5),
  Color(0xFF3949AB),
  Color(0xFF8E24AA),
  Color(0xFFD81B60),
];

class HabitStreakSection extends StatefulWidget {
  const HabitStreakSection({
    required this.repository,
    required this.habitRepository,
    required this.rewardsController,
    this.habitId,
    super.key,
  });

  final HabitStreakRepository repository;
  final HabitRepository habitRepository;
  final RewardsController rewardsController;
  final String? habitId;

  @override
  State<HabitStreakSection> createState() => _HabitStreakSectionState();
}

class _HabitStreakSectionState extends State<HabitStreakSection> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.rewardsController,
      builder: (context, _) => StreamBuilder<List<HabitStreakData>>(
        stream: widget.repository.watchStreaks(),
        builder: (context, snapshot) {
          final streaks = snapshot.data ?? const <HabitStreakData>[];
          final limit = _limit(widget.rewardsController.plan);
          final planVisible = limit == null
              ? streaks
              : streaks.take(limit).toList();
          final visible = widget.habitId == null
              ? planVisible
              : planVisible
                    .where((streak) => streak.habitId == widget.habitId)
                    .toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                context.tr('Habit streaks'),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 12),
              for (final streak in visible) ...[
                _HabitStreakCard(
                  streak: streak,
                  color: _streakColor(streak),
                  canChooseColor:
                      widget.rewardsController.plan != MembershipPlan.free,
                  onColor: () => _changeColor(streak),
                  onDelete: () => _delete(streak),
                  onDayPressed: (day) => _recordDay(streak, day),
                ),
                const SizedBox(height: 12),
              ],
              if (widget.habitId == null || visible.isEmpty)
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () =>
                        _addStreak(streaks, habitId: widget.habitId),
                    icon: const Icon(Icons.add_rounded),
                    label: Text(context.tr('Add habit streak')),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  int? _limit(MembershipPlan plan) => switch (plan) {
    MembershipPlan.free => 2,
    MembershipPlan.plus => 5,
    MembershipPlan.pro || MembershipPlan.ultra => null,
  };

  int _included(MembershipPlan plan) => switch (plan) {
    MembershipPlan.free => 0,
    MembershipPlan.plus => 3,
    MembershipPlan.pro || MembershipPlan.ultra => 1 << 30,
  };

  Color _streakColor(HabitStreakData streak) {
    if (widget.rewardsController.plan == MembershipPlan.free) {
      return Theme.of(context).colorScheme.primary;
    }
    return streak.colorValue == null
        ? Theme.of(context).colorScheme.primary
        : Color(streak.colorValue!);
  }

  Future<void> _addStreak(
    List<HabitStreakData> current, {
    String? habitId,
  }) async {
    final plan = widget.rewardsController.plan;
    final limit = _limit(plan);
    if (limit != null && current.length >= limit) {
      await openPremiumPlan(
        context,
        controller: widget.rewardsController,
        plan: plan == MembershipPlan.free
            ? MembershipPlan.plus
            : MembershipPlan.pro,
      );
      return;
    }
    final habits = await widget.repository.loadAvailableHabits();
    if (!mounted) return;
    final used = current.map((item) => item.habitId).toSet();
    final available = habits
        .where(
          (habit) =>
              !used.contains(habit.id) &&
              (habitId == null || habit.id == habitId),
        )
        .toList();
    if (available.isEmpty) {
      _message('No other active habits are available.');
      return;
    }
    final selection = await showDialog<_HabitStreakDraft>(
      context: context,
      builder: (_) => _HabitStreakDialog(
        habits: available,
        allowColor: plan != MembershipPlan.free,
      ),
    );
    if (selection == null || !mounted) return;

    final costsTokens = current.length >= _included(plan);
    if (costsTokens) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(context.tr('Create this habit streak?')),
          content: Text(context.tr('This habit streak requires 35 tokens.')),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(context.tr('Cancel')),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text('35 ${context.tr('Tokens')}'),
            ),
          ],
        ),
      );
      if (confirmed != true || !mounted) return;
      final paid = await widget.rewardsController.spend(
        35,
        'habit-streak-${selection.habitId}',
        chargePlus: true,
      );
      if (!paid) {
        _message('You need 35 tokens to create this habit streak.');
        return;
      }
    }
    await widget.repository.createStreak(
      selection.habitId,
      colorValue: plan == MembershipPlan.free
          ? null
          : selection.color.toARGB32(),
    );
  }

  Future<void> _changeColor(HabitStreakData streak) async {
    final color = await showDialog<Color>(
      context: context,
      builder: (_) => _ColorPickerDialog(initial: _streakColor(streak)),
    );
    if (color != null) {
      await widget.repository.updateColor(streak.habitId, color.toARGB32());
    }
  }

  Future<void> _delete(HabitStreakData streak) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.tr('Remove habit streak?')),
        content: Text(context.tr('Its streak setup will be removed.')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(context.tr('Cancel')),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(context.tr('Remove')),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await widget.repository.deleteStreak(streak.habitId);
    }
  }

  Future<void> _recordDay(HabitStreakData streak, DateTime day) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDay = DateTime(day.year, day.month, day.day);
    final startedOn = DateTime(
      streak.createdAt.year,
      streak.createdAt.month,
      streak.createdAt.day,
    );
    if (selectedDay.isAfter(today) || selectedDay.isBefore(startedOn)) return;

    final didHabit = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.tr('Did you do this habit?')),
        content: Text(context.tr(streak.habitNameKey)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(context.tr('I did not')),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(context.tr('I did')),
          ),
        ],
      ),
    );
    if (didHabit == null || !mounted) return;
    final occurredAt = DateTime(
      selectedDay.year,
      selectedDay.month,
      selectedDay.day,
      now.hour,
      now.minute,
      now.second,
      now.millisecond,
      now.microsecond,
    );
    try {
      await widget.habitRepository.recordHabit(
        streak.habitId,
        occurredAt: occurredAt,
        didHabit: didHabit,
      );
    } catch (_) {
      _message('Could not save habit offline');
    }
  }

  void _message(String key) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.tr(key))));
  }
}

class _HabitStreakCard extends StatefulWidget {
  const _HabitStreakCard({
    required this.streak,
    required this.color,
    required this.canChooseColor,
    required this.onColor,
    required this.onDelete,
    required this.onDayPressed,
  });

  final HabitStreakData streak;
  final Color color;
  final bool canChooseColor;
  final VoidCallback onColor;
  final VoidCallback onDelete;
  final ValueChanged<DateTime> onDayPressed;

  @override
  State<_HabitStreakCard> createState() => _HabitStreakCardState();
}

class _HabitStreakCardState extends State<_HabitStreakCard> {
  late DateTime _month;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _month = DateTime(now.year, now.month);
  }

  @override
  Widget build(BuildContext context) {
    final streak = widget.streak.currentStreak();
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.local_fire_department_rounded, color: widget.color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    context.tr(widget.streak.habitNameKey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
                Text(
                  '$streak ${context.tr(streak == 1 ? 'day' : 'days')}',
                  style: TextStyle(
                    color: widget.color,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                PopupMenuButton<_StreakAction>(
                  onSelected: (action) => switch (action) {
                    _StreakAction.color => widget.onColor(),
                    _StreakAction.delete => widget.onDelete(),
                  },
                  itemBuilder: (_) => [
                    if (widget.canChooseColor)
                      PopupMenuItem(
                        value: _StreakAction.color,
                        child: Text(context.tr('Choose streak color')),
                      ),
                    PopupMenuItem(
                      value: _StreakAction.delete,
                      child: Text(context.tr('Remove habit streak')),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => setState(
                    () => _month = DateTime(_month.year, _month.month - 1),
                  ),
                  icon: const Icon(Icons.chevron_left_rounded),
                ),
                Expanded(
                  child: Text(
                    MaterialLocalizations.of(context).formatMonthYear(_month),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final now = DateTime.now();
                    final next = DateTime(_month.year, _month.month + 1);
                    if (next.isAfter(DateTime(now.year, now.month))) return;
                    setState(() => _month = next);
                  },
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
            _HabitStreakMonth(
              month: _month,
              dayResults: widget.streak.dayResults,
              startedOn: widget.streak.createdAt,
              color: widget.color,
              onDayPressed: widget.onDayPressed,
            ),
          ],
        ),
      ),
    );
  }
}

enum _StreakAction { color, delete }

class _HabitStreakMonth extends StatelessWidget {
  const _HabitStreakMonth({
    required this.month,
    required this.dayResults,
    required this.startedOn,
    required this.color,
    required this.onDayPressed,
  });

  final DateTime month;
  final Map<DateTime, bool> dayResults;
  final DateTime startedOn;
  final Color color;
  final ValueChanged<DateTime> onDayPressed;

  @override
  Widget build(BuildContext context) {
    final first = DateTime(month.year, month.month);
    final leading = first.weekday - 1;
    final days = DateTime(month.year, month.month + 1, 0).day;
    final total = ((leading + days + 6) ~/ 7) * 7;
    return Column(
      children: [
        Row(
          children: [
            for (var day = 0; day < 7; day++)
              Expanded(
                child: Text(
                  MaterialLocalizations.of(context).narrowWeekdays[(day + 1) %
                      7],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
          ],
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final cell = constraints.maxWidth / 7;
            return SizedBox(
              height: cell * (total ~/ 7),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _HabitStreakPathPainter(
                        month: month,
                        leading: leading,
                        days: days,
                        successfulDays: {
                          for (final entry in dayResults.entries)
                            if (entry.value) entry.key,
                        },
                        color: color.withValues(alpha: .72),
                      ),
                    ),
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                        ),
                    itemCount: total,
                    itemBuilder: (context, index) {
                      final number = index - leading + 1;
                      if (number < 1 || number > days) return const SizedBox();
                      final day = DateTime(month.year, month.month, number);
                      final result = dayResults[day];
                      final success = result == true;
                      final before = day.isBefore(
                        DateTime(
                          startedOn.year,
                          startedOn.month,
                          startedOn.day,
                        ),
                      );
                      final now = DateTime.now();
                      final today = DateTime(now.year, now.month, now.day);
                      final future = day.isAfter(today);
                      final failed = !before &&
                          (result == false ||
                              (result == null && day.isBefore(today)));
                      return InkWell(
                        customBorder: const CircleBorder(),
                        onTap: before || future
                            ? null
                            : () => onDayPressed(day),
                        child: Center(
                          child: Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: success
                                  ? color
                                  : failed
                                  ? const Color(0xFFE53935)
                                  : Colors.transparent,
                            ),
                            child: Text(
                              '$number',
                              style: TextStyle(
                                color: success || failed
                                    ? Colors.white
                                    : before
                                    ? Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant
                                          .withValues(alpha: .35)
                                    : Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _HabitStreakPathPainter extends CustomPainter {
  const _HabitStreakPathPainter({
    required this.month,
    required this.leading,
    required this.days,
    required this.successfulDays,
    required this.color,
  });

  final DateTime month;
  final int leading;
  final int days;
  final Set<DateTime> successfulDays;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final cell = size.width / 7;
    final paint = Paint()
      ..color = color
      ..strokeWidth = math.min(32, cell)
      ..strokeCap = StrokeCap.butt;
    for (var number = 2; number <= days; number++) {
      final current = DateTime(month.year, month.month, number);
      final previous = current.subtract(const Duration(days: 1));
      if (!successfulDays.contains(current) ||
          !successfulDays.contains(previous)) {
        continue;
      }
      final index = leading + number - 1;
      final previousIndex = index - 1;
      if (index ~/ 7 != previousIndex ~/ 7) continue;
      final from = Offset(
        (previousIndex % 7 + .5) * cell,
        (previousIndex ~/ 7 + .5) * cell,
      );
      final to = Offset((index % 7 + .5) * cell, (index ~/ 7 + .5) * cell);
      canvas.drawLine(from, to, paint);
    }
  }

  @override
  bool shouldRepaint(_HabitStreakPathPainter oldDelegate) =>
      oldDelegate.month != month ||
      oldDelegate.successfulDays != successfulDays ||
      oldDelegate.color != color;
}

class _HabitStreakDraft {
  const _HabitStreakDraft(this.habitId, this.color);
  final String habitId;
  final Color color;
}

class _HabitStreakDialog extends StatefulWidget {
  const _HabitStreakDialog({required this.habits, required this.allowColor});
  final List<HabitStreakHabit> habits;
  final bool allowColor;

  @override
  State<_HabitStreakDialog> createState() => _HabitStreakDialogState();
}

class _HabitStreakDialogState extends State<_HabitStreakDialog> {
  late String _habitId;
  Color _color = habitStreakColors[6];

  @override
  void initState() {
    super.initState();
    _habitId = widget.habits.first.id;
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(context.tr('Add habit streak')),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButtonFormField<String>(
          initialValue: _habitId,
          decoration: InputDecoration(labelText: context.tr('Habit')),
          items: [
            for (final habit in widget.habits)
              DropdownMenuItem(
                value: habit.id,
                child: Text(context.tr(habit.nameKey)),
              ),
          ],
          onChanged: (value) {
            if (value != null) setState(() => _habitId = value);
          },
        ),
        if (widget.allowColor) ...[
          const SizedBox(height: 18),
          Text(context.tr('Choose streak color')),
          const SizedBox(height: 10),
          _ColorChoices(
            selected: _color,
            onSelected: (color) => setState(() => _color = color),
          ),
        ],
      ],
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(context.tr('Cancel')),
      ),
      FilledButton(
        onPressed: () =>
            Navigator.pop(context, _HabitStreakDraft(_habitId, _color)),
        child: Text(context.tr('Create')),
      ),
    ],
  );
}

class _ColorPickerDialog extends StatefulWidget {
  const _ColorPickerDialog({required this.initial});
  final Color initial;

  @override
  State<_ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<_ColorPickerDialog> {
  late Color _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initial;
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(context.tr('Choose streak color')),
    content: _ColorChoices(
      selected: _selected,
      onSelected: (color) => setState(() => _selected = color),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(context.tr('Cancel')),
      ),
      FilledButton(
        onPressed: () => Navigator.pop(context, _selected),
        child: Text(context.tr('Save')),
      ),
    ],
  );
}

class _ColorChoices extends StatelessWidget {
  const _ColorChoices({required this.selected, required this.onSelected});
  final Color selected;
  final ValueChanged<Color> onSelected;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 10,
    runSpacing: 10,
    children: [
      for (final color in habitStreakColors)
        InkWell(
          onTap: () => onSelected(color),
          customBorder: const CircleBorder(),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: color.toARGB32() == selected.toARGB32()
                ? const Icon(Icons.check_rounded, color: Colors.white)
                : null,
          ),
        ),
    ],
  );
}
