import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visualyou/features/numerical_heatmap/numerical_heatmap_models.dart';
import 'package:visualyou/features/numerical_heatmap/numerical_heatmap_repository.dart';
import 'package:visualyou/features/numerical_habits/numerical_habit_config.dart';
import 'package:visualyou/features/rewards/premium_page.dart';
import 'package:visualyou/features/rewards/rewards_controller.dart';
import 'package:visualyou/features/rewards/rewards_models.dart';
import 'package:visualyou/features/rewards/rewards_widgets.dart';
import 'package:visualyou/l10n/app_strings.dart';

const numericalHeatmapColors = <Color>[
  Color(0xFFE53935),
  Color(0xFFFB8C00),
  Color(0xFFFBC02D),
  Color(0xFF43A047),
  Color(0xFF1E88E5),
];

class NumericalHeatmapSection extends StatefulWidget {
  const NumericalHeatmapSection({
    required this.repository,
    required this.rewardsController,
    this.habitId,
    super.key,
  });

  final NumericalHeatmapRepository repository;
  final RewardsController rewardsController;
  final String? habitId;

  @override
  State<NumericalHeatmapSection> createState() =>
      _NumericalHeatmapSectionState();
}

class _NumericalHeatmapSectionState extends State<NumericalHeatmapSection> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.rewardsController,
      builder: (context, _) {
        if (widget.rewardsController.plan == MembershipPlan.free) {
          return _lockedSection();
        }
        return StreamBuilder<List<NumericalHeatmapData>>(
          stream: widget.repository.watchHeatmaps(),
          builder: (context, snapshot) {
            final all = snapshot.data ?? const <NumericalHeatmapData>[];
            final limit = _limit(widget.rewardsController.plan);
            final allowed = limit == null ? all : all.take(limit).toList();
            final visible = widget.habitId == null
                ? allowed
                : allowed
                      .where((heatmap) => heatmap.habitId == widget.habitId)
                      .toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  context.tr('Numerical habit heatmaps'),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 12),
                for (final heatmap in visible) ...[
                  _NumericalHeatmapCard(
                    heatmap: heatmap,
                    onDelete: () => widget.repository.deleteHeatmap(
                      heatmap.slot,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                if (widget.habitId == null || visible.isEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => _addHeatmap(all),
                      icon: const Icon(Icons.add_rounded),
                      label: Text(context.tr('Create numerical heatmap')),
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
        );
      },
    );
  }

  Widget _lockedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          context.tr('Numerical habit heatmaps'),
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () => openPremiumPlan(
              context,
              controller: widget.rewardsController,
              plan: MembershipPlan.plus,
            ),
            icon: const Icon(Icons.lock_open_rounded),
            label: Text(context.tr('Upgrade to Plus to unlock')),
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
  }

  int? _limit(MembershipPlan plan) => switch (plan) {
    MembershipPlan.free => 0,
    MembershipPlan.plus => 4,
    MembershipPlan.pro => 5,
    MembershipPlan.ultra => null,
  };

  int _included(MembershipPlan plan) => switch (plan) {
    MembershipPlan.free => 0,
    MembershipPlan.plus => 2,
    MembershipPlan.pro => 3,
    MembershipPlan.ultra => 1 << 30,
  };

  GatedFeature? _extensionGate(MembershipPlan plan) => switch (plan) {
    MembershipPlan.plus => GatedFeature.extraNumericalHeatmaps,
    MembershipPlan.pro => GatedFeature.extraProNumericalHeatmaps,
    MembershipPlan.free || MembershipPlan.ultra => null,
  };

  Future<void> _addHeatmap(List<NumericalHeatmapData> current) async {
    final plan = widget.rewardsController.plan;
    final limit = _limit(plan);
    if (limit == 0) {
      await openPremiumPlan(
        context,
        controller: widget.rewardsController,
        plan: MembershipPlan.plus,
      );
      return;
    }
    if (limit != null && current.length >= limit) {
      final next = nextMembershipPlan(plan);
      if (next != null) {
        await openPremiumPlan(
          context,
          controller: widget.rewardsController,
          plan: next,
        );
      }
      return;
    }

    final habits = await widget.repository.loadAvailableHabits();
    if (!mounted) return;
    final used = current.map((heatmap) => heatmap.habitId).toSet();
    final available = habits
        .where(
          (habit) =>
              !used.contains(habit.id) &&
              (widget.habitId == null || habit.id == widget.habitId),
        )
        .toList();
    if (available.isEmpty) {
      _message('No unused numerical habits are available.');
      return;
    }

    final setup = await showDialog<NumericalHeatmapSetup>(
      context: context,
      builder: (_) => _HeatmapSetupDialog(
        habits: available,
        fixedHabitId: widget.habitId,
      ),
    );
    if (setup == null || !mounted) return;

    final gate = current.length >= _included(plan) ? _extensionGate(plan) : null;
    if (gate != null &&
        !widget.rewardsController.isPaidExtensionUnlocked(gate)) {
      final unlocked = await confirmTokenOrAdPurchase(
        context,
        controller: widget.rewardsController,
        amount: 35,
        reason: 'numerical-heatmaps-${plan.name}',
        title: context.tr('Unlock two more numerical heatmaps?'),
        chargePlus: true,
      );
      if (!unlocked || !mounted) return;
      await widget.rewardsController.repository.unlockFeatureAfterPayment(gate);
      await widget.rewardsController.refresh();
    }

    var slot = 0;
    final occupied = current.map((heatmap) => heatmap.slot).toSet();
    while (occupied.contains(slot)) {
      slot++;
    }
    await widget.repository.createHeatmap(slot: slot, setup: setup);
  }

  void _message(String key) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.tr(key))));
  }
}

class _NumericalHeatmapCard extends StatefulWidget {
  const _NumericalHeatmapCard({
    required this.heatmap,
    required this.onDelete,
  });

  final NumericalHeatmapData heatmap;
  final VoidCallback onDelete;

  @override
  State<_NumericalHeatmapCard> createState() => _NumericalHeatmapCardState();
}

class _NumericalHeatmapCardState extends State<_NumericalHeatmapCard> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.jumpTo(_controller.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF24272E) : const Color(0xFFF0F2F5),
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
              Expanded(
                child: Text(
                  context.tr(widget.heatmap.habitNameKey),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              IconButton(
                tooltip: context.tr('Remove'),
                onPressed: widget.onDelete,
                icon: const Icon(Icons.delete_outline_rounded),
              ),
            ],
          ),
          SingleChildScrollView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            child: _YearHeatmap(heatmap: widget.heatmap),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(context.tr('Less'), style: theme.textTheme.labelSmall),
              const SizedBox(width: 6),
              for (final color in numericalHeatmapColors) ...[
                Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 4),
              ],
              Text(context.tr('More'), style: theme.textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}

class _YearHeatmap extends StatelessWidget {
  const _YearHeatmap({required this.heatmap});

  final NumericalHeatmapData heatmap;

  static const _cell = 20.0;
  static const _gap = 5.0;
  static const _weekWidth = _cell + _gap;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final end = today.add(Duration(days: 7 - today.weekday));
    final start = end.subtract(const Duration(days: 370));
    final firstMonday = start.subtract(Duration(days: start.weekday - 1));
    const weeks = 53;
    final width = weeks * _weekWidth;
    final created = DateTime(
      heatmap.createdAt.year,
      heatmap.createdAt.month,
      heatmap.createdAt.day,
    );

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 18,
            child: Stack(
              children: [
                for (var week = 0; week < weeks; week++)
                  if (firstMonday.add(Duration(days: week * 7)).day <= 7)
                    Positioned(
                      left: week * _weekWidth,
                      child: Text(
                        _monthLabel(
                          firstMonday.add(Duration(days: week * 7)).month,
                        ),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var week = 0; week < weeks; week++)
                Padding(
                  padding: const EdgeInsets.only(right: _gap),
                  child: Column(
                    children: [
                      for (var weekday = 0; weekday < 7; weekday++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: _gap),
                          child: _dayCell(
                            context,
                            firstMonday.add(
                              Duration(days: week * 7 + weekday),
                            ),
                            created,
                            today,
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dayCell(
    BuildContext context,
    DateTime day,
    DateTime created,
    DateTime today,
  ) {
    final eligible = !day.isBefore(created) && !day.isAfter(today);
    final hasEntry = heatmap.outcomeByDay.containsKey(day);
    final color = eligible
        ? _performanceColor(heatmap, day, hasEntry)
        : Theme.of(context).colorScheme.surfaceContainerHighest;
    return Tooltip(
      message: '${day.day}/${day.month}/${day.year}',
      child: Container(
        width: _cell,
        height: _cell,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}

Color _performanceColor(
  NumericalHeatmapData heatmap,
  DateTime day,
  bool hasEntry,
) {
  if (!hasEntry) return numericalHeatmapColors[0];
  final value = heatmap.valueByDay[day];
  if (value != null) {
    if (heatmap.higherIsBetter) {
      if (value >= heatmap.blueThreshold) return numericalHeatmapColors[4];
      if (value >= heatmap.greenThreshold) return numericalHeatmapColors[3];
      if (value >= heatmap.yellowThreshold) return numericalHeatmapColors[2];
      if (value >= heatmap.orangeThreshold) return numericalHeatmapColors[1];
      return numericalHeatmapColors[0];
    }
    if (value <= heatmap.blueThreshold) return numericalHeatmapColors[4];
    if (value <= heatmap.greenThreshold) return numericalHeatmapColors[3];
    if (value <= heatmap.yellowThreshold) return numericalHeatmapColors[2];
    if (value <= heatmap.orangeThreshold) return numericalHeatmapColors[1];
    return numericalHeatmapColors[0];
  }
  final factor = heatmap.outcomeByDay[day];
  if (factor == null || factor <= -.75) return numericalHeatmapColors[0];
  if (factor <= -.25) return numericalHeatmapColors[1];
  if (factor < .25) return numericalHeatmapColors[2];
  if (factor < .75) return numericalHeatmapColors[3];
  return numericalHeatmapColors[4];
}

class _HeatmapSetupDialog extends StatefulWidget {
  const _HeatmapSetupDialog({
    required this.habits,
    required this.fixedHabitId,
  });

  final List<NumericalHeatmapHabit> habits;
  final String? fixedHabitId;

  @override
  State<_HeatmapSetupDialog> createState() => _HeatmapSetupDialogState();
}

class _HeatmapSetupDialogState extends State<_HeatmapSetupDialog> {
  late String _habitId;
  late bool _higherIsBetter;
  late List<int> _thresholds;
  String? _error;

  NumericalHeatmapHabit get _habit =>
      widget.habits.firstWhere((habit) => habit.id == _habitId);

  @override
  void initState() {
    super.initState();
    _habitId = widget.fixedHabitId ?? widget.habits.first.id;
    _resetThresholds();
  }

  void _resetThresholds() {
    final habit = widget.habits.firstWhere((habit) => habit.id == _habitId);
    final kind = numericalHabitConfigs[habit.id]?.kind;
    _higherIsBetter = kind != NumericalHabitKind.limitedDuration &&
        kind != NumericalHabitKind.occurrences;
    final target = habit.target.clamp(1, 1000000);
    _thresholds = _higherIsBetter
        ? [
            (target * .25).round().clamp(1, target),
            (target * .5).round().clamp(1, target),
            (target * .75).round().clamp(1, target),
            target,
          ]
        : [target * 2, (target * 1.5).round(), target, 0];
    _error = null;
  }

  @override
  Widget build(BuildContext context) {
    final colorNames = ['Orange', 'Yellow', 'Green', 'Blue'];
    return AlertDialog(
      title: Text(context.tr('Create numerical heatmap')),
      content: SizedBox(
        width: 430,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.fixedHabitId == null)
                DropdownButtonFormField<String>(
                  initialValue: _habitId,
                  decoration: InputDecoration(
                    labelText: context.tr('Choose numerical habit'),
                    border: const OutlineInputBorder(),
                  ),
                  items: [
                    for (final habit in widget.habits)
                      DropdownMenuItem(
                        value: habit.id,
                        child: Text(context.tr(habit.nameKey)),
                      ),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _habitId = value;
                      _resetThresholds();
                    });
                  },
                )
              else
                Text(
                  context.tr(_habit.nameKey),
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              const SizedBox(height: 16),
              Text(
                context.tr('Which direction is better?'),
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              SegmentedButton<bool>(
                segments: [
                  ButtonSegment(
                    value: true,
                    label: Text(context.tr('More is better')),
                  ),
                  ButtonSegment(
                    value: false,
                    label: Text(context.tr('Less is better')),
                  ),
                ],
                selected: {_higherIsBetter},
                onSelectionChanged: (selection) => setState(() {
                  _higherIsBetter = selection.first;
                  final target = _habit.target.clamp(1, 1000000);
                  _thresholds = _higherIsBetter
                      ? [
                          (target * .25).round().clamp(1, target),
                          (target * .5).round().clamp(1, target),
                          (target * .75).round().clamp(1, target),
                          target,
                        ]
                      : [target * 2, (target * 1.5).round(), target, 0];
                  _error = null;
                }),
              ),
              const SizedBox(height: 16),
              Text(
                context.tr('Choose the value for each color'),
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              for (var index = 0; index < 4; index++) ...[
                _ColorThresholdField(
                  key: ValueKey('$_habitId-$_higherIsBetter-$index'),
                  color: numericalHeatmapColors[index + 1],
                  label: context.tr(colorNames[index]),
                  unitKey: _habit.unitKey,
                  initialValue: _thresholds[index],
                  onChanged: (value) => _thresholds[index] = value,
                ),
                if (index != 3) const SizedBox(height: 9),
              ],
              if (_error != null) ...[
                const SizedBox(height: 8),
                Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.tr('Cancel')),
        ),
        FilledButton(
          onPressed: _save,
          child: Text(context.tr('Create')),
        ),
      ],
    );
  }

  void _save() {
    final ordered = List.generate(
      3,
      (index) => _higherIsBetter
          ? _thresholds[index] <= _thresholds[index + 1]
          : _thresholds[index] >= _thresholds[index + 1],
    ).every((value) => value);
    if (!ordered) {
      setState(() {
        _error = context.tr(
          _higherIsBetter
              ? 'Color values must increase from orange to blue.'
              : 'Color values must decrease from orange to blue.',
        );
      });
      return;
    }
    Navigator.pop(
      context,
      NumericalHeatmapSetup(
        habitId: _habitId,
        higherIsBetter: _higherIsBetter,
        orangeThreshold: _thresholds[0],
        yellowThreshold: _thresholds[1],
        greenThreshold: _thresholds[2],
        blueThreshold: _thresholds[3],
      ),
    );
  }
}

class _ColorThresholdField extends StatefulWidget {
  const _ColorThresholdField({
    super.key,
    required this.color,
    required this.label,
    required this.unitKey,
    required this.initialValue,
    required this.onChanged,
  });

  final Color color;
  final String label;
  final String unitKey;
  final int initialValue;
  final ValueChanged<int> onChanged;

  @override
  State<_ColorThresholdField> createState() => _ColorThresholdFieldState();
}

class _ColorThresholdFieldState extends State<_ColorThresholdField> {
  late int _hours = widget.initialValue ~/ 60;
  late int _minutes = widget.initialValue % 60;

  @override
  Widget build(BuildContext context) {
    final duration = widget.unitKey == NumericalHabitUnit.minutes;
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 55,
          child: Text(
            widget.label,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(width: 8),
        if (duration) ...[
          Expanded(
            child: _numberField(
              initial: _hours,
              label: context.tr('Hours'),
              onChanged: (value) {
                _hours = value;
                widget.onChanged((_hours * 60) + _minutes);
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _numberField(
              initial: _minutes,
              label: context.tr('Minutes'),
              onChanged: (value) {
                _minutes = value.clamp(0, 59);
                widget.onChanged((_hours * 60) + _minutes);
              },
            ),
          ),
        ] else
          Expanded(
            child: _numberField(
              initial: widget.initialValue,
              label: context.tr(widget.unitKey),
              onChanged: widget.onChanged,
            ),
          ),
      ],
    );
  }

  Widget _numberField({
    required int initial,
    required String label,
    required ValueChanged<int> onChanged,
  }) {
    return TextFormField(
      initialValue: '$initial',
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: label,
        isDense: true,
        border: const OutlineInputBorder(),
      ),
      onChanged: (text) => onChanged(int.tryParse(text) ?? 0),
    );
  }
}

String _monthLabel(int month) => const [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
][month - 1];
