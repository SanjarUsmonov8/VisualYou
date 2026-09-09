import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:visualyou/features/growth_calendar/growth_calendar_models.dart';
import 'package:visualyou/features/growth_calendar/growth_calendar_repository.dart';
import 'package:visualyou/features/rewards/habit_access.dart';
import 'package:visualyou/features/rewards/premium_page.dart';
import 'package:visualyou/features/rewards/rewards_controller.dart';
import 'package:visualyou/features/rewards/rewards_models.dart';
import 'package:visualyou/features/rewards/rewards_widgets.dart';
import 'package:visualyou/l10n/app_strings.dart';
import 'package:visualyou/widgets/sheet_dismiss_handle.dart';

class GrowthCalendar extends StatefulWidget {
  const GrowthCalendar({
    required this.repository,
    required this.rewardsController,
    super.key,
  });

  final GrowthCalendarRepository repository;
  final RewardsController rewardsController;

  @override
  State<GrowthCalendar> createState() => _GrowthCalendarState();
}

class _GrowthCalendarState extends State<GrowthCalendar> {
  late DateTime _month;
  late Stream<List<GrowthCalendarData>> _plans;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _month = DateTime(now.year, now.month);
    _plans = widget.repository.watchPlansMonth(_month);
  }

  @override
  void didUpdateWidget(covariant GrowthCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.repository != widget.repository) {
      _plans = widget.repository.watchPlansMonth(_month);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<GrowthCalendarData>>(
      stream: _plans,
      builder: (context, snapshot) {
        final plans = snapshot.data ?? const <GrowthCalendarData>[];
        final limit = widget.rewardsController.growthPlanLimit;
        final visible = plans.take(limit).toList();
        return Column(
          children: [
            for (var index = 0; index < visible.length; index++) ...[
              if (index > 0) const SizedBox(height: 12),
              _GrowthPlanCard(
                plan: visible[index],
                month: _month,
                onMonthChanged: _changeMonth,
                onEdit: () => _openEditor(plans, initial: visible[index]),
                onDayTap: _setDayCount,
                gate: _slotGate(index),
                gateCost: 70,
                rewardsController: widget.rewardsController,
              ),
            ],
            if (visible.length < limit) ...[
              if (visible.isNotEmpty) const SizedBox(height: 12),
              _GrowthEmptyCard(
                gate: _slotGate(visible.length),
                rewardsController: widget.rewardsController,
                onCreate: () => _openEditor(plans),
              ),
            ],
            if (!widget.rewardsController.isUltra) ...[
              const SizedBox(height: 10),
              UpgradePlanButton(
                controller: widget.rewardsController,
                targetPlan:
                    nextMembershipPlan(widget.rewardsController.plan) ??
                    MembershipPlan.ultra,
                label: context.tr('Unlock more growth plans'),
                icon: Icons.lock_outline_rounded,
              ),
            ],
          ],
        );
      },
    );
  }

  GatedFeature? _slotGate(int index) => switch (widget.rewardsController.plan) {
    MembershipPlan.free => null,
    MembershipPlan.plus when index >= 1 => GatedFeature.extraPlusGrowthPlans,
    MembershipPlan.pro when index >= 3 => GatedFeature.extraProGrowthPlans,
    _ => null,
  };

  void _changeMonth(int offset) {
    setState(() {
      _month = DateTime(_month.year, _month.month + offset);
      _plans = widget.repository.watchPlansMonth(_month);
    });
  }

  Future<void> _openEditor(
    List<GrowthCalendarData> plans, {
    GrowthCalendarData? initial,
  }) async {
    final index = initial == null
        ? plans.length
        : plans.indexWhere((plan) => plan.planId == initial.planId);
    final gate = _slotGate(math.max(0, index));
    if (gate != null &&
        !widget.rewardsController.isPaidExtensionUnlocked(gate)) {
      final paid = await confirmTokenOrAdPurchase(
        context,
        controller: widget.rewardsController,
        amount: 70,
        reason: 'unlock-${gate.name}',
        title: context.tr('Unlock these gradual-growth plans for 7 days?'),
        chargePlus: true,
      );
      if (!paid || !mounted) return;
      await widget.rewardsController.repository.unlockFeatureAfterPayment(gate);
      await widget.rewardsController.refresh();
    }
    if (!mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _GrowthPlanEditor(
        repository: widget.repository,
        rewardsController: widget.rewardsController,
        initial: initial,
        unavailableHabitIds: {
          for (final plan in plans)
            if (plan.planId != initial?.planId) plan.habitId,
        },
      ),
    );
  }

  Future<void> _setDayCount(GrowthCalendarData plan, DateTime day) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (day.isBefore(plan.startedOn) || day.isAfter(today)) return;
    final target = plan.targetOn(day);
    if (!target.scheduled) return;
    final amountStep = plan.measurementUnit == GrowthMeasurementUnit.minutes
        ? 5
        : 1;
    final maximum = plan.measurementUnit == GrowthMeasurementUnit.minutes
        ? 1440
        : 99;
    var selected = plan.completedOn(day).clamp(0, maximum);
    final result = await showDialog<int>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(context.tr(plan.habitNameKey)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.tr(
                  plan.measurementUnit == GrowthMeasurementUnit.minutes
                      ? 'How long did you do this habit?'
                      : 'How many repetitions did you complete?',
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.filledTonal(
                    onPressed: selected == 0
                        ? null
                        : () => setDialogState(
                            () => selected = math.max(0, selected - amountStep),
                          ),
                    icon: const Icon(Icons.remove_rounded),
                  ),
                  SizedBox(
                    width: 86,
                    child: Text(
                      _growthAmountLabel(
                        context,
                        selected,
                        plan.measurementUnit,
                      ),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  IconButton.filledTonal(
                    onPressed: selected >= maximum
                        ? null
                        : () => setDialogState(
                            () => selected = math.min(
                              maximum,
                              selected + amountStep,
                            ),
                          ),
                    icon: const Icon(Icons.add_rounded),
                  ),
                ],
              ),
              Text(
                '${context.tr('Target')}: ${_growthAmountLabel(context, target.repetitions, plan.measurementUnit)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(context.tr('Cancel')),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, selected),
              child: Text(context.tr('Save')),
            ),
          ],
        ),
      ),
    );
    if (result == null) return;
    await widget.repository.setDayCount(
      planId: plan.planId,
      day: day,
      completedCount: result,
    );
  }
}

class _GrowthPlanCard extends StatelessWidget {
  const _GrowthPlanCard({
    required this.plan,
    required this.month,
    required this.onMonthChanged,
    required this.onEdit,
    required this.onDayTap,
    required this.gate,
    required this.gateCost,
    required this.rewardsController,
  });

  final GrowthCalendarData plan;
  final DateTime month;
  final ValueChanged<int> onMonthChanged;
  final VoidCallback onEdit;
  final void Function(GrowthCalendarData, DateTime) onDayTap;
  final GatedFeature? gate;
  final int gateCost;
  final RewardsController rewardsController;

  @override
  Widget build(BuildContext context) {
    final locked =
        gate != null && !rewardsController.isPaidExtensionUnlocked(gate!);
    return _GrowthSurface(
      child: Stack(
        children: [
          AbsorbPointer(
            absorbing: locked,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.tr('Gradual growth'),
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w900),
                          ),
                          Text(
                            '${context.tr(plan.habitNameKey)} · ${context.tr(_growthModeName(plan.mode))} · ${plan.targetDaysPerWeek}× ${context.tr('per week')}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: locked ? null : onEdit,
                      icon: const Icon(Icons.tune_rounded),
                    ),
                  ],
                ),
                _MonthHeader(month: month, onChanged: onMonthChanged),
                const _WeekdayHeader(),
                _GrowthMonthGrid(plan: plan, month: month, onTap: onDayTap),
                const SizedBox(height: 10),
                Text(
                  context.tr(
                    'The plan first grows your active days, then builds your daily target.',
                  ),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          if (gate != null)
            Positioned(
              top: 0,
              left: 0,
              child: TokenChip(amount: gateCost, compact: true),
            ),
          if (locked)
            Positioned.fill(
              child: Center(
                child: FilledButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.lock_open_rounded),
                  label: Text(context.tr('Unlock for 7 days')),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _GrowthEmptyCard extends StatelessWidget {
  const _GrowthEmptyCard({
    required this.gate,
    required this.rewardsController,
    required this.onCreate,
  });

  final GatedFeature? gate;
  final RewardsController rewardsController;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final locked =
        gate != null && !rewardsController.isPaidExtensionUnlocked(gate!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (gate != null) ...[
          const Align(
            alignment: Alignment.centerLeft,
            child: TokenChip(amount: 70, compact: true),
          ),
          const SizedBox(height: 7),
        ],
        FilledButton.icon(
          onPressed: onCreate,
          icon: Icon(locked ? Icons.lock_open_rounded : Icons.add_rounded),
          label: Text(
            context.tr(
              locked ? 'Unlock and create growth plan' : 'Create growth plan',
            ),
          ),
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ],
    );
  }
}

class _GrowthSurface extends StatelessWidget {
  const _GrowthSurface({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF24272E) : const Color(0xFFF0F2F5),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          if (!dark)
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: .14),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
        ],
      ),
      child: child,
    );
  }
}

class _MonthHeader extends StatelessWidget {
  const _MonthHeader({required this.month, required this.onChanged});
  final DateTime month;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      IconButton(
        onPressed: () => onChanged(-1),
        icon: const Icon(Icons.chevron_left_rounded),
      ),
      Expanded(
        child: Text(
          MaterialLocalizations.of(context).formatMonthYear(month),
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      IconButton(
        onPressed: () => onChanged(1),
        icon: const Icon(Icons.chevron_right_rounded),
      ),
    ],
  );
}

class _WeekdayHeader extends StatelessWidget {
  const _WeekdayHeader();

  @override
  Widget build(BuildContext context) {
    final labels = MaterialLocalizations.of(context).narrowWeekdays;
    return Row(
      children: [
        for (var index = 0; index < 7; index++)
          Expanded(
            child: Text(
              labels[(index + 1) % 7],
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
      ],
    );
  }
}

class _GrowthMonthGrid extends StatelessWidget {
  const _GrowthMonthGrid({
    required this.plan,
    required this.month,
    required this.onTap,
  });
  final GrowthCalendarData plan;
  final DateTime month;
  final void Function(GrowthCalendarData, DateTime) onTap;

  @override
  Widget build(BuildContext context) {
    final first = DateTime(month.year, month.month);
    final days = DateTime(month.year, month.month + 1, 0).day;
    final leading = first.weekday - 1;
    final total = ((leading + days + 6) ~/ 7) * 7;
    return LayoutBuilder(
      builder: (context, constraints) {
        final cell = constraints.maxWidth / 7;
        return SizedBox(
          height: cell * (total ~/ 7),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _GrowthPathPainter(
                    month: month,
                    plan: plan,
                    leading: leading,
                    daysInMonth: days,
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: .4),
                  ),
                ),
              ),
              Positioned.fill(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                  ),
                  itemCount: total,
                  itemBuilder: (context, index) {
                    final number = index - leading + 1;
                    if (number < 1 || number > days) {
                      return const SizedBox.shrink();
                    }
                    final day = DateTime(month.year, month.month, number);
                    return _GrowthDayCircle(
                      day: day,
                      plan: plan,
                      onTap: () => onTap(plan, day),
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

class _GrowthDayCircle extends StatelessWidget {
  const _GrowthDayCircle({
    required this.day,
    required this.plan,
    required this.onTap,
  });

  final DateTime day;
  final GrowthCalendarData plan;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final target = plan.targetOn(day);
    final completed = plan.completedOn(day);
    final done = target.scheduled && completed >= target.repetitions;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final missed = target.scheduled && day.isBefore(today) && !done;
    final beforePlan = day.isBefore(plan.startedOn);
    final future = day.isAfter(today);
    final colors = Theme.of(context).colorScheme;
    final background = beforePlan
        ? colors.surfaceContainerHighest
        : missed
        ? const Color(0xFFE53935)
        : done
        ? colors.primary
        : target.scheduled
        ? colors.primaryContainer
        : Colors.transparent;
    final foreground = missed || done
        ? Colors.white
        : target.scheduled
        ? colors.onPrimaryContainer
        : colors.onSurfaceVariant;

    return Center(
      child: InkWell(
        onTap: beforePlan || future || !target.scheduled ? null : onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(color: background, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: done
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      '${day.day}',
                      style: TextStyle(
                        color: foreground.withValues(alpha: .18),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Icon(Icons.check_rounded, color: foreground, size: 22),
                  ],
                )
              : target.scheduled
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${day.day}',
                      style: TextStyle(
                        color: foreground,
                        height: .95,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      _growthAmountLabel(
                        context,
                        target.repetitions,
                        plan.measurementUnit,
                        compact: true,
                      ),
                      style: TextStyle(
                        color: foreground,
                        height: .95,
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                )
              : Text('${day.day}', style: TextStyle(color: foreground)),
        ),
      ),
    );
  }
}

class _GrowthPathPainter extends CustomPainter {
  const _GrowthPathPainter({
    required this.month,
    required this.plan,
    required this.leading,
    required this.daysInMonth,
    required this.color,
  });

  final DateTime month;
  final GrowthCalendarData plan;
  final int leading;
  final int daysInMonth;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final cell = size.width / 7;
    Offset center(int number) {
      final index = leading + number - 1;
      return Offset((index % 7 + .5) * cell, (index ~/ 7 + .5) * cell);
    }

    DateTime date(int number) => DateTime(month.year, month.month, number);
    bool success(int number) {
      if (number < 1 || number > daysInMonth) return false;
      final day = date(number);
      final target = plan.targetOn(day);
      return target.scheduled &&
          plan.completedOn(day) >= target.repetitions &&
          target.repetitions > 0;
    }

    int? previousScheduled(int number) {
      for (var candidate = number - 1; candidate >= 1; candidate--) {
        if (plan.targetOn(date(candidate)).scheduled) return candidate;
      }
      return null;
    }

    final paint = Paint()
      ..color = color
      ..strokeWidth = 34
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;
    for (var number = 1; number <= daysInMonth; number++) {
      if (!success(number)) continue;
      final previous = previousScheduled(number);
      if (previous == null || !success(previous)) continue;
      final currentIndex = leading + number - 1;
      final previousIndex = leading + previous - 1;
      if (currentIndex ~/ 7 == previousIndex ~/ 7) {
        canvas.drawLine(center(previous), center(number), paint);
      } else {
        canvas.drawLine(
          center(previous),
          Offset(size.width, center(previous).dy),
          paint,
        );
        canvas.drawLine(Offset(0, center(number).dy), center(number), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_GrowthPathPainter oldDelegate) =>
      oldDelegate.month != month ||
      oldDelegate.plan != plan ||
      oldDelegate.color != color;
}

class _GrowthPlanEditor extends StatefulWidget {
  const _GrowthPlanEditor({
    required this.repository,
    required this.rewardsController,
    required this.unavailableHabitIds,
    this.initial,
  });

  final GrowthCalendarRepository repository;
  final RewardsController rewardsController;
  final Set<String> unavailableHabitIds;
  final GrowthCalendarData? initial;

  @override
  State<_GrowthPlanEditor> createState() => _GrowthPlanEditorState();
}

class _GrowthPlanEditorState extends State<_GrowthPlanEditor> {
  late Future<List<GrowthHabit>> _habits;
  String? _habitId;
  late GrowthMode _mode;
  late DateTime _start;
  late int _repetitions;
  late GrowthMeasurementUnit _measurementUnit;
  late Set<int> _habitDays;
  late Map<int, int> _weekdayRepetitions;
  late bool _customWeekdayTargetsEnabled;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final plan = widget.initial;
    _habits = widget.repository.loadGoodHabits();
    _habitId = plan?.habitId;
    _mode = plan?.mode ?? GrowthMode.fast;
    _start = plan?.startedOn ?? DateTime.now();
    _repetitions = plan?.targetRepetitionsPerDay ?? 1;
    _measurementUnit = plan?.measurementUnit ?? GrowthMeasurementUnit.times;
    _habitDays = plan == null
        ? {DateTime.monday, DateTime.wednesday, DateTime.friday}
        : _storedHabitDays(plan);
    _weekdayRepetitions = {...?plan?.weekdayRepetitions};
    _customWeekdayTargetsEnabled = _weekdayRepetitions.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(
        18,
        10,
        18,
        MediaQuery.viewInsetsOf(context).bottom + 18,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SheetDismissHandle(),
            Text(
              context.tr(
                widget.initial == null
                    ? 'Create growth plan'
                    : 'Change growth plan',
              ),
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 14),
            FutureBuilder<List<GrowthHabit>>(
              future: _habits,
              builder: (context, snapshot) {
                final habits = (snapshot.data ?? const <GrowthHabit>[])
                    .where(
                      (habit) =>
                          habit.id == _habitId ||
                          (!widget.unavailableHabitIds.contains(habit.id) &&
                              planCanUseHabit(
                                widget.rewardsController.plan,
                                habit.id,
                              )),
                    )
                    .toList();
                return DropdownButtonFormField<String>(
                  initialValue: _habitId,
                  decoration: InputDecoration(
                    labelText: context.tr('Choose good habit'),
                    border: const OutlineInputBorder(),
                  ),
                  items: [
                    for (final habit in habits)
                      DropdownMenuItem(
                        value: habit.id,
                        child: Text(context.tr(habit.nameKey)),
                      ),
                  ],
                  onChanged: (value) => setState(() => _habitId = value),
                );
              },
            ),
            const SizedBox(height: 14),
            SegmentedButton<GrowthMode>(
              segments: [
                for (final mode in GrowthMode.values)
                  ButtonSegment(
                    value: mode,
                    label: Text(context.tr(_growthModeName(mode))),
                  ),
              ],
              selected: {_mode},
              onSelectionChanged: (value) =>
                  setState(() => _mode = value.first),
            ),
            const SizedBox(height: 14),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(context.tr('Start date')),
              subtitle: Text(
                MaterialLocalizations.of(context).formatFullDate(_start),
              ),
              trailing: const Icon(Icons.event_rounded),
              onTap: _pickDate,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                context.tr('Choose habit days'),
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(height: 3),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                context.tr('Unselected days are your days off.'),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 7),
            Wrap(
              spacing: 6,
              children: [
                for (var day = 1; day <= 7; day++)
                  FilterChip(
                    label: Text(
                      MaterialLocalizations.of(context).narrowWeekdays[day % 7],
                    ),
                    selected: _habitDays.contains(day),
                    onSelected: (selected) {
                      if (!selected && _habitDays.length == 1) return;
                      setState(() {
                        if (selected) {
                          _habitDays.add(day);
                        } else {
                          _habitDays.remove(day);
                          _weekdayRepetitions.remove(day);
                        }
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 10),
            SegmentedButton<GrowthMeasurementUnit>(
              segments: [
                ButtonSegment(
                  value: GrowthMeasurementUnit.times,
                  icon: const Icon(Icons.repeat_rounded),
                  label: Text(context.tr('Times')),
                ),
                ButtonSegment(
                  value: GrowthMeasurementUnit.minutes,
                  icon: const Icon(Icons.schedule_rounded),
                  label: Text(context.tr('Hours and minutes')),
                ),
              ],
              selected: {_measurementUnit},
              onSelectionChanged: (selection) => setState(() {
                _measurementUnit = selection.first;
                _repetitions = _measurementUnit == GrowthMeasurementUnit.minutes
                    ? 30
                    : 1;
                _weekdayRepetitions.clear();
              }),
            ),
            const SizedBox(height: 10),
            _StepperRow(
              label: context.tr(
                _measurementUnit == GrowthMeasurementUnit.minutes
                    ? 'Target duration per day'
                    : 'Target repetitions per day',
              ),
              value: _repetitions,
              minimum: 1,
              maximum: _measurementUnit == GrowthMeasurementUnit.minutes
                  ? 1439
                  : 20,
              step: _measurementUnit == GrowthMeasurementUnit.minutes ? 5 : 1,
              valueLabel: _growthAmountLabel(
                context,
                _repetitions,
                _measurementUnit,
              ),
              onValueTap: _measurementUnit == GrowthMeasurementUnit.minutes
                  ? () async {
                      final value = await _pickDuration(_repetitions);
                      if (value != null && mounted) {
                        setState(() => _repetitions = value);
                      }
                    }
                  : null,
              onChanged: (value) => setState(() => _repetitions = value),
            ),
            const SizedBox(height: 12),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text(
                context.tr('Different targets for certain days'),
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
              subtitle: Text(
                context.tr(
                  'Turn this on to give selected days a different daily target.',
                ),
              ),
              value: _customWeekdayTargetsEnabled,
              onChanged: (enabled) => setState(() {
                _customWeekdayTargetsEnabled = enabled;
              }),
            ),
            if (_customWeekdayTargetsEnabled) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    for (final day in (_habitDays.toList()..sort())) ...[
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(_weekdayName(context, day)),
                        value: _weekdayRepetitions.containsKey(day),
                        onChanged: (enabled) => setState(() {
                          if (enabled) {
                            _weekdayRepetitions[day] = _repetitions;
                          } else {
                            _weekdayRepetitions.remove(day);
                          }
                        }),
                      ),
                      if (_weekdayRepetitions.containsKey(day))
                        _StepperRow(
                          label: context.tr(
                            _measurementUnit == GrowthMeasurementUnit.minutes
                                ? 'Duration on this day'
                                : 'Repetitions on this day',
                          ),
                          value: _weekdayRepetitions[day]!,
                          minimum: 1,
                          maximum:
                              _measurementUnit == GrowthMeasurementUnit.minutes
                              ? 1439
                              : 20,
                          step:
                              _measurementUnit == GrowthMeasurementUnit.minutes
                              ? 5
                              : 1,
                          valueLabel: _growthAmountLabel(
                            context,
                            _weekdayRepetitions[day]!,
                            _measurementUnit,
                          ),
                          onValueTap:
                              _measurementUnit == GrowthMeasurementUnit.minutes
                              ? () async {
                                  final value = await _pickDuration(
                                    _weekdayRepetitions[day]!,
                                  );
                                  if (value != null && mounted) {
                                    setState(
                                      () => _weekdayRepetitions[day] = value,
                                    );
                                  }
                                }
                              : null,
                          onChanged: (value) =>
                              setState(() => _weekdayRepetitions[day] = value),
                        ),
                    ],
                  ],
                ),
              ),
            ],
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _habitId == null || _saving ? null : _save,
                icon: const Icon(Icons.trending_up_rounded),
                label: Text(context.tr('Start plan')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _start,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (picked != null) setState(() => _start = picked);
  }

  Future<int?> _pickDuration(int currentMinutes) async {
    final normalized = currentMinutes.clamp(1, 1439);
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: normalized ~/ 60, minute: normalized % 60),
      helpText: context.tr('Choose hours and minutes'),
    );
    if (picked == null) return null;
    return math.max(1, (picked.hour * 60) + picked.minute);
  }

  Future<void> _save() async {
    if (widget.initial != null) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(context.tr('Change this growth plan?')),
          content: Text(
            context.tr('Changing it replaces the current growth schedule.'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(context.tr('Cancel')),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(context.tr('Change')),
            ),
          ],
        ),
      );
      if (confirmed != true) return;
    }
    setState(() => _saving = true);
    if (widget.initial != null) {
      await widget.repository.deactivatePlan(widget.initial!.planId);
    }
    await widget.repository.createPlan(
      habitId: _habitId!,
      mode: _mode,
      startedOn: _start,
      targetDaysPerWeek: _habitDays.length,
      targetRepetitionsPerDay: _repetitions,
      offWeekdays: {
        for (var day = DateTime.monday; day <= DateTime.sunday; day++)
          if (!_habitDays.contains(day)) day,
      },
      weekdayRepetitions: _customWeekdayTargetsEnabled
          ? _weekdayRepetitions
          : const {},
      measurementUnit: _measurementUnit,
    );
    if (mounted) Navigator.pop(context);
  }

  Set<int> _storedHabitDays(GrowthCalendarData plan) {
    final available = [
      for (var day = DateTime.monday; day <= DateTime.sunday; day++)
        if (!plan.offWeekdays.contains(day)) day,
    ];
    if (available.length <= plan.targetDaysPerWeek) return available.toSet();
    if (plan.targetDaysPerWeek == 1) {
      return {available[(available.length - 1) ~/ 2]};
    }
    return {
      for (var index = 0; index < plan.targetDaysPerWeek; index++)
        available[(index *
                (available.length - 1) /
                (plan.targetDaysPerWeek - 1))
            .round()],
    };
  }

  String _weekdayName(BuildContext context, int weekday) {
    return context.tr(switch (weekday) {
      DateTime.monday => 'Monday',
      DateTime.tuesday => 'Tuesday',
      DateTime.wednesday => 'Wednesday',
      DateTime.thursday => 'Thursday',
      DateTime.friday => 'Friday',
      DateTime.saturday => 'Saturday',
      _ => 'Sunday',
    });
  }
}

class _StepperRow extends StatelessWidget {
  const _StepperRow({
    required this.label,
    required this.value,
    required this.minimum,
    required this.maximum,
    required this.onChanged,
    this.step = 1,
    this.valueLabel,
    this.onValueTap,
  });
  final String label;
  final int value;
  final int minimum;
  final int maximum;
  final ValueChanged<int> onChanged;
  final int step;
  final String? valueLabel;
  final VoidCallback? onValueTap;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
      ),
      IconButton.filledTonal(
        onPressed: value <= minimum
            ? null
            : () => onChanged(math.max(minimum, value - step)),
        icon: const Icon(Icons.remove_rounded),
      ),
      InkWell(
        onTap: onValueTap,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: valueLabel == null ? 36 : 82,
          child: Text(
            valueLabel ?? '$value',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
      ),
      IconButton.filledTonal(
        onPressed: value >= maximum
            ? null
            : () => onChanged(math.min(maximum, value + step)),
        icon: const Icon(Icons.add_rounded),
      ),
    ],
  );
}

String _growthModeName(GrowthMode mode) => switch (mode) {
  GrowthMode.fast => 'Fast',
  GrowthMode.medium => 'Medium',
  GrowthMode.slow => 'Slow',
};

String _growthAmountLabel(
  BuildContext context,
  int value,
  GrowthMeasurementUnit unit, {
  bool compact = false,
}) {
  if (unit == GrowthMeasurementUnit.times) {
    return compact ? '×$value' : '$value ${context.tr('times')}';
  }
  final hours = value ~/ 60;
  final minutes = value % 60;
  if (compact) {
    if (hours == 0) return '${minutes}m';
    if (minutes == 0) return '${hours}h';
    return '${hours}h ${minutes}m';
  }
  if (hours == 0) return '$minutes ${context.tr('minutes')}';
  if (minutes == 0) return '$hours ${context.tr('hours')}';
  return '$hours ${context.tr('hours')} $minutes ${context.tr('minutes')}';
}
