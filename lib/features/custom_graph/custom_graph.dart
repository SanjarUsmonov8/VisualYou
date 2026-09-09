import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visualyou/data/habits/habit_repository.dart';
import 'package:visualyou/features/custom_graph/custom_graph_models.dart';
import 'package:visualyou/features/custom_graph/custom_graph_repository.dart';
import 'package:visualyou/features/habit_streak/habit_streak_repository.dart';
import 'package:visualyou/features/habit_streak/habit_streak_section.dart';
import 'package:visualyou/features/numerical_habits/numerical_habit_config.dart';
import 'package:visualyou/features/numerical_heatmap/numerical_heatmap_repository.dart';
import 'package:visualyou/features/numerical_heatmap/numerical_heatmap_section.dart';
import 'package:visualyou/features/rewards/rewards_controller.dart';
import 'package:visualyou/features/rewards/habit_access.dart';
import 'package:visualyou/features/rewards/premium_page.dart';
import 'package:visualyou/features/rewards/rewards_models.dart';
import 'package:visualyou/features/rewards/rewards_widgets.dart';
import 'package:visualyou/l10n/app_strings.dart';
import 'package:visualyou/widgets/sheet_dismiss_handle.dart';

class CustomGraphCard extends StatefulWidget {
  const CustomGraphCard({
    required this.repository,
    required this.rewardsController,
    super.key,
  });

  final CustomGraphRepository repository;
  final RewardsController rewardsController;

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
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: data == null
                ? null
                : data.rules.isNotEmpty
                ? () => _openDetail(context, data)
                : () => _openEditor(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (!widget.rewardsController.isPlus)
                      const SizedBox(width: 74),
                    Expanded(
                      child: Text(
                        context.tr('Custom graph'),
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
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
                        labelColor: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (final day in data.days)
                        Text(
                          '${day.day.day}',
                          style: theme.textTheme.labelMedium,
                        ),
                    ],
                  ),
                ],
              ],
            ),
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
      builder: (context) => CustomGraphEditor(
        repository: widget.repository,
        rewardsController: widget.rewardsController,
      ),
    );
  }

  Future<void> _openDetail(BuildContext context, CustomGraphSnapshot snapshot) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _CustomGraphFullPage(
          title: context.tr('Custom graph'),
          snapshot: snapshot,
          onEdit: () => _openEditor(context),
          historyLoader: widget.rewardsController.isPlus
              ? (endingOn, dayCount) async => widget.repository
                    .watchSnapshot(endingOn: endingOn, dayCount: dayCount)
                    .first
              : null,
        ),
      ),
    );
  }
}

class CustomGraphEditor extends StatefulWidget {
  const CustomGraphEditor({
    required this.repository,
    required this.rewardsController,
    super.key,
  });

  final CustomGraphRepository repository;
  final RewardsController rewardsController;

  @override
  State<CustomGraphEditor> createState() => _CustomGraphEditorState();
}

Future<void> _openNextGraphPlan(
  BuildContext context,
  RewardsController controller,
) async {
  final navigator = Navigator.of(context);
  final targetPlan = nextMembershipPlan(controller.plan);
  navigator.pop();
  await Future<void>.delayed(const Duration(milliseconds: 220));
  if (!navigator.mounted || targetPlan == null) return;
  await navigator.push<void>(
    MaterialPageRoute<void>(
      builder: (_) =>
          PremiumPage(controller: controller, initialPlan: targetPlan),
    ),
  );
}

class NamedCustomGraphsSection extends StatefulWidget {
  const NamedCustomGraphsSection({
    required this.repository,
    required this.rewardsController,
    super.key,
  });

  final CustomGraphRepository repository;
  final RewardsController rewardsController;

  @override
  State<NamedCustomGraphsSection> createState() =>
      _NamedCustomGraphsSectionState();
}

class _NamedCustomGraphsSectionState extends State<NamedCustomGraphsSection> {
  late Stream<List<NamedCustomGraph>> _stream;

  @override
  void initState() {
    super.initState();
    _stream = widget.repository.watchNamedGraphs();
  }

  @override
  void didUpdateWidget(covariant NamedCustomGraphsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.repository != widget.repository) {
      _stream = widget.repository.watchNamedGraphs();
    }
  }

  @override
  Widget build(BuildContext context) {
    final limit = widget.rewardsController.namedCustomGraphLimit;
    final upgradePlan = nextMembershipPlan(widget.rewardsController.plan);
    if (limit == 0 && upgradePlan != null) {
      return SizedBox(
        width: double.infinity,
        child: UpgradePlanButton(
          controller: widget.rewardsController,
          targetPlan: upgradePlan,
          label: context.tr('Create a group graph'),
          icon: Icons.lock_outline_rounded,
        ),
      );
    }
    if (limit == 0) return const SizedBox.shrink();
    return StreamBuilder<List<NamedCustomGraph>>(
      stream: _stream,
      builder: (context, snapshot) {
        final graphs = {
          for (final graph in snapshot.data ?? const <NamedCustomGraph>[])
            if (graph.slot < limit) graph.slot: graph,
        };
        final existingSlots = graphs.keys.toList()..sort();
        int? nextSlot;
        for (var slot = 0; slot < limit; slot++) {
          if (!graphs.containsKey(slot)) {
            nextSlot = slot;
            break;
          }
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final slot in existingSlots) ...[
              _NamedCustomGraphCard(
                slot: slot,
                graph: graphs[slot],
                repository: widget.repository,
                rewardsController: widget.rewardsController,
              ),
              const SizedBox(height: 10),
            ],
            if (nextSlot != null)
              _NamedCustomGraphCard(
                slot: nextSlot,
                graph: null,
                repository: widget.repository,
                rewardsController: widget.rewardsController,
              ),
            if (nextSlot == null && upgradePlan != null)
              SizedBox(
                width: double.infinity,
                child: UpgradePlanButton(
                  controller: widget.rewardsController,
                  targetPlan: upgradePlan,
                  label: context.tr('Create another group graph'),
                  icon: Icons.lock_outline_rounded,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _NamedCustomGraphCard extends StatefulWidget {
  const _NamedCustomGraphCard({
    required this.slot,
    required this.graph,
    required this.repository,
    required this.rewardsController,
  });

  final int slot;
  final NamedCustomGraph? graph;
  final CustomGraphRepository repository;
  final RewardsController rewardsController;

  @override
  State<_NamedCustomGraphCard> createState() => _NamedCustomGraphCardState();
}

class _NamedCustomGraphCardState extends State<_NamedCustomGraphCard> {
  late Future<bool> _unlocked;

  bool get _included {
    final plan = widget.rewardsController.plan;
    return plan == MembershipPlan.ultra ||
        (plan == MembershipPlan.pro && widget.slot < 2);
  }

  int get _cost =>
      widget.rewardsController.isPlan(MembershipPlan.plus) ? 70 : 35;

  @override
  void initState() {
    super.initState();
    _unlocked = widget.repository.isNamedGraphUnlocked(widget.slot);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return FutureBuilder<bool>(
      future: _unlocked,
      builder: (context, snapshot) {
        final accessible = _included || snapshot.data == true;
        if (widget.graph == null) {
          return _createButton(context, accessible);
        }
        return Material(
          color: isDark ? const Color(0xFF24272E) : const Color(0xFFF0F2F5),
          borderRadius: BorderRadius.circular(24),
          elevation: isDark ? 0 : 2,
          shadowColor: theme.colorScheme.primary.withValues(alpha: .16),
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => _open(context, accessible),
            child: SizedBox(
              height: 215,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
                child: accessible
                    ? _graphContent(context)
                    : _lockedContent(context),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _createButton(BuildContext context, bool accessible) {
    final theme = Theme.of(context);
    final createButton = SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: () => _open(context, accessible),
        style: FilledButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(accessible ? Icons.add_rounded : Icons.lock_clock_rounded),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                context.tr('Create a group graph'),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
            if (!accessible) ...[
              const SizedBox(width: 10),
              TokenChip(amount: _cost, compact: true),
            ],
          ],
        ),
      ),
    );
    final upgradePlan = nextMembershipPlan(widget.rewardsController.plan);
    if (accessible || upgradePlan == null) return createButton;
    return Column(
      children: [
        createButton,
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: UpgradePlanButton(
            controller: widget.rewardsController,
            targetPlan: upgradePlan,
          ),
        ),
      ],
    );
  }

  Widget _graphContent(BuildContext context) {
    final graph = widget.graph;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                graph?.name ??
                    '${context.tr('Custom graph')} ${widget.slot + 1}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        if (graph == null || graph.snapshot.rules.isEmpty)
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_chart_rounded,
                    size: 38,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 5),
                  Text(context.tr('Create a group graph')),
                ],
              ),
            ),
          )
        else ...[
          Wrap(
            spacing: 10,
            runSpacing: 3,
            children: [
              for (final rule in graph.snapshot.rules)
                _GraphLegend(
                  color: theme.colorScheme.primary,
                  label: context.tr(rule.habitNameKey),
                ),
            ],
          ),
          const SizedBox(height: 5),
          Expanded(
            child: CustomPaint(
              size: Size.infinite,
              painter: _CustomGraphPainter(
                snapshot: graph.snapshot,
                lineColor: theme.colorScheme.primary,
                gridColor: theme.colorScheme.outlineVariant,
                zeroColor: theme.colorScheme.onSurfaceVariant,
                labelColor: theme.colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final day in graph.snapshot.days)
                Text('${day.day.day}', style: theme.textTheme.labelMedium),
            ],
          ),
        ],
      ],
    );
  }

  Widget _lockedContent(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_clock_rounded, size: 36),
              const SizedBox(height: 7),
              Text(
                context.tr('Unlock this group graph for 7 days'),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 5),
              Text(context.tr('Tap to choose tokens or an ad')),
              const SizedBox(height: 7),
              if (nextMembershipPlan(widget.rewardsController.plan)
                  case final targetPlan?)
                UpgradePlanButton(
                  controller: widget.rewardsController,
                  targetPlan: targetPlan,
                ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: TokenChip(amount: _cost, compact: true),
        ),
      ],
    );
  }

  Future<void> _open(BuildContext context, bool accessible) async {
    if (!accessible) {
      final paid = await confirmTokenOrAdPurchase(
        context,
        controller: widget.rewardsController,
        amount: _cost,
        reason: 'named-custom-graph-${widget.slot}',
        title: context.tr('Do you want to unlock this group graph?'),
        chargePlus: widget.rewardsController.isPlan(MembershipPlan.plus),
      );
      if (!paid) return;
      await widget.repository.unlockNamedGraph(widget.slot);
      if (!mounted) return;
      setState(() {
        _unlocked = Future.value(true);
      });
    }
    if (!context.mounted) return;
    if (widget.graph != null) {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => _CustomGraphFullPage(
            title: widget.graph!.name,
            snapshot: widget.graph!.snapshot,
            onEdit: () => _openEditor(context),
            historyLoader: widget.rewardsController.isPlus
                ? (endingOn, dayCount) async {
                    final graphs = await widget.repository
                        .watchNamedGraphs(
                          endingOn: endingOn,
                          dayCount: dayCount,
                        )
                        .first;
                    for (final graph in graphs) {
                      if (graph.slot == widget.slot) return graph.snapshot;
                    }
                    return null;
                  }
                : null,
          ),
        ),
      );
      return;
    }
    await _openEditor(context);
  }

  Future<void> _openEditor(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _NamedCustomGraphEditor(
        graphSlot: widget.slot,
        graph: widget.graph,
        repository: widget.repository,
        rewardsController: widget.rewardsController,
      ),
    );
  }
}

class _NamedCustomGraphEditor extends StatefulWidget {
  const _NamedCustomGraphEditor({
    required this.graphSlot,
    required this.graph,
    required this.repository,
    required this.rewardsController,
  });

  final int graphSlot;
  final NamedCustomGraph? graph;
  final CustomGraphRepository repository;
  final RewardsController rewardsController;

  @override
  State<_NamedCustomGraphEditor> createState() =>
      _NamedCustomGraphEditorState();
}

class _NamedCustomGraphEditorState extends State<_NamedCustomGraphEditor> {
  late final TextEditingController _nameController;
  late final List<_EditableRule> _slots;
  List<CustomGraphHabit> _habits = const [];
  bool _loading = true;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.graph?.name ?? '');
    final savedRules = widget.graph?.snapshot.rules ?? const [];
    final sortedRules = [...savedRules]
      ..sort((a, b) => a.slot.compareTo(b.slot));
    _slots = [];
    for (final rule in sortedRules) {
      if (!widget.rewardsController.hasUnlimitedCustomGraphHabits &&
          _slots.length >= widget.rewardsController.customGraphLimit) {
        break;
      }
      _slots.add(
        _EditableRule(slot: _slots.length)
          ..habitId = rule.habitId
          ..completedPoints = '${rule.completedPoints}'
          ..missedPoints = '${rule.missedPoints}',
      );
    }
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    try {
      final habits = await widget.repository.loadHabits();
      if (!mounted) return;
      setState(() {
        _habits = habits
            .where(
              (habit) =>
                  planCanUseHabit(widget.rewardsController.plan, habit.id),
            )
            .toList();
        _loading = false;
      });
    } catch (_) {
      if (mounted) {
        setState(() => _error = context.tr('Could not load custom graph'));
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            const SheetDismissHandle(),
            const SizedBox(height: 8),
            Text(
              context.tr('Group graph'),
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nameController,
              maxLength: 40,
              decoration: InputDecoration(
                labelText: context.tr('Graph name'),
                prefixIcon: const Icon(Icons.drive_file_rename_outline_rounded),
              ),
            ),
            const SizedBox(height: 10),
            if (_loading)
              const Center(child: CircularProgressIndicator())
            else
              for (final slot in _slots) ...[
                _RuleEditor(
                  number: slot.slot + 1,
                  slot: slot,
                  habits: _habits,
                  showCost: false,
                  onChanged: () => setState(() => _error = null),
                ),
                const SizedBox(height: 10),
              ],
            if (!_loading) ...[
              SizedBox(
                width: double.infinity,
                child: FilledButton.tonalIcon(
                  onPressed: _addSlot,
                  icon: const Icon(Icons.add_rounded),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(context.tr('Add habit slot')),
                  ),
                ),
              ),
              const SizedBox(height: 14),
            ],
            if (_error != null) ...[
              Text(
                _error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              const SizedBox(height: 8),
            ],
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _saving
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: Text(context.tr('Cancel')),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _loading || _saving ? null : _save,
                    icon: const Icon(Icons.check_rounded),
                    label: Text(context.tr('Save graph')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addSlot() {
    final unlimited = widget.rewardsController.hasUnlimitedCustomGraphHabits;
    if (!unlimited &&
        _slots.length >= widget.rewardsController.customGraphLimit) {
      _openNextGraphPlan(context, widget.rewardsController);
      return;
    }
    setState(() {
      _slots.add(_EditableRule(slot: _slots.length));
      _error = null;
    });
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() => _error = context.tr('Enter a graph name.'));
      return;
    }
    final chosen = _slots.where((slot) => slot.habitId != null).toList();
    if (chosen.isEmpty) {
      setState(() => _error = context.tr('Choose at least one habit.'));
      return;
    }
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
      await widget.repository.saveNamedGraph(
        graphSlot: widget.graphSlot,
        name: name,
        rules: rules,
      );
      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) {
        setState(() {
          _saving = false;
          _error = context.tr('Could not save custom graph');
        });
      }
    }
  }
}

class SpecialHabitGraphsSection extends StatefulWidget {
  const SpecialHabitGraphsSection({
    required this.repository,
    required this.habitRepository,
    required this.habitStreakRepository,
    required this.numericalHeatmapRepository,
    required this.rewardsController,
    super.key,
  });

  final CustomGraphRepository repository;
  final HabitRepository habitRepository;
  final HabitStreakRepository habitStreakRepository;
  final NumericalHeatmapRepository numericalHeatmapRepository;
  final RewardsController rewardsController;

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
        final limit = widget.rewardsController.specialGraphLimit;
        final graphs = {
          for (final graph in snapshot.data ?? const <SpecialHabitGraph>[])
            if (limit == null || graph.slot < limit) graph.slot: graph,
        };
        final existingSlots = graphs.keys.toList()..sort();
        var nextSlot = 0;
        while (graphs.containsKey(nextSlot)) {
          nextSlot++;
        }
        final canAdd = limit == null || nextSlot < limit;
        final upgradePlan = nextMembershipPlan(widget.rewardsController.plan);
        final gate = canAdd
            ? _specialGraphGate(widget.rewardsController.plan, nextSlot)
            : null;
        final locked =
            gate != null &&
            !widget.rewardsController.isPaidExtensionUnlocked(gate);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (existingSlots.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: existingSlots.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final slot = existingSlots[index];
                  return _SpecialHabitGraphCard(
                    slot: slot,
                    graph: graphs[slot],
                    repository: widget.repository,
                    habitRepository: widget.habitRepository,
                    habitStreakRepository: widget.habitStreakRepository,
                    numericalHeatmapRepository:
                        widget.numericalHeatmapRepository,
                    rewardsController: widget.rewardsController,
                  );
                },
              ),
            if (existingSlots.isNotEmpty && canAdd) const SizedBox(height: 10),
            if (canAdd)
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => _createGraph(context, nextSlot, gate),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        locked ? Icons.lock_clock_rounded : Icons.add_rounded,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          context.tr('Create an individual graph'),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                      if (locked) ...[
                        const SizedBox(width: 10),
                        const TokenChip(amount: 35, compact: true),
                      ],
                    ],
                  ),
                ),
              ),
            if (locked && upgradePlan != null) ...[
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: UpgradePlanButton(
                  controller: widget.rewardsController,
                  targetPlan: upgradePlan,
                ),
              ),
            ],
            if (!canAdd && upgradePlan != null) ...[
              if (existingSlots.isNotEmpty) const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: UpgradePlanButton(
                  controller: widget.rewardsController,
                  targetPlan: upgradePlan,
                  label: context.tr('Create another individual graph'),
                  icon: Icons.lock_outline_rounded,
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Future<void> _createGraph(
    BuildContext context,
    int slot,
    GatedFeature? gate,
  ) async {
    if (gate != null &&
        !widget.rewardsController.isPaidExtensionUnlocked(gate)) {
      final paid = await confirmTokenOrAdPurchase(
        context,
        controller: widget.rewardsController,
        amount: 35,
        reason: 'special-graph-block-${gate.name}',
        title: context.tr('Do you want to unlock these individual graphs?'),
        chargePlus: widget.rewardsController.isPlan(MembershipPlan.plus),
      );
      if (!paid) return;
      await widget.rewardsController.repository.unlockFeatureAfterPayment(gate);
      await widget.rewardsController.refresh();
    }
    if (!context.mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      builder: (context) => _SpecialHabitPicker(
        slot: slot,
        graph: null,
        repository: widget.repository,
        rewardsController: widget.rewardsController,
      ),
    );
  }
}

GatedFeature? _specialGraphGate(MembershipPlan plan, int slot) {
  return switch (plan) {
    MembershipPlan.plus when slot >= 2 => GatedFeature.extraSingleGraphs,
    MembershipPlan.pro when slot >= 4 => GatedFeature.extraProSingleGraphs,
    _ => null,
  };
}

class _SpecialHabitGraphCard extends StatelessWidget {
  const _SpecialHabitGraphCard({
    required this.slot,
    required this.graph,
    required this.repository,
    required this.habitRepository,
    required this.habitStreakRepository,
    required this.numericalHeatmapRepository,
    required this.rewardsController,
  });

  final int slot;
  final SpecialHabitGraph? graph;
  final CustomGraphRepository repository;
  final HabitRepository habitRepository;
  final HabitStreakRepository habitStreakRepository;
  final NumericalHeatmapRepository numericalHeatmapRepository;
  final RewardsController rewardsController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final lineColor = slot == 0
        ? theme.colorScheme.primary
        : theme.colorScheme.secondary;
    return Material(
      color: isDark ? const Color(0xFF24272E) : const Color(0xFFF0F2F5),
      borderRadius: BorderRadius.circular(22),
      elevation: isDark ? 0 : 2,
      shadowColor: theme.colorScheme.primary.withValues(alpha: .18),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () => graph == null
            ? _openPicker(context)
            : _openDetail(context, graph!, lineColor),
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
                          useBars: graph!.unitKey != null,
                          lineColor: lineColor,
                          gridColor: theme.colorScheme.outlineVariant,
                          labelColor: theme.colorScheme.onSurface,
                        ),
                      ),
              ),
              if (graph != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${graph!.days.first.day.day}',
                      style: theme.textTheme.labelMedium,
                    ),
                    Text(
                      '${graph!.days.last.day.day}',
                      style: theme.textTheme.labelMedium,
                    ),
                  ],
                ),
            ],
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
        graph: graph,
        repository: repository,
        rewardsController: rewardsController,
      ),
    );
  }

  Future<void> _openDetail(
    BuildContext context,
    SpecialHabitGraph graph,
    Color lineColor,
  ) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _SpecialHabitGraphFullPage(
          title: context.tr(graph.habitNameKey),
          graph: graph,
          lineColor: lineColor,
          habitRepository: habitRepository,
          habitStreakRepository: habitStreakRepository,
          numericalHeatmapRepository: numericalHeatmapRepository,
          rewardsController: rewardsController,
          onEdit: () => _openPicker(context),
          historyLoader: rewardsController.isPlus
              ? (endingOn, dayCount) async {
                  final graphs = await repository
                      .watchSpecialHabitGraphs(
                        endingOn: endingOn,
                        dayCount: dayCount,
                      )
                      .first;
                  for (final candidate in graphs) {
                    if (candidate.slot == slot) return candidate;
                  }
                  return null;
                }
              : null,
        ),
      ),
    );
  }
}

class _SpecialHabitPicker extends StatefulWidget {
  const _SpecialHabitPicker({
    required this.slot,
    required this.graph,
    required this.repository,
    required this.rewardsController,
  });

  final int slot;
  final SpecialHabitGraph? graph;
  final CustomGraphRepository repository;
  final RewardsController rewardsController;

  @override
  State<_SpecialHabitPicker> createState() => _SpecialHabitPickerState();
}

class _SpecialHabitPickerState extends State<_SpecialHabitPicker> {
  late Future<List<CustomGraphHabit>> _habits;
  late String? _selectedHabitId;
  late final TextEditingController _completedController;
  late final TextEditingController _missedController;
  String? _error;

  @override
  void initState() {
    super.initState();
    _habits = widget.repository.loadHabits();
    _selectedHabitId = widget.graph?.habitId;
    _completedController = TextEditingController(
      text: '${widget.graph?.completedValue ?? 1}',
    );
    _missedController = TextEditingController(
      text: '${widget.graph?.missedValue ?? -1}',
    );
  }

  @override
  void dispose() {
    _completedController.dispose();
    _missedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        18,
        12,
        18,
        MediaQuery.viewInsetsOf(context).bottom + 18,
      ),
      child: SingleChildScrollView(
        child: FutureBuilder<List<CustomGraphHabit>>(
          future: _habits,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox(
                height: 220,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final habits = snapshot.data!
                .where(
                  (habit) =>
                      planCanUseHabit(widget.rewardsController.plan, habit.id),
                )
                .toList();
            CustomGraphHabit? selectedHabit;
            for (final habit in habits) {
              if (habit.id == _selectedHabitId) selectedHabit = habit;
            }
            final config = selectedHabit?.numericalTrackingEnabled == true
                ? numericalConfigForHabit(
                    habitId: selectedHabit!.id,
                    category: selectedHabit.category,
                    unitKey: selectedHabit.numericalUnit,
                  )
                : null;
            final unit = config == null
                ? context.tr('Points ').trim()
                : context.tr(config.unitKey);
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SheetDismissHandle(),
                const SizedBox(height: 8),
                Text(
                  context.tr('Choose special habit'),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String?>(
                  initialValue: _selectedHabitId,
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
                    setState(() {
                      _selectedHabitId = habitId;
                      _error = null;
                      if (habitId != null) {
                        final habit = habits.firstWhere(
                          (habit) => habit.id == habitId,
                        );
                        final isUnwanted =
                            habit.category == 'reduction' ||
                            habit.category == 'custom_bad';
                        _completedController.text = isUnwanted ? '-1' : '1';
                        _missedController.text = isUnwanted ? '1' : '-1';
                      }
                    });
                  },
                ),
                if (_selectedHabitId != null) ...[
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _completedController,
                          keyboardType: const TextInputType.numberWithOptions(
                            signed: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^-?\d*'),
                            ),
                          ],
                          decoration: InputDecoration(
                            labelText: context.tr('If completed'),
                            suffixText: unit,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _missedController,
                          keyboardType: const TextInputType.numberWithOptions(
                            signed: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^-?\d*'),
                            ),
                          ],
                          decoration: InputDecoration(
                            labelText: context.tr('If missed'),
                            suffixText: unit,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (config != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      '${context.tr('Numerical entries use their recorded value. Thumbs use these fallback values.')} ($unit)',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
                if (_error != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    _error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(context.tr('Cancel')),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () => _save(context),
                        child: Text(context.tr('Save graph')),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _save(BuildContext context) async {
    final habitId = _selectedHabitId;
    final completedValue = int.tryParse(_completedController.text);
    final missedValue = int.tryParse(_missedController.text);
    if (habitId != null && (completedValue == null || missedValue == null)) {
      setState(() => _error = context.tr('Enter valid whole numbers.'));
      return;
    }
    final changed =
        habitId != widget.graph?.habitId ||
        completedValue != widget.graph?.completedValue ||
        missedValue != widget.graph?.missedValue;
    if (!changed) {
      Navigator.of(context).pop();
      return;
    }
    final gate = _specialGraphGate(widget.rewardsController.plan, widget.slot);
    final requiresPayment =
        gate != null && !widget.rewardsController.isPaidExtensionUnlocked(gate);
    if (requiresPayment) {
      final paid = await confirmTokenOrAdPurchase(
        context,
        controller: widget.rewardsController,
        amount: 35,
        reason: 'special-graph-${widget.slot}',
        title: context.tr('Do you want to change this graph?'),
        chargePlus: widget.rewardsController.isPlan(MembershipPlan.plus),
      );
      if (!paid) return;
      await widget.rewardsController.repository.unlockFeatureAfterPayment(gate);
      await widget.rewardsController.refresh();
    }
    await widget.repository.saveSpecialHabit(
      slot: widget.slot,
      habitId: habitId,
      completedValue: completedValue ?? 1,
      missedValue: missedValue ?? -1,
    );
    if (context.mounted) Navigator.of(context).pop();
  }
}

class _CustomGraphEditorState extends State<CustomGraphEditor> {
  late final List<_EditableRule> _slots;
  final Map<int, String?> _originalHabits = {};
  List<CustomGraphHabit> _habits = const [];
  bool _loading = true;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _slots = [];
    _load();
  }

  Future<void> _load() async {
    try {
      final results = await Future.wait([
        widget.repository.loadHabits(),
        widget.repository.loadRules(),
      ]);
      final allHabits = results[0] as List<CustomGraphHabit>;
      final habits = allHabits
          .where(
            (habit) => planCanUseHabit(widget.rewardsController.plan, habit.id),
          )
          .toList();
      final rules = results[1] as List<CustomGraphRule>;
      final sortedRules = [...rules]..sort((a, b) => a.slot.compareTo(b.slot));
      final visibleRules =
          widget.rewardsController.hasUnlimitedCustomGraphHabits
          ? sortedRules
          : sortedRules.take(widget.rewardsController.customGraphLimit);
      for (final rule in visibleRules) {
        final editable = _EditableRule(slot: _slots.length)
          ..habitId = rule.habitId
          ..completedPoints = '${rule.completedPoints}'
          ..missedPoints = '${rule.missedPoints}';
        _slots.add(editable);
        _originalHabits[editable.slot] = rule.habitId;
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
            const SheetDismissHandle(),
            const SizedBox(height: 8),
            Text(
              context.tr('Customize graph'),
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${context.tr('Choose up to')} ${widget.rewardsController.hasUnlimitedCustomGraphHabits ? '∞' : widget.rewardsController.customGraphLimit} ${context.tr('habits and set their point values.')}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            if (_loading)
              const Center(child: CircularProgressIndicator())
            else
              for (final slot in _slots) ...[
                if (!widget.rewardsController.isPlus) ...[
                  const TokenChip(amount: 35, compact: true),
                  const SizedBox(height: 7),
                ],
                _RuleEditor(
                  key: ValueKey('customGraphSlot${slot.slot}'),
                  number: slot.slot + 1,
                  slot: slot,
                  habits: _habits,
                  showCost:
                      widget.rewardsController.paidCustomGraphSlotStart !=
                          null &&
                      slot.slot >=
                          widget.rewardsController.paidCustomGraphSlotStart!,
                  onChanged: () => setState(() => _error = null),
                ),
                const SizedBox(height: 10),
              ],
            if (!_loading) ...[
              SizedBox(
                width: double.infinity,
                child: FilledButton.tonalIcon(
                  onPressed: _addSlot,
                  icon: const Icon(Icons.add_rounded),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(context.tr('Add habit slot')),
                  ),
                ),
              ),
              const SizedBox(height: 14),
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
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _saving
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: Text(context.tr('Cancel')),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
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
          ],
        ),
      ),
    );
  }

  void _addSlot() {
    final unlimited = widget.rewardsController.hasUnlimitedCustomGraphHabits;
    if (!unlimited &&
        _slots.length >= widget.rewardsController.customGraphLimit) {
      _openNextGraphPlan(context, widget.rewardsController);
      return;
    }
    setState(() {
      _slots.add(_EditableRule(slot: _slots.length));
      _error = null;
    });
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
      final changedSlots = _slots
          .where((slot) => _originalHabits[slot.slot] != slot.habitId)
          .toList();
      final paidStart = widget.rewardsController.paidCustomGraphSlotStart;
      final paidSlots = paidStart == null
          ? const <_EditableRule>[]
          : changedSlots.where((slot) => slot.slot >= paidStart).toList();
      if (paidSlots.isNotEmpty) {
        final paid = await confirmTokenOrAdPurchase(
          context,
          controller: widget.rewardsController,
          amount: paidSlots.length * 35,
          reason: 'custom-graph-habits',
          title: context.tr('Do you want to change these graph habits?'),
          chargePlus: widget.rewardsController.isPlan(MembershipPlan.plus),
        );
        if (!paid) {
          if (!mounted) return;
          setState(() {
            _saving = false;
            _error = context.tr(
              'You do not have enough tokens for these graph changes.',
            );
          });
          return;
        }
      }
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
    required this.showCost,
    required this.onChanged,
    super.key,
  });

  final int number;
  final _EditableRule slot;
  final List<CustomGraphHabit> habits;
  final bool showCost;
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
          if (showCost) ...[
            const TokenChip(amount: 35, compact: true),
            const SizedBox(height: 8),
          ],
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
                final isReduction =
                    habit.category == 'reduction' ||
                    habit.category == 'custom_bad';
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

enum _GraphViewRange { daily, weekly, monthly, yearly }

extension on _GraphViewRange {
  String get labelKey => switch (this) {
    _GraphViewRange.daily => 'Daily',
    _GraphViewRange.weekly => 'Weekly',
    _GraphViewRange.monthly => 'Monthly',
    _GraphViewRange.yearly => 'Yearly',
  };
}

class _GraphGradientTitle extends StatelessWidget {
  const _GraphGradientTitle({
    required this.text,
    this.colors = const [
      Color(0xFF22C1C3),
      Color(0xFF7C4DFF),
      Color(0xFFFF7A59),
    ],
  });

  final String text;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors,
      ).createShader(bounds),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _CustomGraphFullPage extends StatefulWidget {
  const _CustomGraphFullPage({
    required this.title,
    required this.snapshot,
    required this.onEdit,
    required this.historyLoader,
  });

  final String title;
  final CustomGraphSnapshot snapshot;
  final Future<void> Function() onEdit;
  final Future<CustomGraphSnapshot?> Function(DateTime endingOn, int dayCount)?
  historyLoader;

  @override
  State<_CustomGraphFullPage> createState() => _CustomGraphFullPageState();
}

class _CustomGraphFullPageState extends State<_CustomGraphFullPage> {
  late final Set<String> _visibleHabitIds;
  final ScrollController _graphScrollController = ScrollController();
  late CustomGraphSnapshot _snapshot;
  late DateTime _endingOn;
  _GraphViewRange _range = _GraphViewRange.daily;
  bool _loadingHistory = false;
  int? _selectedGraphIndex;
  bool _scrubbingGraph = false;

  String get title => widget.title;
  CustomGraphSnapshot get snapshot => _snapshot;

  @override
  void initState() {
    super.initState();
    _snapshot = widget.snapshot;
    _endingOn = _snapshot.days.last.day;
    _visibleHabitIds = {for (final rule in snapshot.rules) rule.habitId};
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadContinuousHistory();
    });
  }

  @override
  void dispose() {
    _graphScrollController.dispose();
    super.dispose();
  }

  CustomGraphSnapshot get _visibleSnapshot => CustomGraphSnapshot(
    rules: [
      for (final rule in snapshot.rules)
        if (_visibleHabitIds.contains(rule.habitId)) rule,
    ],
    days: [
      for (final day in snapshot.days)
        CustomGraphDay(
          day: day.day,
          values: {
            for (final entry in day.values.entries)
              if (_visibleHabitIds.contains(entry.key)) entry.key: entry.value,
          },
        ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: _GraphGradientTitle(text: title),
        actions: [
          IconButton(
            key: const Key('editCustomGraphButton'),
            icon: const Icon(Icons.tune_rounded),
            onPressed: widget.onEdit,
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
          children: [
            _GraphRangeSelector(
              selected: _range,
              premiumEnabled: widget.historyLoader != null,
              onSelected: _selectRange,
            ),
            const SizedBox(height: 14),
            TapRegion(
              onTapOutside: (_) {
                if (_selectedGraphIndex == null) return;
                setState(() => _selectedGraphIndex = null);
              },
              child: _ContinuousCustomGraphViewport(
                snapshot: _visibleSnapshot,
                range: _range,
                controller: _graphScrollController,
                lineColor: theme.colorScheme.primary,
                gridColor: theme.colorScheme.outlineVariant,
                zeroColor: theme.colorScheme.onSurfaceVariant,
                labelColor: theme.colorScheme.onSurface,
                isDark: isDark,
                selectedIndex: _selectedGraphIndex,
                onSelected: (index) => setState(() {
                  _selectedGraphIndex = index;
                }),
                scrollEnabled: !_scrubbingGraph,
                onScrubChanged: (scrubbing) => setState(() {
                  _scrubbingGraph = scrubbing;
                }),
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.rules.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 72,
              ),
              itemBuilder: (context, index) {
                final rule = snapshot.rules[index];
                final visible = _visibleHabitIds.contains(rule.habitId);
                return _GraphHabitToggleCard(
                  rule: rule,
                  selected: visible,
                  onTap: () => setState(() {
                    if (visible) {
                      _visibleHabitIds.remove(rule.habitId);
                    } else {
                      _visibleHabitIds.add(rule.habitId);
                    }
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadContinuousHistory() async {
    final loader = widget.historyLoader;
    if (loader == null || _loadingHistory) return;
    setState(() => _loadingHistory = true);
    final loaded = await loader(_endingOn, _continuousGraphHistoryDays);
    if (!mounted) return;
    setState(() {
      _loadingHistory = false;
      if (loaded != null) {
        _snapshot = _aggregateCustomSnapshot(loaded, _range);
        _selectedGraphIndex = null;
        final available = {for (final rule in loaded.rules) rule.habitId};
        _visibleHabitIds.removeWhere((habitId) => !available.contains(habitId));
        if (_visibleHabitIds.isEmpty) _visibleHabitIds.addAll(available);
      }
    });
    _scrollGraphToLatest(_graphScrollController);
  }

  Future<void> _selectRange(_GraphViewRange range) async {
    if (range == _range || _loadingHistory) return;
    if (range != _GraphViewRange.daily && widget.historyLoader == null) return;
    final loader = widget.historyLoader;
    if (range == _GraphViewRange.daily && loader == null) {
      setState(() => _range = range);
      return;
    }
    if (loader == null) return;
    setState(() => _loadingHistory = true);
    final loaded = await loader(_endingOn, _continuousGraphHistoryDays);
    if (!mounted) return;
    setState(() {
      _loadingHistory = false;
      if (loaded != null) {
        _range = range;
        _snapshot = _aggregateCustomSnapshot(loaded, range);
        _selectedGraphIndex = null;
      }
    });
    _scrollGraphToLatest(_graphScrollController);
  }
}

class _GraphHabitToggleCard extends StatelessWidget {
  const _GraphHabitToggleCard({
    required this.rule,
    required this.selected,
    required this.onTap,
  });

  final CustomGraphRule rule;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foreground = selected
        ? theme.colorScheme.onPrimaryContainer
        : theme.colorScheme.onSurfaceVariant;
    return Material(
      color: selected
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          child: Row(
            children: [
              Icon(_graphHabitIcon(rule.habitId), size: 22, color: foreground),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  context.tr(rule.habitNameKey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: foreground,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                selected ? Icons.check_circle_rounded : Icons.cancel_rounded,
                size: 21,
                color: selected ? theme.colorScheme.primary : foreground,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

IconData _graphHabitIcon(String habitId) {
  return switch (habitId) {
    'water' => Icons.water_drop_rounded,
    'healthy_eating' => Icons.eco_rounded,
    'studying' => Icons.school_rounded,
    'brushing_teeth' => Icons.cleaning_services_rounded,
    'skin_care' => Icons.face_retouching_natural_rounded,
    'good_sleep' => Icons.bedtime_rounded,
    'meditation' || 'masturbation' => Icons.self_improvement_rounded,
    'reading' => Icons.menu_book_rounded,
    'consistent_routine' => Icons.event_repeat_rounded,
    'practising_gratitude' => Icons.favorite_rounded,
    'productive_work' => Icons.work_rounded,
    'workout_arms' => Icons.fitness_center_rounded,
    'workout_shoulders' => Icons.accessibility_new_rounded,
    'workout_back' => Icons.airline_seat_flat_rounded,
    'workout_chest' => Icons.monitor_heart_outlined,
    'workout_abs' => Icons.grid_view_rounded,
    'workout_legs' => Icons.directions_run_rounded,
    'smoking' => Icons.smoke_free_rounded,
    'vaping' => Icons.air_rounded,
    'alcohol' => Icons.local_bar_rounded,
    'unhealthy_eating' => Icons.fastfood_rounded,
    'adult_videos' => Icons.visibility_off_rounded,
    'consuming_sugar' => Icons.cake_rounded,
    'excessive_screen_time' => Icons.phone_android_rounded,
    'excessive_caffeine' => Icons.coffee_rounded,
    'social_media_overuse' => Icons.groups_rounded,
    'nail_biting' => Icons.back_hand_rounded,
    'gaming_overuse' => Icons.sports_esports_rounded,
    _ => Icons.track_changes_rounded,
  };
}

class _SpecialHabitGraphFullPage extends StatefulWidget {
  const _SpecialHabitGraphFullPage({
    required this.title,
    required this.graph,
    required this.lineColor,
    required this.habitRepository,
    required this.habitStreakRepository,
    required this.numericalHeatmapRepository,
    required this.rewardsController,
    required this.onEdit,
    required this.historyLoader,
  });

  final String title;
  final SpecialHabitGraph graph;
  final Color lineColor;
  final HabitRepository habitRepository;
  final HabitStreakRepository habitStreakRepository;
  final NumericalHeatmapRepository numericalHeatmapRepository;
  final RewardsController rewardsController;
  final Future<void> Function() onEdit;
  final Future<SpecialHabitGraph?> Function(DateTime endingOn, int dayCount)?
  historyLoader;

  @override
  State<_SpecialHabitGraphFullPage> createState() =>
      _SpecialHabitGraphFullPageState();
}

class _SpecialHabitGraphFullPageState
    extends State<_SpecialHabitGraphFullPage> {
  final ScrollController _graphScrollController = ScrollController();
  late SpecialHabitGraph _graph;
  late DateTime _endingOn;
  _GraphViewRange _range = _GraphViewRange.daily;
  bool _loadingHistory = false;
  int? _selectedGraphIndex;
  bool _scrubbingGraph = false;

  String get title => widget.title;
  SpecialHabitGraph get graph => _graph;
  Color get lineColor => widget.lineColor;

  @override
  void initState() {
    super.initState();
    _graph = widget.graph;
    _endingOn = _graph.days.last.day;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadContinuousHistory();
    });
  }

  @override
  void dispose() {
    _graphScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: _GraphGradientTitle(
          text: title,
          colors: [lineColor, const Color(0xFF8B5CF6), const Color(0xFFF59E0B)],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            onPressed: widget.onEdit,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _GraphRangeSelector(
                  selected: _range,
                  premiumEnabled: widget.historyLoader != null,
                  onSelected: _selectRange,
                ),
                const SizedBox(height: 14),
                TapRegion(
                  onTapOutside: (_) {
                    if (_selectedGraphIndex == null) return;
                    setState(() => _selectedGraphIndex = null);
                  },
                  child: _ContinuousSpecialGraphViewport(
                    graph: graph,
                    range: _range,
                    controller: _graphScrollController,
                    lineColor: lineColor,
                    gridColor: theme.colorScheme.outlineVariant,
                    labelColor: theme.colorScheme.onSurface,
                    isDark: isDark,
                    selectedIndex: _selectedGraphIndex,
                    onSelected: (index) => setState(() {
                      _selectedGraphIndex = index;
                    }),
                    scrollEnabled: !_scrubbingGraph,
                    onScrubChanged: (scrubbing) => setState(() {
                      _scrubbingGraph = scrubbing;
                    }),
                  ),
                ),
                const SizedBox(height: 16),
                _GraphLegend(
                  color: lineColor,
                  label: graph.unitKey == null
                      ? title
                      : '$title (${context.tr(graph.unitKey!)})',
                ),
                HabitStreakSection(
                  repository: widget.habitStreakRepository,
                  habitRepository: widget.habitRepository,
                  rewardsController: widget.rewardsController,
                  habitId: graph.habitId,
                ),
                if (graph.unitKey != null)
                  NumericalHeatmapSection(
                    repository: widget.numericalHeatmapRepository,
                    rewardsController: widget.rewardsController,
                    habitId: graph.habitId,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadContinuousHistory() async {
    final loader = widget.historyLoader;
    if (loader == null || _loadingHistory) return;
    setState(() => _loadingHistory = true);
    final loaded = await loader(_endingOn, _continuousGraphHistoryDays);
    if (!mounted) return;
    setState(() {
      _loadingHistory = false;
      if (loaded != null) {
        _graph = _aggregateSpecialGraph(loaded, _range);
        _selectedGraphIndex = null;
      }
    });
    _scrollGraphToLatest(_graphScrollController);
  }

  Future<void> _selectRange(_GraphViewRange range) async {
    if (range == _range || _loadingHistory) return;
    if (range != _GraphViewRange.daily && widget.historyLoader == null) return;
    final loader = widget.historyLoader;
    if (loader == null) return;
    setState(() => _loadingHistory = true);
    final loaded = await loader(_endingOn, _continuousGraphHistoryDays);
    if (!mounted) return;
    setState(() {
      _loadingHistory = false;
      if (loaded != null) {
        _range = range;
        _graph = _aggregateSpecialGraph(loaded, range);
        _selectedGraphIndex = null;
      }
    });
    _scrollGraphToLatest(_graphScrollController);
  }
}

const int _continuousGraphHistoryDays = 3660;
const double _continuousGraphPointSpacing = 46;

void _scrollGraphToLatest(ScrollController controller) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!controller.hasClients) return;
    controller.jumpTo(controller.position.maxScrollExtent);
  });
}

class _GraphTapSelectionLayer extends StatefulWidget {
  const _GraphTapSelectionLayer({
    required this.width,
    required this.pointCount,
    required this.selectedIndex,
    required this.selectedValue,
    required this.color,
    required this.onSelected,
    required this.values,
    required this.verticalInset,
    required this.onScrubChanged,
    required this.child,
    this.minimumAtZero = false,
  });

  final double width;
  final int pointCount;
  final int? selectedIndex;
  final double? selectedValue;
  final Color color;
  final ValueChanged<int> onSelected;
  final List<double> values;
  final double verticalInset;
  final ValueChanged<bool> onScrubChanged;
  final Widget child;
  final bool minimumAtZero;

  @override
  State<_GraphTapSelectionLayer> createState() =>
      _GraphTapSelectionLayerState();
}

class _GraphTapSelectionLayerState extends State<_GraphTapSelectionLayer> {
  int? _scrubPointer;

  double _xForIndex(int index) {
    if (widget.pointCount <= 1) return widget.width / 2;
    const leftInset = 42.0;
    const rightInset = 7.0;
    return leftInset +
        (widget.width - leftInset - rightInset) *
            index /
            (widget.pointCount - 1);
  }

  double _fractionForX(double x) {
    if (widget.pointCount <= 1) return 0;
    const leftInset = 42.0;
    const rightInset = 7.0;
    return ((x - leftInset) / (widget.width - leftInset - rightInset)).clamp(
      0.0,
      1.0,
    );
  }

  int _indexForX(double x) =>
      (_fractionForX(x) * math.max(0, widget.pointCount - 1)).round();

  double _lineValueAt(double fraction) {
    if (widget.values.isEmpty) return 0;
    if (widget.values.length == 1) return widget.values.first;
    final position = fraction * (widget.values.length - 1);
    final lower = position.floor();
    final upper = math.min(widget.values.length - 1, lower + 1);
    final amount = position - lower;
    return widget.values[lower] +
        (widget.values[upper] - widget.values[lower]) * amount;
  }

  double _lineYAt(double x, double plotHeight) {
    final scaleValues = [0.0, ...widget.values];
    var minimum = scaleValues.reduce(math.min);
    var maximum = scaleValues.reduce(math.max);
    if (widget.minimumAtZero) {
      minimum = 0;
      maximum = math.max(1, maximum);
    } else if (minimum == maximum) {
      minimum -= 1;
      maximum += 1;
    }
    final value = _lineValueAt(_fractionForX(x));
    return widget.verticalInset +
        (maximum - value) /
            (maximum - minimum) *
            (plotHeight - widget.verticalInset * 2);
  }

  void _handlePointerDown(PointerDownEvent event) {
    if (widget.pointCount == 0) return;
    final plotHeight = math.max(1.0, (context.size?.height ?? 1) - 24);
    if (event.localPosition.dy > plotHeight) return;
    final lineY = _lineYAt(event.localPosition.dx, plotHeight);
    if ((event.localPosition.dy - lineY).abs() > 30) return;
    _scrubPointer = event.pointer;
    widget.onScrubChanged(true);
    widget.onSelected(_indexForX(event.localPosition.dx));
  }

  void _handlePointerMove(PointerMoveEvent event) {
    if (_scrubPointer != event.pointer) return;
    widget.onSelected(_indexForX(event.localPosition.dx));
  }

  void _finishScrub(int pointer) {
    if (_scrubPointer != pointer) return;
    _scrubPointer = null;
    widget.onScrubChanged(false);
  }

  @override
  Widget build(BuildContext context) {
    final validSelection =
        widget.selectedIndex != null &&
        widget.selectedIndex! >= 0 &&
        widget.selectedIndex! < widget.pointCount &&
        widget.selectedValue != null;
    final selectedX = validSelection ? _xForIndex(widget.selectedIndex!) : 0.0;
    final tooltipLeft = math.max(
      0.0,
      math.min(widget.width - 66, selectedX - 33),
    );
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: _handlePointerDown,
      onPointerMove: _handlePointerMove,
      onPointerUp: (event) => _finishScrub(event.pointer),
      onPointerCancel: (event) => _finishScrub(event.pointer),
      child: Stack(
        fit: StackFit.expand,
        children: [
          widget.child,
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 240),
                reverseDuration: const Duration(milliseconds: 240),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                child: validSelection
                    ? Stack(
                        key: const ValueKey('graph-selection-visible'),
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            left: selectedX - .75,
                            top: 0,
                            bottom: 24,
                            child: Container(
                              width: 1.5,
                              color: widget.color.withValues(alpha: .78),
                            ),
                          ),
                          Positioned(
                            left: tooltipLeft,
                            top: 0,
                            child: Container(
                              width: 66,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: widget.color,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                _formatGraphSelectionValue(
                                  widget.selectedValue!,
                                ),
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.expand(
                        key: ValueKey('graph-selection-hidden'),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _formatGraphSelectionValue(double value) {
  final rounded = value.round();
  return (value - rounded).abs() < .001
      ? '$rounded'
      : value
            .toStringAsFixed(2)
            .replaceFirst(RegExp(r'0+$'), '')
            .replaceFirst(RegExp(r'\.$'), '');
}

class _ContinuousCustomGraphViewport extends StatelessWidget {
  const _ContinuousCustomGraphViewport({
    required this.snapshot,
    required this.range,
    required this.controller,
    required this.lineColor,
    required this.gridColor,
    required this.zeroColor,
    required this.labelColor,
    required this.isDark,
    required this.selectedIndex,
    required this.onSelected,
    required this.scrollEnabled,
    required this.onScrubChanged,
  });

  final CustomGraphSnapshot snapshot;
  final _GraphViewRange range;
  final ScrollController controller;
  final Color lineColor;
  final Color gridColor;
  final Color zeroColor;
  final Color labelColor;
  final bool isDark;
  final int? selectedIndex;
  final ValueChanged<int> onSelected;
  final bool scrollEnabled;
  final ValueChanged<bool> onScrubChanged;

  @override
  Widget build(BuildContext context) {
    final cardColor = isDark
        ? const Color(0xFF24272E)
        : const Color(0xFFF0F2F5);
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 3,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: lineColor.withValues(alpha: .14),
                blurRadius: 18,
                offset: const Offset(0, 7),
              ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = math.max(
              constraints.maxWidth,
              49 +
                  math.max(0, snapshot.days.length - 1) *
                      _continuousGraphPointSpacing,
            );
            return Stack(
              children: [
                SingleChildScrollView(
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  physics: scrollEnabled
                      ? const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        )
                      : const NeverScrollableScrollPhysics(),
                  child: SizedBox(
                    width: width,
                    height: constraints.maxHeight,
                    child: _GraphTapSelectionLayer(
                      width: width,
                      pointCount: snapshot.days.length,
                      selectedIndex: selectedIndex,
                      selectedValue:
                          selectedIndex != null &&
                              selectedIndex! < snapshot.days.length
                          ? snapshot.days[selectedIndex!].total.toDouble()
                          : null,
                      color: lineColor,
                      onSelected: onSelected,
                      values: [
                        for (final day in snapshot.days) day.total.toDouble(),
                      ],
                      verticalInset: 7,
                      onScrubChanged: onScrubChanged,
                      child: Column(
                        children: [
                          Expanded(
                            child: CustomPaint(
                              size: Size.infinite,
                              painter: _CustomGraphPainter(
                                snapshot: snapshot,
                                lineColor: lineColor,
                                gridColor: gridColor,
                                zeroColor: zeroColor,
                                labelColor: labelColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          _ContinuousGraphXAxis(
                            days: [for (final day in snapshot.days) day.day],
                            range: range,
                            color: labelColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 24,
                  width: 42,
                  child: ColoredBox(
                    color: cardColor,
                    child: CustomPaint(
                      painter: _GraphYAxisPainter(
                        values: [
                          0,
                          for (final day in snapshot.days) day.total.toDouble(),
                        ],
                        rowCount: 3,
                        verticalInset: 7,
                        labelColor: labelColor,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ContinuousSpecialGraphViewport extends StatelessWidget {
  const _ContinuousSpecialGraphViewport({
    required this.graph,
    required this.range,
    required this.controller,
    required this.lineColor,
    required this.gridColor,
    required this.labelColor,
    required this.isDark,
    required this.selectedIndex,
    required this.onSelected,
    required this.scrollEnabled,
    required this.onScrubChanged,
  });

  final SpecialHabitGraph graph;
  final _GraphViewRange range;
  final ScrollController controller;
  final Color lineColor;
  final Color gridColor;
  final Color labelColor;
  final bool isDark;
  final int? selectedIndex;
  final ValueChanged<int> onSelected;
  final bool scrollEnabled;
  final ValueChanged<bool> onScrubChanged;

  @override
  Widget build(BuildContext context) {
    final cardColor = isDark
        ? const Color(0xFF24272E)
        : const Color(0xFFF0F2F5);
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 3,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: lineColor.withValues(alpha: .14),
                blurRadius: 18,
                offset: const Offset(0, 7),
              ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final useBars = graph.unitKey != null;
            double displayValue(SpecialHabitGraphDay day) => useBars
                ? math.max(0, day.count).toDouble()
                : day.count.toDouble();
            final width = math.max(
              constraints.maxWidth,
              49 +
                  math.max(0, graph.days.length - 1) *
                      _continuousGraphPointSpacing,
            );
            return Stack(
              children: [
                SingleChildScrollView(
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  physics: scrollEnabled
                      ? const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        )
                      : const NeverScrollableScrollPhysics(),
                  child: SizedBox(
                    width: width,
                    height: constraints.maxHeight,
                    child: _GraphTapSelectionLayer(
                      width: width,
                      pointCount: graph.days.length,
                      selectedIndex: selectedIndex,
                      selectedValue:
                          selectedIndex != null &&
                              selectedIndex! < graph.days.length
                          ? displayValue(graph.days[selectedIndex!])
                          : null,
                      color: lineColor,
                      onSelected: onSelected,
                      values: [for (final day in graph.days) displayValue(day)],
                      verticalInset: 5,
                      onScrubChanged: onScrubChanged,
                      minimumAtZero: useBars,
                      child: Column(
                        children: [
                          Expanded(
                            child: CustomPaint(
                              size: Size.infinite,
                              painter: _SpecialHabitGraphPainter(
                                days: graph.days,
                                useBars: useBars,
                                lineColor: lineColor,
                                gridColor: gridColor,
                                labelColor: labelColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          _ContinuousGraphXAxis(
                            days: [for (final day in graph.days) day.day],
                            range: range,
                            color: labelColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 24,
                  width: 42,
                  child: ColoredBox(
                    color: cardColor,
                    child: CustomPaint(
                      painter: _GraphYAxisPainter(
                        values: [
                          0,
                          for (final day in graph.days) displayValue(day),
                        ],
                        rowCount: 2,
                        verticalInset: 5,
                        labelColor: labelColor,
                        minimumAtZero: useBars,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _GraphRangeSelector extends StatelessWidget {
  const _GraphRangeSelector({
    required this.selected,
    required this.premiumEnabled,
    required this.onSelected,
  });

  final _GraphViewRange selected;
  final bool premiumEnabled;
  final ValueChanged<_GraphViewRange> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: .74,
            ),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            children: [
              for (final range in _GraphViewRange.values)
                Expanded(
                  child: Opacity(
                    opacity: range == _GraphViewRange.daily || premiumEnabled
                        ? 1
                        : .45,
                    child: Material(
                      color: selected == range
                          ? theme.colorScheme.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(999),
                      child: InkWell(
                        onTap: range == _GraphViewRange.daily || premiumEnabled
                            ? () => onSelected(range)
                            : null,
                        borderRadius: BorderRadius.circular(999),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 11,
                          ),
                          child: Text(
                            context.tr(range.labelKey),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: selected == range
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

CustomGraphSnapshot _aggregateCustomSnapshot(
  CustomGraphSnapshot source,
  _GraphViewRange range,
) {
  if (range == _GraphViewRange.daily) return source;
  final bucketDays = <Object, DateTime>{};
  final bucketValues = <Object, Map<String, int>>{};
  for (var index = 0; index < source.days.length; index++) {
    final day = source.days[index];
    final key = _graphBucketKey(day.day, index, range);
    bucketDays[key] = day.day;
    final values = bucketValues.putIfAbsent(key, () => <String, int>{});
    for (final entry in day.values.entries) {
      values.update(
        entry.key,
        (current) => current + entry.value,
        ifAbsent: () => entry.value,
      );
    }
  }
  return CustomGraphSnapshot(
    rules: source.rules,
    days: [
      for (final key in bucketDays.keys)
        CustomGraphDay(day: bucketDays[key]!, values: bucketValues[key]!),
    ],
  );
}

SpecialHabitGraph _aggregateSpecialGraph(
  SpecialHabitGraph source,
  _GraphViewRange range,
) {
  if (range == _GraphViewRange.daily) return source;
  final bucketDays = <Object, DateTime>{};
  final bucketValues = <Object, int>{};
  for (var index = 0; index < source.days.length; index++) {
    final day = source.days[index];
    final key = _graphBucketKey(day.day, index, range);
    bucketDays[key] = day.day;
    bucketValues.update(
      key,
      (current) => current + day.count,
      ifAbsent: () => day.count,
    );
  }
  return SpecialHabitGraph(
    slot: source.slot,
    habitId: source.habitId,
    habitNameKey: source.habitNameKey,
    completedValue: source.completedValue,
    missedValue: source.missedValue,
    unitKey: source.unitKey,
    days: [
      for (final key in bucketDays.keys)
        SpecialHabitGraphDay(day: bucketDays[key]!, count: bucketValues[key]!),
    ],
  );
}

Object _graphBucketKey(DateTime day, int index, _GraphViewRange range) {
  return switch (range) {
    _GraphViewRange.daily => index,
    _GraphViewRange.weekly => index ~/ 7,
    _GraphViewRange.monthly => (day.year * 100) + day.month,
    _GraphViewRange.yearly => day.year,
  };
}

String _graphAxisLabel(DateTime day, _GraphViewRange range) {
  return switch (range) {
    _GraphViewRange.daily => '${day.day}',
    _GraphViewRange.weekly => '${day.day}/${day.month}',
    _GraphViewRange.monthly => '${day.month}',
    _GraphViewRange.yearly => '${day.year}',
  };
}

// ignore: unused_element
class _GraphXAxis extends StatelessWidget {
  const _GraphXAxis({required this.days, required this.range});

  final List<DateTime> days;
  final _GraphViewRange range;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelMedium;
    return Row(
      children: [
        for (final day in days)
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                _graphAxisLabel(day, range),
                maxLines: 1,
                style: style,
              ),
            ),
          ),
      ],
    );
  }
}

class _ContinuousGraphXAxis extends StatelessWidget {
  const _ContinuousGraphXAxis({
    required this.days,
    required this.range,
    required this.color,
  });

  final List<DateTime> days;
  final _GraphViewRange range;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      width: double.infinity,
      child: CustomPaint(
        painter: _ContinuousGraphXAxisPainter(
          days: days,
          range: range,
          color: color,
        ),
      ),
    );
  }
}

class _ContinuousGraphXAxisPainter extends CustomPainter {
  const _ContinuousGraphXAxisPainter({
    required this.days,
    required this.range,
    required this.color,
  });

  final List<DateTime> days;
  final _GraphViewRange range;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (days.isEmpty) return;
    const leftInset = 42.0;
    const rightInset = 7.0;
    for (var index = 0; index < days.length; index++) {
      final x = days.length == 1
          ? size.width / 2
          : leftInset +
                (size.width - leftInset - rightInset) *
                    index /
                    (days.length - 1);
      final painter = TextPainter(
        text: TextSpan(
          text: _graphAxisLabel(days[index], range),
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 1,
      )..layout();
      painter.paint(canvas, Offset(x - painter.width / 2, 0));
    }
  }

  @override
  bool shouldRepaint(_ContinuousGraphXAxisPainter oldDelegate) =>
      oldDelegate.days != days ||
      oldDelegate.range != range ||
      oldDelegate.color != color;
}

class _GraphYAxisPainter extends CustomPainter {
  const _GraphYAxisPainter({
    required this.values,
    required this.rowCount,
    required this.verticalInset,
    required this.labelColor,
    this.minimumAtZero = false,
  });

  final List<double> values;
  final int rowCount;
  final double verticalInset;
  final Color labelColor;
  final bool minimumAtZero;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;
    var minimum = values.reduce(math.min);
    var maximum = values.reduce(math.max);
    if (minimumAtZero) {
      minimum = 0;
      maximum = math.max(1, maximum);
    } else if (minimum == maximum) {
      minimum -= 1;
      maximum += 1;
    }
    for (var row = 0; row <= rowCount; row++) {
      final y =
          verticalInset + (size.height - verticalInset * 2) * row / rowCount;
      final value = maximum - ((maximum - minimum) * row / rowCount);
      _paintYAxisLabel(canvas, value, y, size.width, labelColor);
    }
  }

  @override
  bool shouldRepaint(_GraphYAxisPainter oldDelegate) =>
      oldDelegate.values != values ||
      oldDelegate.rowCount != rowCount ||
      oldDelegate.verticalInset != verticalInset ||
      oldDelegate.labelColor != labelColor ||
      oldDelegate.minimumAtZero != minimumAtZero;
}

// ignore: unused_element
class _GraphHistoryControls extends StatelessWidget {
  const _GraphHistoryControls({
    required this.firstDay,
    required this.lastDay,
    required this.loading,
    required this.canGoForward,
    required this.onPrevious,
    required this.onNext,
  });

  final DateTime firstDay;
  final DateTime lastDay;
  final bool loading;
  final bool canGoForward;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: loading ? null : onPrevious,
            icon: const Icon(Icons.chevron_left_rounded),
          ),
          Expanded(
            child: loading
                ? const Center(
                    child: SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2.5),
                    ),
                  )
                : Text(
                    '${_shortGraphDate(firstDay)}  –  ${_shortGraphDate(lastDay)}',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
          ),
          IconButton(
            onPressed: loading || !canGoForward ? null : onNext,
            icon: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    );
  }
}

String _shortGraphDate(DateTime value) =>
    '${value.day.toString().padLeft(2, '0')}/'
    '${value.month.toString().padLeft(2, '0')}/${value.year}';

class _CustomGraphPainter extends CustomPainter {
  const _CustomGraphPainter({
    required this.snapshot,
    required this.lineColor,
    required this.gridColor,
    required this.zeroColor,
    required this.labelColor,
  });

  final CustomGraphSnapshot snapshot;
  final Color lineColor;
  final Color gridColor;
  final Color zeroColor;
  final Color labelColor;

  @override
  void paint(Canvas canvas, Size size) {
    const leftInset = 42.0;
    const rightInset = 7.0;
    const verticalInset = 7.0;
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
      final y = verticalInset + ((size.height - verticalInset * 2) * row / 3);
      canvas.drawLine(
        Offset(leftInset, y),
        Offset(size.width - rightInset, y),
        gridPaint,
      );
      final value = maximum - ((maximum - minimum) * row / 3);
      _paintYAxisLabel(canvas, value, y, leftInset, labelColor);
    }

    double xFor(int index) {
      return leftInset +
          (size.width - leftInset - rightInset) *
              index /
              (snapshot.days.length - 1);
    }

    double yFor(num value) {
      return verticalInset +
          (maximum - value) /
              (maximum - minimum) *
              (size.height - verticalInset * 2);
    }

    final zeroY = yFor(0);
    canvas.drawLine(
      Offset(leftInset, zeroY),
      Offset(size.width - rightInset, zeroY),
      Paint()
        ..color = zeroColor.withValues(alpha: .55)
        ..strokeWidth = 1.4,
    );

    final points = <Offset>[];
    for (var dayIndex = 0; dayIndex < snapshot.days.length; dayIndex++) {
      points.add(Offset(xFor(dayIndex), yFor(snapshot.days[dayIndex].total)));
    }
    final path = _smoothGraphPath(points);
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
        oldDelegate.zeroColor != zeroColor ||
        oldDelegate.labelColor != labelColor;
  }
}

class _SpecialHabitGraphPainter extends CustomPainter {
  const _SpecialHabitGraphPainter({
    required this.days,
    required this.useBars,
    required this.lineColor,
    required this.gridColor,
    required this.labelColor,
  });

  final List<SpecialHabitGraphDay> days;
  final bool useBars;
  final Color lineColor;
  final Color gridColor;
  final Color labelColor;

  @override
  void paint(Canvas canvas, Size size) {
    const leftInset = 42.0;
    const rightInset = 5.0;
    const verticalInset = 5.0;
    final recordedValues = [
      0,
      for (final day in days) useBars ? math.max(0, day.count) : day.count,
    ];
    var minimum = recordedValues.reduce(math.min).toDouble();
    var maximum = recordedValues.reduce(math.max).toDouble();
    if (useBars) {
      minimum = 0;
      maximum = math.max(1, maximum);
    } else if (minimum == maximum) {
      minimum -= 1;
      maximum += 1;
    }
    final gridPaint = Paint()
      ..color = gridColor.withValues(alpha: .7)
      ..strokeWidth = 1;
    for (var row = 0; row <= 2; row++) {
      final y = verticalInset + (size.height - verticalInset * 2) * row / 2;
      canvas.drawLine(
        Offset(leftInset, y),
        Offset(size.width - rightInset, y),
        gridPaint,
      );
      final value = maximum - ((maximum - minimum) * row / 2);
      _paintYAxisLabel(canvas, value, y, leftInset, labelColor);
    }

    double xFor(int index) => days.length == 1
        ? leftInset + (size.width - leftInset - rightInset) / 2
        : leftInset +
              (size.width - leftInset - rightInset) * index / (days.length - 1);
    double yFor(int count) =>
        verticalInset +
        (maximum - (useBars ? math.max(0, count) : count)) /
            (maximum - minimum) *
            (size.height - verticalInset * 2);

    if (useBars) {
      final plotWidth = size.width - leftInset - rightInset;
      final spacing = days.length <= 1 ? plotWidth : plotWidth / days.length;
      final barWidth = math.min(22.0, math.max(5.0, spacing * .56));
      final zeroY = yFor(0);
      final barPaint = Paint()..color = lineColor;
      for (var index = 0; index < days.length; index++) {
        final x = xFor(index);
        final valueY = yFor(days[index].count);
        final top = math.min(valueY, zeroY);
        final bottom = math.max(valueY, zeroY);
        final rect = RRect.fromRectAndRadius(
          Rect.fromLTRB(
            x - barWidth / 2,
            top,
            x + barWidth / 2,
            math.max(top + 2, bottom),
          ),
          const Radius.circular(5),
        );
        canvas.drawRRect(rect, barPaint);
      }
    } else {
      final points = <Offset>[];
      for (var index = 0; index < days.length; index++) {
        points.add(Offset(xFor(index), yFor(days[index].count)));
      }
      final path = _smoothGraphPath(points);
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
  }

  @override
  bool shouldRepaint(_SpecialHabitGraphPainter oldDelegate) {
    return oldDelegate.days != days ||
        oldDelegate.useBars != useBars ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.gridColor != gridColor ||
        oldDelegate.labelColor != labelColor;
  }
}

Path _smoothGraphPath(List<Offset> points) {
  final path = Path();
  if (points.isEmpty) return path;
  path.moveTo(points.first.dx, points.first.dy);
  if (points.length == 1) return path;
  if (points.length == 2) {
    path.lineTo(points.last.dx, points.last.dy);
    return path;
  }

  const curveStrength = 1 / 6;
  final minimumY = points.map((point) => point.dy).reduce(math.min);
  final maximumY = points.map((point) => point.dy).reduce(math.max);
  for (var index = 0; index < points.length - 1; index++) {
    final previous = points[index == 0 ? index : index - 1];
    final current = points[index];
    final next = points[index + 1];
    final following = points[index + 2 < points.length ? index + 2 : index + 1];
    final rawFirstControl = current + (next - previous) * curveStrength;
    final rawSecondControl = next - (following - current) * curveStrength;
    final firstControl = Offset(
      rawFirstControl.dx,
      rawFirstControl.dy.clamp(minimumY, maximumY),
    );
    final secondControl = Offset(
      rawSecondControl.dx,
      rawSecondControl.dy.clamp(minimumY, maximumY),
    );
    path.cubicTo(
      firstControl.dx,
      firstControl.dy,
      secondControl.dx,
      secondControl.dy,
      next.dx,
      next.dy,
    );
  }
  return path;
}

void _paintYAxisLabel(
  Canvas canvas,
  double value,
  double centerY,
  double leftInset,
  Color color,
) {
  final rounded = value.round();
  final label = (value - rounded).abs() < .05
      ? '$rounded'
      : value.toStringAsFixed(1);
  final painter = TextPainter(
    text: TextSpan(
      text: label,
      style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500),
    ),
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.left,
    maxLines: 1,
  )..layout(minWidth: leftInset - 8, maxWidth: leftInset - 8);
  painter.paint(canvas, Offset(0, centerY - painter.height / 2));
}
