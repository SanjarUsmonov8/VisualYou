import 'package:flutter/material.dart';
import 'package:visualyou/features/reduction_calendar/reduction_calendar_models.dart';
import 'package:visualyou/features/reduction_calendar/reduction_calendar_repository.dart';
import 'package:visualyou/l10n/app_strings.dart';

class ReductionCalendar extends StatefulWidget {
  const ReductionCalendar({required this.repository, super.key});

  final ReductionCalendarRepository repository;

  @override
  State<ReductionCalendar> createState() => _ReductionCalendarState();
}

class _ReductionCalendarState extends State<ReductionCalendar> {
  late DateTime _visibleMonth;
  late Stream<List<ReductionCalendarData>> _monthStream;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _visibleMonth = DateTime(now.year, now.month);
    _monthStream = widget.repository.watchPlansMonth(_visibleMonth);
  }

  @override
  void didUpdateWidget(ReductionCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.repository != widget.repository) {
      _monthStream = widget.repository.watchPlansMonth(_visibleMonth);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark
        ? const Color(0xFF24272E)
        : const Color(0xFFF0F2F5);

    return StreamBuilder<List<ReductionCalendarData>>(
      stream: _monthStream,
      builder: (context, snapshot) {
        final plans = snapshot.data ?? const <ReductionCalendarData>[];

        Widget buildCard(ReductionCalendarData? plan) {
          return Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
            decoration: BoxDecoration(
              color: cardColor,
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
            child: plan == null
                ? _EmptyReductionPlan(
                    onCreate: () => _openEditor(context, activePlans: plans),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.tr('Gradual reduction'),
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  '${context.tr(plan.habitNameKey)} · ${context.tr(_modeLabel(plan.mode))}',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            tooltip: context.tr('Change plan'),
                            onPressed: () => _openEditor(
                              context,
                              activePlans: plans,
                              initialPlan: plan,
                            ),
                            icon: const Icon(Icons.tune_rounded),
                          ),
                        ],
                      ),
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
                              style: theme.textTheme.titleSmall?.copyWith(
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
                      _ReductionWeekdays(),
                      const SizedBox(height: 5),
                      _ReductionMonthGrid(
                        month: _visibleMonth,
                        plan: plan,
                        onDayTap: (day) => _askDayStatus(context, plan, day),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 11,
                        ),
                        decoration: BoxDecoration(
                          color: theme.brightness == Brightness.dark
                              ? theme.colorScheme.primaryContainer.withValues(
                                  alpha: .55,
                                )
                              : theme.colorScheme.primaryContainer.withValues(
                                  alpha: .72,
                                ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            const _ReductionLegend(),
                            const SizedBox(height: 8),
                            Text(
                              context.tr(
                                'Scheduled days are planned maximum-use checkpoints. Skipping or changing them is always okay.',
                              ),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (plan.habitId == 'alcohol') ...[
                              const SizedBox(height: 7),
                              Text(
                                context.tr(
                                  'If you may be dependent on alcohol, reducing or stopping suddenly can be dangerous. Seek medical support.',
                                ),
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.error,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        }

        return buildCard(plans.isEmpty ? null : plans.first);
      },
    );
  }

  void _changeMonth(int offset) {
    final next = DateTime(_visibleMonth.year, _visibleMonth.month + offset);
    setState(() {
      _visibleMonth = next;
      _monthStream = widget.repository.watchPlansMonth(next);
    });
  }

  Future<void> _openEditor(
    BuildContext context, {
    required List<ReductionCalendarData> activePlans,
    ReductionCalendarData? initialPlan,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => _ReductionPlanEditor(
        repository: widget.repository,
        initialPlan: initialPlan,
        unavailableHabitIds: {
          for (final plan in activePlans)
            if (plan.planId != initialPlan?.planId) plan.habitId,
        },
      ),
    );
  }

  Future<void> _askDayStatus(
    BuildContext context,
    ReductionCalendarData plan,
    DateTime day,
  ) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (day.isBefore(plan.startedOn) || day.isAfter(today)) return;
    final didHabit = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(MaterialLocalizations.of(context).formatFullDate(day)),
        content: Text(
          '${context.tr(plan.habitNameKey)}: ${context.tr('Did you do this habit?')}',
        ),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            icon: const Icon(Icons.close_rounded),
            label: Text(context.tr('I did not')),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            icon: const Icon(Icons.check_rounded),
            label: Text(context.tr('I did')),
          ),
        ],
      ),
    );
    if (didHabit == null) return;
    await widget.repository.setDayStatus(
      planId: plan.planId,
      day: day,
      didHabit: didHabit,
    );
  }
}

class _EmptyReductionPlan extends StatelessWidget {
  const _EmptyReductionPlan({required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        children: [
          Icon(
            Icons.route_rounded,
            size: 46,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 8),
          Text(
            context.tr('Gradual reduction'),
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Text(
            context.tr(
              'Create a custom calendar that spaces an unwanted habit farther apart over time.',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: onCreate,
            icon: const Icon(Icons.add_rounded),
            label: Text(context.tr('Create plan')),
          ),
        ],
      ),
    );
  }
}

class _ReductionWeekdays extends StatelessWidget {
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

class _ReductionMonthGrid extends StatelessWidget {
  const _ReductionMonthGrid({
    required this.month,
    required this.plan,
    required this.onDayTap,
  });

  final DateTime month;
  final ReductionCalendarData plan;
  final ValueChanged<DateTime> onDayTap;

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(month.year, month.month);
    final leading = firstDay.weekday - 1;
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final cells = leading + daysInMonth <= 35 ? 35 : 42;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cellSize = constraints.maxWidth / 7;
        final rows = cells ~/ 7;
        return SizedBox(
          height: cellSize * rows,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _ReductionPathPainter(
                    month: month,
                    plan: plan,
                    leading: leading,
                    daysInMonth: daysInMonth,
                    trackColor: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: .38),
                    futureColor: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: .12),
                  ),
                ),
              ),
              Positioned.fill(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: cells,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                  ),
                  itemBuilder: (context, index) {
                    final number = index - leading + 1;
                    if (number < 1 || number > daysInMonth) {
                      return const SizedBox.shrink();
                    }
                    final day = DateTime(month.year, month.month, number);
                    return _ReductionDayCircle(
                      day: day,
                      plan: plan,
                      onTap: () => onDayTap(day),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ReductionDayCircle extends StatelessWidget {
  const _ReductionDayCircle({
    required this.day,
    required this.plan,
    required this.onTap,
  });

  final DateTime day;
  final ReductionCalendarData plan;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final beforePlan = day.isBefore(plan.startedOn);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final isFuture = day.isAfter(today);
    final allowed = !beforePlan && isReductionAllowedDay(plan, day);
    final violation = !beforePlan && isReductionViolation(plan, day);
    final completedAllowedUse =
        !beforePlan && !violation && plan.countOn(day) > 0;
    final consumedScheduledSlot =
        !beforePlan && isFlexibleScheduledSlotConsumed(plan, day);
    final availableScheduledDay = allowed && !consumedScheduledSlot;
    final color = beforePlan
        ? theme.colorScheme.surfaceContainerHighest
        : violation
        ? const Color(0xFFE53935)
        : availableScheduledDay || completedAllowedUse
        ? theme.colorScheme.primary
        : theme.colorScheme.primaryContainer;
    final textColor = availableScheduledDay || completedAllowedUse || violation
        ? Colors.white
        : beforePlan
        ? theme.colorScheme.onSurfaceVariant
        : theme.colorScheme.onPrimaryContainer;

    return Center(
      child: InkWell(
        onTap: beforePlan || isFuture ? null : onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              if (availableScheduledDay || completedAllowedUse)
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: .3),
                  blurRadius: 8,
                ),
            ],
          ),
          alignment: Alignment.center,
          child: completedAllowedUse
              ? Icon(Icons.check_rounded, color: textColor, size: 21)
              : Text(
                  '${day.day}',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
        ),
      ),
    );
  }
}

class _ReductionPathPainter extends CustomPainter {
  const _ReductionPathPainter({
    required this.month,
    required this.plan,
    required this.leading,
    required this.daysInMonth,
    required this.trackColor,
    required this.futureColor,
  });

  final DateTime month;
  final ReductionCalendarData plan;
  final int leading;
  final int daysInMonth;
  final Color trackColor;
  final Color futureColor;

  @override
  void paint(Canvas canvas, Size size) {
    final cell = size.width / 7;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    Offset centerFor(int dayNumber) {
      final index = leading + dayNumber - 1;
      return Offset((index % 7 + .5) * cell, (index ~/ 7 + .5) * cell);
    }

    DateTime dateFor(int number) => DateTime(month.year, month.month, number);

    bool isConnectedDay(int number) {
      if (number < 1 || number > daysInMonth) return false;
      final day = dateFor(number);
      if (day.isBefore(plan.startedOn)) return false;
      return !isReductionViolation(plan, day);
    }

    Paint paintFor(DateTime day) {
      return Paint()
        ..color = day.isAfter(today) ? futureColor : trackColor
        ..strokeWidth = 34
        ..strokeCap = StrokeCap.butt
        ..style = PaintingStyle.stroke;
    }

    for (var number = 1; number <= daysInMonth; number++) {
      if (!isConnectedDay(number)) continue;
      final index = leading + number - 1;
      final column = index % 7;
      final center = centerFor(number);

      if (column > 0 && isConnectedDay(number - 1)) {
        canvas.drawLine(
          centerFor(number - 1),
          center,
          paintFor(dateFor(number)),
        );
      }

      // Week rows stop and restart at flat screen-edge caps. There is no
      // wraparound connector between the right and left sides.
      if (column == 0 && isConnectedDay(number - 1)) {
        canvas.drawLine(
          Offset(0, center.dy),
          center,
          paintFor(dateFor(number)),
        );
      }
      if (column == 6 && isConnectedDay(number + 1)) {
        canvas.drawLine(
          center,
          Offset(size.width, center.dy),
          paintFor(dateFor(number)),
        );
      }
    }
  }

  @override
  bool shouldRepaint(_ReductionPathPainter oldDelegate) {
    return oldDelegate.month != month ||
        oldDelegate.plan != plan ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.futureColor != futureColor;
  }
}

class _ReductionLegend extends StatelessWidget {
  const _ReductionLegend();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      children: [
        _LegendDot(color: colors.primaryContainer, label: 'Stay free'),
        _LegendDot(color: colors.primary, label: 'Scheduled day'),
        const _LegendDot(color: Color(0xFFE53935), label: 'Off-plan use'),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              context.tr(label),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReductionPlanEditor extends StatefulWidget {
  const _ReductionPlanEditor({
    required this.repository,
    required this.unavailableHabitIds,
    this.initialPlan,
  });

  final ReductionCalendarRepository repository;
  final Set<String> unavailableHabitIds;
  final ReductionCalendarData? initialPlan;

  @override
  State<_ReductionPlanEditor> createState() => _ReductionPlanEditorState();
}

class _ReductionPlanEditorState extends State<_ReductionPlanEditor> {
  late Future<List<ReductionHabit>> _habits;
  String? _selectedHabitId;
  late String _selectedMode;
  late DateTime _selectedStartDate;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _habits = widget.repository.loadUnwantedHabits();
    _selectedHabitId = widget.initialPlan?.habitId;
    _selectedMode = widget.initialPlan?.mode ?? 'hard';
    final initialDate = widget.initialPlan?.startedOn ?? DateTime.now();
    _selectedStartDate = DateTime(
      initialDate.year,
      initialDate.month,
      initialDate.day,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        18,
        12,
        18,
        MediaQuery.viewInsetsOf(context).bottom + 18,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr(
                widget.initialPlan == null
                    ? 'Create reduction plan'
                    : 'Change reduction plan',
              ),
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 14),
            FutureBuilder<List<ReductionHabit>>(
              future: _habits,
              builder: (context, snapshot) {
                final habits = snapshot.data;
                if (habits == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                final availableHabits = habits
                    .where(
                      (habit) => !widget.unavailableHabitIds.contains(habit.id),
                    )
                    .toList();
                if (availableHabits.isEmpty) {
                  return Text(context.tr('No unwanted habits available'));
                }
                return DropdownButtonFormField<String>(
                  initialValue: _selectedHabitId,
                  decoration: InputDecoration(
                    labelText: context.tr('Choose unwanted habit'),
                    border: const OutlineInputBorder(),
                  ),
                  items: [
                    for (final habit in availableHabits)
                      DropdownMenuItem(
                        value: habit.id,
                        child: Text(context.tr(habit.nameKey)),
                      ),
                  ],
                  onChanged: (value) =>
                      setState(() => _selectedHabitId = value),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              context.tr('Start date'),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _pickStartDate,
                icon: const Icon(Icons.event_rounded),
                label: Text(
                  MaterialLocalizations.of(
                    context,
                  ).formatFullDate(_selectedStartDate),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              context.tr('Quit method'),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            _ModeTile(
              title: context.tr('Hard'),
              description: context.tr(
                'Starts today, then spaces checkpoints by 2, 3, 4, 5 days and progressively farther apart.',
              ),
              selected: _selectedMode == 'hard',
              onTap: () => setState(() => _selectedMode = 'hard'),
            ),
            const SizedBox(height: 8),
            _ModeTile(
              title: context.tr('Medium'),
              description: context.tr(
                'Repeats each gap as many times as its day number, with allowed windows that become smaller again at long intervals.',
              ),
              selected: _selectedMode == 'medium',
              onTap: () => setState(() => _selectedMode = 'medium'),
            ),
            const SizedBox(height: 8),
            _ModeTile(
              title: context.tr('Easy'),
              description: context.tr(
                'Starts with five allowed days, then reduces gradually with longer repeated cycles.',
              ),
              selected: _selectedMode == 'easy',
              onTap: () => setState(() => _selectedMode = 'easy'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _selectedHabitId == null || _saving
                    ? null
                    : _createPlan,
                icon: _saving
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.route_rounded),
                label: Text(context.tr('Start plan')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createPlan() async {
    if (widget.initialPlan != null) {
      final confirmed = await _confirmPlanChange();
      if (!confirmed || !mounted) return;
    }
    setState(() => _saving = true);
    switch (_selectedMode) {
      case 'easy':
        await widget.repository.createEasyPlan(
          habitId: _selectedHabitId!,
          startedOn: _selectedStartDate,
        );
      case 'medium':
        await widget.repository.createMediumPlan(
          habitId: _selectedHabitId!,
          startedOn: _selectedStartDate,
        );
      default:
        await widget.repository.createHardPlan(
          habitId: _selectedHabitId!,
          startedOn: _selectedStartDate,
        );
    }
    if (mounted) Navigator.of(context).pop();
  }

  Future<bool> _confirmPlanChange() async {
    return await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(context.tr('Change this reduction plan?')),
            content: Text(
              context.tr(
                'Changing it will replace this habit’s current schedule and start date.',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(context.tr('Cancel')),
              ),
              FilledButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(context.tr('Change plan')),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: context.tr('Choose tracker start date'),
    );
    if (picked != null && mounted) {
      setState(() => _selectedStartDate = picked);
    }
  }
}

class _ModeTile extends StatelessWidget {
  const _ModeTile({
    required this.title,
    required this.description,
    required this.selected,
    this.onTap,
  });

  final String title;
  final String description;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected
              ? colors.primaryContainer
              : colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
          border: selected ? Border.all(color: colors.primary, width: 2) : null,
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color: selected ? colors.primary : colors.onSurfaceVariant,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool isHardCheckpoint(DateTime startedOn, DateTime day) {
  final start = DateTime(startedOn.year, startedOn.month, startedOn.day);
  final target = DateTime(day.year, day.month, day.day);
  final offset = target.difference(start).inDays;
  if (offset < 0) return false;
  var checkpoint = 0;
  var gap = 2;
  while (checkpoint < offset) {
    checkpoint += gap;
    gap++;
  }
  return checkpoint == offset;
}

bool isMediumAllowedDay(DateTime startedOn, DateTime day) {
  final cycle = mediumReductionCycleForDay(startedOn, day);
  return cycle?.isScheduled(day) ?? false;
}

class MediumReductionCycle {
  const MediumReductionCycle({
    required this.startsOn,
    required this.scheduledFrom,
    required this.fixedDay,
    required this.allowedDays,
  });

  final DateTime startsOn;
  final DateTime scheduledFrom;
  final DateTime fixedDay;
  final int allowedDays;

  int get movableDays => allowedDays - 1;

  bool contains(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);
    return !normalized.isBefore(startsOn) && !normalized.isAfter(fixedDay);
  }

  bool isScheduled(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);
    return !normalized.isBefore(scheduledFrom) && !normalized.isAfter(fixedDay);
  }

  bool isFixed(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);
    return normalized == fixedDay;
  }
}

MediumReductionCycle? mediumReductionCycleForDay(
  DateTime startedOn,
  DateTime day,
) {
  final start = DateTime(startedOn.year, startedOn.month, startedOn.day);
  final target = DateTime(day.year, day.month, day.day);
  final offset = target.difference(start).inDays;
  if (offset < 0) return null;
  if (offset <= 1) {
    return MediumReductionCycle(
      startsOn: start,
      scheduledFrom: start,
      fixedDay: start.add(const Duration(days: 1)),
      allowedDays: 2,
    );
  }

  var lastAllowedOffset = 1;
  var gapDays = 2;
  while (true) {
    final allowedDays = mediumAllowedDaysForGap(gapDays);
    for (var repetition = 0; repetition < gapDays; repetition++) {
      final cycleStart = lastAllowedOffset + 1;
      final windowStart = lastAllowedOffset + gapDays;
      final windowEnd = windowStart + allowedDays - 1;
      if (offset <= windowEnd) {
        return MediumReductionCycle(
          startsOn: start.add(Duration(days: cycleStart)),
          scheduledFrom: start.add(Duration(days: windowStart)),
          fixedDay: start.add(Duration(days: windowEnd)),
          allowedDays: allowedDays,
        );
      }
      lastAllowedOffset = windowEnd;
    }
    gapDays++;
  }
}

int mediumAllowedDaysForGap(int gapDays) {
  return switch (gapDays) {
    <= 2 => 1,
    <= 9 => 2,
    <= 19 => 3,
    <= 49 => 4,
    <= 69 => 3,
    <= 99 => 2,
    _ => 1,
  };
}

bool isEasyAllowedDay(DateTime startedOn, DateTime day) {
  final cycle = easyReductionCycleForDay(startedOn, day);
  return cycle?.isScheduled(day) ?? false;
}

MediumReductionCycle? easyReductionCycleForDay(
  DateTime startedOn,
  DateTime day,
) {
  final start = DateTime(startedOn.year, startedOn.month, startedOn.day);
  final target = DateTime(day.year, day.month, day.day);
  final offset = target.difference(start).inDays;
  if (offset < 0) return null;
  if (offset <= 4) {
    return MediumReductionCycle(
      startsOn: start,
      scheduledFrom: start,
      fixedDay: start.add(const Duration(days: 4)),
      allowedDays: 5,
    );
  }

  var lastAllowedOffset = 4;
  var gapDays = 2;
  while (true) {
    final allowedDays = easyAllowedDaysForGap(gapDays);
    for (var repetition = 0; repetition < gapDays; repetition++) {
      final cycleStart = lastAllowedOffset + 1;
      final windowStart = lastAllowedOffset + gapDays;
      final windowEnd = windowStart + allowedDays - 1;
      if (offset <= windowEnd) {
        return MediumReductionCycle(
          startsOn: start.add(Duration(days: cycleStart)),
          scheduledFrom: start.add(Duration(days: windowStart)),
          fixedDay: start.add(Duration(days: windowEnd)),
          allowedDays: allowedDays,
        );
      }
      lastAllowedOffset = windowEnd;
    }
    gapDays++;
  }
}

int easyAllowedDaysForGap(int gapDays) {
  return switch (gapDays) {
    <= 5 => 4,
    <= 11 => 3,
    _ => mediumAllowedDaysForGap(gapDays),
  };
}

bool isReductionAllowedDay(ReductionCalendarData plan, DateTime day) {
  return switch (plan.mode) {
    'medium' => isMediumAllowedDay(plan.startedOn, day),
    'easy' => isEasyAllowedDay(plan.startedOn, day),
    _ => isHardCheckpoint(plan.startedOn, day),
  };
}

bool isReductionViolation(ReductionCalendarData plan, DateTime day) {
  final count = plan.countOn(day);
  if (count == 0) return false;
  if (plan.mode == 'medium' || plan.mode == 'easy') {
    return isFlexibleCycleViolation(plan, day);
  }
  return !isReductionAllowedDay(plan, day) || count > 1;
}

bool isFlexibleCycleViolation(ReductionCalendarData plan, DateTime day) {
  final cycle = _flexibleCycleForPlan(plan, day);
  if (cycle == null || !cycle.contains(day)) return true;
  if (plan.countOn(day) > 1) return true;
  if (cycle.isFixed(day)) return false;

  var usedMovableDays = 0;
  for (final entry in plan.logCounts.entries) {
    final loggedDay = DateTime(entry.key.year, entry.key.month, entry.key.day);
    if (entry.value > 0 &&
        !loggedDay.isBefore(cycle.startsOn) &&
        loggedDay.isBefore(cycle.fixedDay) &&
        !loggedDay.isAfter(day)) {
      usedMovableDays++;
    }
  }
  return usedMovableDays > cycle.movableDays;
}

bool isFlexibleScheduledSlotConsumed(ReductionCalendarData plan, DateTime day) {
  final cycle = _flexibleCycleForPlan(plan, day);
  if (cycle == null ||
      !cycle.isScheduled(day) ||
      cycle.isFixed(day) ||
      plan.countOn(day) > 0) {
    return false;
  }

  var substitutedUses = 0;
  for (final entry in plan.logCounts.entries) {
    final loggedDay = DateTime(entry.key.year, entry.key.month, entry.key.day);
    if (entry.value > 0 &&
        cycle.contains(loggedDay) &&
        loggedDay.isBefore(cycle.fixedDay) &&
        !cycle.isScheduled(loggedDay)) {
      substitutedUses++;
    }
  }

  var unfilledSlotIndex = 0;
  for (
    var scheduledDay = cycle.scheduledFrom;
    scheduledDay.isBefore(cycle.fixedDay);
    scheduledDay = scheduledDay.add(const Duration(days: 1))
  ) {
    if (plan.countOn(scheduledDay) > 0) continue;
    if (scheduledDay == DateTime(day.year, day.month, day.day)) {
      return unfilledSlotIndex < substitutedUses;
    }
    unfilledSlotIndex++;
  }
  return false;
}

bool isMediumScheduledSlotConsumed(ReductionCalendarData plan, DateTime day) {
  return isFlexibleScheduledSlotConsumed(plan, day);
}

MediumReductionCycle? _flexibleCycleForPlan(
  ReductionCalendarData plan,
  DateTime day,
) {
  return switch (plan.mode) {
    'medium' => mediumReductionCycleForDay(plan.startedOn, day),
    'easy' => easyReductionCycleForDay(plan.startedOn, day),
    _ => null,
  };
}

String _modeLabel(String mode) {
  return switch (mode) {
    'medium' => 'Medium',
    'easy' => 'Easy',
    _ => 'Hard',
  };
}
