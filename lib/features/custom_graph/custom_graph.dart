import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visualyou/features/custom_graph/custom_graph_models.dart';
import 'package:visualyou/features/custom_graph/custom_graph_repository.dart';
import 'package:visualyou/l10n/app_strings.dart';

class CustomGraphCard extends StatefulWidget {
  const CustomGraphCard({required this.repository, super.key});

  final CustomGraphRepository repository;

  @override
  State<CustomGraphCard> createState() => _CustomGraphCardState();
}

class _CustomGraphCardState extends State<CustomGraphCard> {
  late Stream<CustomGraphSnapshot> _snapshotStream;

  @override
  void initState() {
    super.initState();
    _snapshotStream = widget.repository.watchSnapshot();
  }

  @override
  void didUpdateWidget(CustomGraphCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.repository != widget.repository) {
      _snapshotStream = widget.repository.watchSnapshot();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark
        ? const Color(0xFF24272E)
        : const Color(0xFFF0F2F5);

    return Container(
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
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
      child: StreamBuilder<CustomGraphSnapshot>(
        stream: _snapshotStream,
        builder: (context, snapshot) {
          final data = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.tr('Custom graph'),
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton(
                    key: const Key('editCustomGraphButton'),
                    tooltip: context.tr('Customize graph'),
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.tune_rounded),
                    onPressed: () => _openEditor(context),
                  ),
                ],
              ),
              if (snapshot.hasError)
                _GraphMessage(
                  icon: Icons.error_outline_rounded,
                  message: context.tr('Could not load custom graph'),
                )
              else if (data == null)
                SizedBox(
                  height: 150,
                  child: Center(
                    child: Icon(
                      Icons.hourglass_empty_rounded,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                )
              else if (data.rules.isEmpty)
                _EmptyGraph(onPressed: () => _openEditor(context))
              else ...[
                Wrap(
                  spacing: 12,
                  runSpacing: 5,
                  children: [
                    for (var index = 0; index < data.rules.length; index++)
                      _GraphLegend(
                        color: theme.colorScheme.primary,
                        label: context.tr(data.rules[index].habitNameKey),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: _CustomGraphPainter(
                      snapshot: data,
                      lineColor: theme.colorScheme.primary,
                      gridColor: theme.colorScheme.outlineVariant,
                      zeroColor: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (final day in data.days)
                      Text('${day.day.day}', style: theme.textTheme.labelSmall),
                  ],
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Future<void> _openEditor(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => CustomGraphEditor(repository: widget.repository),
    );
  }
}

class CustomGraphEditor extends StatefulWidget {
  const CustomGraphEditor({required this.repository, super.key});

  final CustomGraphRepository repository;

  @override
  State<CustomGraphEditor> createState() => _CustomGraphEditorState();
}

class SpecialHabitGraphsSection extends StatefulWidget {
  const SpecialHabitGraphsSection({required this.repository, super.key});

  final CustomGraphRepository repository;

  @override
  State<SpecialHabitGraphsSection> createState() =>
      _SpecialHabitGraphsSectionState();
}

class _SpecialHabitGraphsSectionState extends State<SpecialHabitGraphsSection> {
  late Stream<List<SpecialHabitGraph>> _graphsStream;

  @override
  void initState() {
    super.initState();
    _graphsStream = widget.repository.watchSpecialHabitGraphs();
  }

  @override
  void didUpdateWidget(SpecialHabitGraphsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.repository != widget.repository) {
      _graphsStream = widget.repository.watchSpecialHabitGraphs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SpecialHabitGraph>>(
      stream: _graphsStream,
      builder: (context, snapshot) {
        final graphs = {
          for (final graph in snapshot.data ?? const <SpecialHabitGraph>[])
            graph.slot: graph,
        };
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var slot = 0; slot < 2; slot++) ...[
              if (slot > 0) const SizedBox(width: 10),
              Expanded(
                child: _SpecialHabitGraphCard(
                  slot: slot,
                  graph: graphs[slot],
                  repository: widget.repository,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _SpecialHabitGraphCard extends StatelessWidget {
  const _SpecialHabitGraphCard({
    required this.slot,
    required this.graph,
    required this.repository,
  });

  final int slot;
  final SpecialHabitGraph? graph;
  final CustomGraphRepository repository;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final lineColor = slot == 0
        ? theme.colorScheme.primary
        : theme.colorScheme.secondary;
    return AspectRatio(
      aspectRatio: 1,
      child: Material(
        color: isDark ? const Color(0xFF24272E) : const Color(0xFFF0F2F5),
        borderRadius: BorderRadius.circular(22),
        elevation: isDark ? 0 : 2,
        shadowColor: theme.colorScheme.primary.withValues(alpha: .18),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () => _openPicker(context),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(11, 8, 8, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        graph == null
                            ? context.tr('Choose habit')
                            : context.tr(graph!.habitNameKey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Icon(Icons.tune_rounded, size: 18, color: lineColor),
                  ],
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: graph == null
                      ? Center(
                          child: Icon(
                            Icons.add_chart_rounded,
                            size: 34,
                            color: lineColor,
                          ),
                        )
                      : CustomPaint(
                          size: Size.infinite,
                          painter: _SpecialHabitGraphPainter(
                            days: graph!.days,
                            lineColor: lineColor,
                            gridColor: theme.colorScheme.outlineVariant,
                          ),
                        ),
                ),
                if (graph != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${graph!.days.first.day.day}',
                        style: theme.textTheme.labelSmall,
                      ),
                      Text(
                        '${graph!.days.last.day.day}',
                        style: theme.textTheme.labelSmall,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openPicker(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      builder: (context) => _SpecialHabitPicker(
        slot: slot,
        selectedHabitId: graph?.habitId,
        repository: repository,
      ),
    );
  }
}

class _SpecialHabitPicker extends StatefulWidget {
  const _SpecialHabitPicker({
    required this.slot,
    required this.selectedHabitId,
    required this.repository,
  });

  final int slot;
  final String? selectedHabitId;
  final CustomGraphRepository repository;

  @override
  State<_SpecialHabitPicker> createState() => _SpecialHabitPickerState();
}

class _SpecialHabitPickerState extends State<_SpecialHabitPicker> {
  late Future<List<CustomGraphHabit>> _habits;

  @override
  void initState() {
    super.initState();
    _habits = widget.repository.loadHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr('Choose special habit'),
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: FutureBuilder<List<CustomGraphHabit>>(
              future: _habits,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.hide_source_rounded),
                      title: Text(context.tr('Not selected')),
                      selected: widget.selectedHabitId == null,
                      onTap: () => _select(context, null),
                    ),
                    for (final habit in snapshot.data!)
                      ListTile(
                        leading: const Icon(Icons.show_chart_rounded),
                        title: Text(context.tr(habit.nameKey)),
                        selected: widget.selectedHabitId == habit.id,
                        onTap: () => _select(context, habit.id),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _select(BuildContext context, String? habitId) async {
    await widget.repository.saveSpecialHabit(
      slot: widget.slot,
      habitId: habitId,
    );
    if (context.mounted) Navigator.of(context).pop();
  }
}

class _CustomGraphEditorState extends State<CustomGraphEditor> {
  final _slots = List.generate(3, (index) => _EditableRule(slot: index));
  List<CustomGraphHabit> _habits = const [];
  bool _loading = true;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final results = await Future.wait([
        widget.repository.loadHabits(),
        widget.repository.loadRules(),
      ]);
      final habits = results[0] as List<CustomGraphHabit>;
      final rules = results[1] as List<CustomGraphRule>;
      for (final rule in rules) {
        if (rule.slot < 0 || rule.slot >= _slots.length) continue;
        _slots[rule.slot]
          ..habitId = rule.habitId
          ..completedPoints = '${rule.completedPoints}'
          ..missedPoints = '${rule.missedPoints}';
      }
      if (!mounted) return;
      setState(() {
        _habits = habits;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = context.tr('Could not load custom graph');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 18,
        right: 18,
        top: 8,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 18,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              context.tr('Customize graph'),
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              context.tr('Choose up to 3 habits and set their point values.'),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            if (_loading)
              const Center(child: CircularProgressIndicator())
            else
              for (final slot in _slots) ...[
                _RuleEditor(
                  key: ValueKey('customGraphSlot${slot.slot}'),
                  number: slot.slot + 1,
                  slot: slot,
                  habits: _habits,
                  onChanged: () => setState(() => _error = null),
                ),
                const SizedBox(height: 10),
              ],
            if (_error != null) ...[
              Text(
                _error!,
                style: TextStyle(
                  color: theme.colorScheme.error,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
            ],
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _loading || _saving ? null : _save,
                icon: _saving
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.check_rounded),
                label: Text(context.tr('Save graph')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final chosen = _slots.where((slot) => slot.habitId != null).toList();
    if (chosen.map((slot) => slot.habitId).toSet().length != chosen.length) {
      setState(() => _error = context.tr('Choose different habits.'));
      return;
    }

    final rules = <CustomGraphRule>[];
    for (final slot in chosen) {
      final completed = int.tryParse(slot.completedPoints);
      final missed = int.tryParse(slot.missedPoints);
      if (completed == null || missed == null) {
        setState(() => _error = context.tr('Enter valid whole numbers.'));
        return;
      }
      final habit = _habits.firstWhere((habit) => habit.id == slot.habitId);
      rules.add(
        CustomGraphRule(
          slot: slot.slot,
          habitId: habit.id,
          habitNameKey: habit.nameKey,
          completedPoints: completed,
          missedPoints: missed,
        ),
      );
    }

    setState(() => _saving = true);
    try {
      await widget.repository.saveRules(rules);
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = context.tr('Could not save custom graph');
      });
    }
  }
}

class _RuleEditor extends StatelessWidget {
  const _RuleEditor({
    required this.number,
    required this.slot,
    required this.habits,
    required this.onChanged,
    super.key,
  });

  final int number;
  final _EditableRule slot;
  final List<CustomGraphHabit> habits;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${context.tr('Habit')} $number',
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String?>(
            initialValue: slot.habitId,
            decoration: InputDecoration(
              labelText: context.tr('Choose habit'),
              border: const OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem<String?>(
                value: null,
                child: Text(context.tr('Not selected')),
              ),
              for (final habit in habits)
                DropdownMenuItem<String?>(
                  value: habit.id,
                  child: Text(context.tr(habit.nameKey)),
                ),
            ],
            onChanged: (habitId) {
              slot.habitId = habitId;
              if (habitId != null &&
                  slot.completedPoints.isEmpty &&
                  slot.missedPoints.isEmpty) {
                final habit = habits.firstWhere((habit) => habit.id == habitId);
                final isReduction = habit.category == 'reduction';
                slot.completedPoints = isReduction ? '-5' : '3';
                slot.missedPoints = isReduction ? '5' : '-2';
              }
              onChanged();
            },
          ),
          if (slot.habitId != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    key: ValueKey('${slot.slot}-${slot.habitId}-completed'),
                    initialValue: slot.completedPoints,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
                    ],
                    decoration: InputDecoration(
                      labelText: context.tr('If completed'),
                      prefixText: context.tr('Points '),
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) => slot.completedPoints = value,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    key: ValueKey('${slot.slot}-${slot.habitId}-missed'),
                    initialValue: slot.missedPoints,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
                    ],
                    decoration: InputDecoration(
                      labelText: context.tr('If missed'),
                      prefixText: context.tr('Points '),
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) => slot.missedPoints = value,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _EditableRule {
  _EditableRule({required this.slot});

  final int slot;
  String? habitId;
  String completedPoints = '';
  String missedPoints = '';
}

class _EmptyGraph extends StatelessWidget {
  const _EmptyGraph({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.show_chart_rounded,
              size: 34,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 6),
            Text(context.tr('Choose up to 3 habits')),
            const SizedBox(height: 8),
            FilledButton.tonal(
              onPressed: onPressed,
              child: Text(context.tr('Set up graph')),
            ),
          ],
        ),
      ),
    );
  }
}

class _GraphMessage extends StatelessWidget {
  const _GraphMessage({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(icon), const SizedBox(height: 6), Text(message)],
        ),
      ),
    );
  }
}

class _GraphLegend extends StatelessWidget {
  const _GraphLegend({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(label, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}

class _CustomGraphPainter extends CustomPainter {
  const _CustomGraphPainter({
    required this.snapshot,
    required this.lineColor,
    required this.gridColor,
    required this.zeroColor,
  });

  final CustomGraphSnapshot snapshot;
  final Color lineColor;
  final Color gridColor;
  final Color zeroColor;

  @override
  void paint(Canvas canvas, Size size) {
    const inset = 7.0;
    final values = [0, for (final day in snapshot.days) day.total];
    var minimum = values.reduce(math.min).toDouble();
    var maximum = values.reduce(math.max).toDouble();
    if (minimum == maximum) {
      minimum -= 1;
      maximum += 1;
    }

    final gridPaint = Paint()
      ..color = gridColor.withValues(alpha: .7)
      ..strokeWidth = 1;
    for (var row = 0; row <= 3; row++) {
      final y = inset + ((size.height - inset * 2) * row / 3);
      canvas.drawLine(
        Offset(inset, y),
        Offset(size.width - inset, y),
        gridPaint,
      );
    }

    double xFor(int index) {
      return inset +
          (size.width - inset * 2) * index / (snapshot.days.length - 1);
    }

    double yFor(num value) {
      return inset +
          (maximum - value) / (maximum - minimum) * (size.height - inset * 2);
    }

    final zeroY = yFor(0);
    canvas.drawLine(
      Offset(inset, zeroY),
      Offset(size.width - inset, zeroY),
      Paint()
        ..color = zeroColor.withValues(alpha: .55)
        ..strokeWidth = 1.4,
    );

    final path = Path();
    for (var dayIndex = 0; dayIndex < snapshot.days.length; dayIndex++) {
      final point = Offset(xFor(dayIndex), yFor(snapshot.days[dayIndex].total));
      if (dayIndex == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = lineColor
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke,
    );
    for (var dayIndex = 0; dayIndex < snapshot.days.length; dayIndex++) {
      final point = Offset(xFor(dayIndex), yFor(snapshot.days[dayIndex].total));
      canvas.drawCircle(point, 3.5, Paint()..color = lineColor);
    }
  }

  @override
  bool shouldRepaint(_CustomGraphPainter oldDelegate) {
    return oldDelegate.snapshot != snapshot ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.gridColor != gridColor ||
        oldDelegate.zeroColor != zeroColor;
  }
}

class _SpecialHabitGraphPainter extends CustomPainter {
  const _SpecialHabitGraphPainter({
    required this.days,
    required this.lineColor,
    required this.gridColor,
  });

  final List<SpecialHabitGraphDay> days;
  final Color lineColor;
  final Color gridColor;

  @override
  void paint(Canvas canvas, Size size) {
    const inset = 5.0;
    final maximum = math.max(1, days.map((day) => day.count).reduce(math.max));
    final gridPaint = Paint()
      ..color = gridColor.withValues(alpha: .7)
      ..strokeWidth = 1;
    for (var row = 0; row <= 2; row++) {
      final y = inset + (size.height - inset * 2) * row / 2;
      canvas.drawLine(
        Offset(inset, y),
        Offset(size.width - inset, y),
        gridPaint,
      );
    }

    double xFor(int index) =>
        inset + (size.width - inset * 2) * index / (days.length - 1);
    double yFor(int count) =>
        size.height - inset - (size.height - inset * 2) * count / maximum;

    final path = Path();
    for (var index = 0; index < days.length; index++) {
      final point = Offset(xFor(index), yFor(days[index].count));
      if (index == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = lineColor
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke,
    );
    for (var index = 0; index < days.length; index++) {
      canvas.drawCircle(
        Offset(xFor(index), yFor(days[index].count)),
        3,
        Paint()..color = lineColor,
      );
    }
  }

  @override
  bool shouldRepaint(_SpecialHabitGraphPainter oldDelegate) {
    return oldDelegate.days != days ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.gridColor != gridColor;
  }
}
