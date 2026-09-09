import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:visualyou/data/habits/habit_repository.dart';
import 'package:visualyou/l10n/app_strings.dart';

enum MaleBodyView { organs, muscles }

enum MuscleBodySide { front, back }

enum MuscleGroup { arms, shoulders, back, chest, abs, legs }

class MuscleLayerConfig {
  const MuscleLayerConfig({
    required this.assetPath,
    required this.semanticLabel,
    required this.top,
    required this.left,
    required this.right,
    required this.width,
    required this.height,
    this.group,
    this.rotationDegrees = 0,
    this.imageFit = BoxFit.cover,
  });

  final MuscleGroup? group;
  final String assetPath;
  final String semanticLabel;
  final double top;
  final double left;
  final double right;
  final double width;
  final double height;
  final double rotationDegrees;
  final BoxFit imageFit;
}

class BodyVisualState {
  static final ValueNotifier<MaleBodyView> maleBodyView = ValueNotifier(
    MaleBodyView.organs,
  );
  static final ValueNotifier<MuscleBodySide> muscleBodySide = ValueNotifier(
    MuscleBodySide.front,
  );
  static final ValueNotifier<Color?> brainTint = ValueNotifier(null);
  static final ValueNotifier<Color?> heartTint = ValueNotifier(null);
  static final ValueNotifier<Color?> gutTint = ValueNotifier(null);
  static final ValueNotifier<Color?> stomachTint = ValueNotifier(null);
  static final ValueNotifier<Color?> liverTint = ValueNotifier(null);
  static final ValueNotifier<Color?> lungsTint = ValueNotifier(null);
  static final ValueNotifier<Color?> kidneysTint = ValueNotifier(null);
  static final ValueNotifier<Map<String, PersistedBodyPart>> organParts =
      ValueNotifier(const {});
  static final ValueNotifier<Map<MuscleGroup, int>> muscleWorkoutCounts =
      ValueNotifier(const {});

  static void restore(PersistedBodyState state) {
    Color? colorFor(String key) {
      final value = state.parts[key]?.colorValue;
      return value == null ? null : Color(value);
    }

    brainTint.value = colorFor(BodyPartKey.brain);
    heartTint.value = colorFor(BodyPartKey.heart);
    gutTint.value = colorFor(BodyPartKey.gut);
    stomachTint.value = colorFor(BodyPartKey.stomach);
    liverTint.value = colorFor(BodyPartKey.liver);
    lungsTint.value = colorFor(BodyPartKey.lungs);
    kidneysTint.value = colorFor(BodyPartKey.kidneys);
    organParts.value = Map.unmodifiable({
      for (final key in const [
        BodyPartKey.brain,
        BodyPartKey.heart,
        BodyPartKey.lungs,
        BodyPartKey.liver,
        BodyPartKey.stomach,
        BodyPartKey.kidneys,
        BodyPartKey.gut,
      ])
        if (state.parts[key] != null) key: state.parts[key]!,
    });
    muscleWorkoutCounts.value = Map.unmodifiable({
      MuscleGroup.arms: state.parts[BodyPartKey.arms]?.level ?? 0,
      MuscleGroup.shoulders:
          state.parts[BodyPartKey.shoulders]?.level ??
          state.parts[BodyPartKey.shouldersBack]?.level ??
          0,
      MuscleGroup.back:
          state.parts[BodyPartKey.back]?.level ??
          state.parts[BodyPartKey.shouldersBack]?.level ??
          0,
      MuscleGroup.chest: state.parts[BodyPartKey.chest]?.level ?? 0,
      MuscleGroup.abs: state.parts[BodyPartKey.abs]?.level ?? 0,
      MuscleGroup.legs: state.parts[BodyPartKey.legs]?.level ?? 0,
    });
  }

  static void showOrgans() {
    maleBodyView.value = MaleBodyView.organs;
  }

  static void showMuscles() {
    maleBodyView.value = MaleBodyView.muscles;
  }

  static void showMuscleFront() {
    muscleBodySide.value = MuscleBodySide.front;
  }

  static void showMuscleBack() {
    muscleBodySide.value = MuscleBodySide.back;
  }

  static void addWorkout(MuscleGroup group) {
    final updatedCounts = Map<MuscleGroup, int>.from(muscleWorkoutCounts.value);
    updatedCounts[group] = math.min(5, (updatedCounts[group] ?? 0) + 1);
    muscleWorkoutCounts.value = Map.unmodifiable(updatedCounts);
  }

  static Color? muscleTintForCount(int count) {
    return switch (count) {
      1 => const Color(0xFFE53935),
      2 => const Color(0xFFFB8C00),
      3 => const Color(0xFFFDD835),
      4 => const Color(0xFF43A047),
      >= 5 => const Color(0xFF1E88E5),
      _ => null,
    };
  }
}

class OrganReports extends StatefulWidget {
  const OrganReports({
    required this.showAll,
    this.reportsLocked = false,
    this.onUpgrade,
    super.key,
  });

  final bool showAll;
  final bool reportsLocked;
  final VoidCallback? onUpgrade;

  static const _freeOrgans = [
    _OrganReportConfig(
      partKey: BodyPartKey.brain,
      nameKey: 'Mind',
      assetPath: 'assets/images/body/brain.webp',
      messageVariant: 0,
    ),
    _OrganReportConfig(
      partKey: BodyPartKey.heart,
      nameKey: 'Heart',
      assetPath: 'assets/images/body/heart.png',
      messageVariant: 1,
    ),
    _OrganReportConfig(
      partKey: BodyPartKey.lungs,
      nameKey: 'Lungs',
      assetPath: 'assets/images/body/lungs (1).png',
      messageVariant: 2,
    ),
  ];

  static const _premiumOrgans = [
    ..._freeOrgans,
    _OrganReportConfig(
      partKey: BodyPartKey.liver,
      nameKey: 'Liver',
      assetPath: 'assets/images/body/liver (1).png',
      messageVariant: 0,
    ),
    _OrganReportConfig(
      partKey: BodyPartKey.stomach,
      nameKey: 'Stomach',
      assetPath: 'assets/images/body/stomach.webp',
      messageVariant: 1,
    ),
    _OrganReportConfig(
      partKey: BodyPartKey.kidneys,
      nameKey: 'Kidneys',
      assetPath: 'assets/images/body/leftkidney.png',
      messageVariant: 2,
    ),
    _OrganReportConfig(
      partKey: BodyPartKey.gut,
      nameKey: 'Gut',
      assetPath: 'assets/images/body/gut.png',
      messageVariant: 0,
    ),
  ];

  @override
  State<OrganReports> createState() => _OrganReportsState();
}

class _OrganReportsState extends State<OrganReports> {
  double _endOverscroll = 0;
  bool _openingReports = false;

  void _openReports() {
    if (_openingReports) return;
    _openingReports = true;
    Navigator.of(context)
        .push<void>(
          MaterialPageRoute<void>(
            builder: (_) => _OrganReportsPage(
              showAll: widget.showAll,
              reportsLocked: widget.reportsLocked,
              onUpgrade: widget.onUpgrade,
            ),
          ),
        )
        .whenComplete(() {
          if (mounted) _openingReports = false;
        });
  }

  bool _handleHorizontalScroll(ScrollNotification notification) {
    if (notification.metrics.axis != Axis.horizontal) return false;
    if (notification is OverscrollNotification &&
        notification.overscroll > 0 &&
        notification.metrics.pixels >= notification.metrics.maxScrollExtent) {
      _endOverscroll += notification.overscroll;
      if (_endOverscroll >= 30) {
        _endOverscroll = 0;
        _openReports();
      }
    } else if (notification is ScrollEndNotification) {
      _endOverscroll = 0;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final organs = widget.showAll
        ? OrganReports._premiumOrgans
        : OrganReports._freeOrgans;
    final itemCount = organs.length + (widget.showAll ? 0 : 1);
    final screenWidth = MediaQuery.sizeOf(context).width;
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final widthFactor = availableWidth.isFinite && availableWidth > 0
            ? screenWidth / availableWidth
            : 1.0;
        return FractionallySizedBox(
          widthFactor: widthFactor,
          child: ValueListenableBuilder<Map<String, PersistedBodyPart>>(
            valueListenable: BodyVisualState.organParts,
            builder: (context, parts, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: _openReports,
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                context.tr('Organ reports'),
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 218,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: _handleHorizontalScroll,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        itemCount: itemCount,
                        separatorBuilder: (_, _) => const SizedBox(width: 10),
                        itemBuilder: (context, index) => SizedBox(
                          width: 138,
                          child: index == organs.length
                              ? _LockedOrganReportCard(
                                  onUpgrade: widget.onUpgrade,
                                )
                              : _LockableOrganReportCard(
                                  locked: widget.reportsLocked,
                                  child: _OrganReportCard(
                                    config: organs[index],
                                    part: parts[organs[index].partKey],
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _OrganReportConfig {
  const _OrganReportConfig({
    required this.partKey,
    required this.nameKey,
    required this.assetPath,
    required this.messageVariant,
  });

  final String partKey;
  final String nameKey;
  final String assetPath;
  final int messageVariant;
}

class _OrganReportImage extends StatelessWidget {
  const _OrganReportImage({required this.config, required this.tint});

  final _OrganReportConfig config;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    Widget image(String semanticLabel, {bool flipped = false}) {
      final asset = Image.asset(
        config.assetPath,
        fit: BoxFit.contain,
        semanticLabel: semanticLabel,
      );
      return flipped ? Transform.flip(flipX: true, child: asset) : asset;
    }

    final content = config.partKey == BodyPartKey.kidneys
        ? Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: const Alignment(-0.28, 0),
                child: FractionallySizedBox(
                  widthFactor: .68,
                  heightFactor: 1,
                  child: image('Left kidney'),
                ),
              ),
              Align(
                alignment: const Alignment(0.28, 0),
                child: FractionallySizedBox(
                  widthFactor: .68,
                  heightFactor: 1,
                  child: image('Right kidney', flipped: true),
                ),
              ),
            ],
          )
        : image(config.nameKey);
    return _AnimatedTintedBodyPart(tintColor: tint, child: content);
  }
}

class _OrganReportCard extends StatelessWidget {
  const _OrganReportCard({required this.config, required this.part});

  final _OrganReportConfig config;
  final PersistedBodyPart? part;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final status = _organReportStatus(part);
    final tint = part?.colorValue == null ? null : Color(part!.colorValue!);
    return Container(
      padding: const EdgeInsets.fromLTRB(9, 10, 9, 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF24272E) : const Color(0xFFF0F2F5),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: .13),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 76,
            width: double.infinity,
            child: _OrganReportImage(config: config, tint: tint),
          ),
          const SizedBox(height: 5),
          Text(
            context.tr(config.nameKey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '${context.tr('Condition')}: ${context.tr(status.conditionKey)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: status.color,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            context.tr(status.messageFor(config.messageVariant)),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 10,
              height: 1.15,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _OrganReportsPage extends StatelessWidget {
  const _OrganReportsPage({
    required this.showAll,
    required this.reportsLocked,
    required this.onUpgrade,
  });

  final bool showAll;
  final bool reportsLocked;
  final VoidCallback? onUpgrade;

  @override
  Widget build(BuildContext context) {
    final organs = showAll
        ? OrganReports._premiumOrgans
        : OrganReports._freeOrgans;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: context.tr('Back'),
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          context.tr('Organ reports'),
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: ValueListenableBuilder<Map<String, PersistedBodyPart>>(
        valueListenable: BodyVisualState.organParts,
        builder: (context, parts, child) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
            children: [
              Text(
                context.tr('Symbolic habit progress, not medical status.'),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14),
              for (var index = 0; index < organs.length; index++) ...[
                if (index > 0) const SizedBox(height: 12),
                _LockableOrganReportCard(
                  locked: reportsLocked,
                  child: _DetailedOrganReportCard(
                    config: organs[index],
                    part: parts[organs[index].partKey],
                  ),
                ),
              ],
              if (!showAll) ...[
                const SizedBox(height: 12),
                _LockedOrganReportCard(onUpgrade: onUpgrade),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _LockableOrganReportCard extends StatelessWidget {
  const _LockableOrganReportCard({required this.locked, required this.child});

  final bool locked;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!locked) return child;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: ImageFiltered(
            imageFilter: ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Opacity(opacity: .42, child: child),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Icon(
              Icons.lock_clock_rounded,
              size: 34,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}

class _LockedOrganReportCard extends StatelessWidget {
  const _LockedOrganReportCard({required this.onUpgrade});

  final VoidCallback? onUpgrade;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF24272E) : const Color(0xFFF0F2F5),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: .13),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock_outline_rounded,
            size: 31,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 7),
          Text(
            context.tr('Unlock other organs with premium'),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: onUpgrade,
            style: FilledButton.styleFrom(
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            child: Text(context.tr('Upgrade to Plus')),
          ),
        ],
      ),
    );
  }
}

class _DetailedOrganReportCard extends StatelessWidget {
  const _DetailedOrganReportCard({required this.config, required this.part});

  final _OrganReportConfig config;
  final PersistedBodyPart? part;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final status = _organReportStatus(part);
    final tint = part?.colorValue == null ? null : Color(part!.colorValue!);
    return Container(
      height: 154,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF24272E) : const Color(0xFFF0F2F5),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: status.color.withValues(alpha: .14),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.7,
                  colors: [
                    status.color.withValues(alpha: isDark ? .28 : .24),
                    status.color.withValues(alpha: .1),
                    Colors.transparent,
                  ],
                  stops: const [0, .62, 1],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 14, 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr(config.nameKey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        '${context.tr('Condition')}: '
                        '${context.tr(status.conditionKey)}',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: status.color,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        context.tr(status.messageFor(config.messageVariant)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox.square(
                  dimension: 112,
                  child: _OrganReportImage(config: config, tint: tint),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OrganReportStatus {
  const _OrganReportStatus({
    required this.conditionKey,
    required this.messageKeys,
    required this.color,
  });

  final String conditionKey;
  final List<String> messageKeys;
  final Color color;

  String messageFor(int variant) => messageKeys[variant % messageKeys.length];
}

_OrganReportStatus _organReportStatus(PersistedBodyPart? part) {
  final colorValue = part?.colorValue;
  if (colorValue == 0xFFE53935) {
    return const _OrganReportStatus(
      conditionKey: 'Terrible',
      messageKeys: [
        'Needs attention',
        'Progress needs a reset',
        'Small steps matter now',
      ],
      color: Color(0xFFE53935),
    );
  }
  if (colorValue == 0xFFFB8C00) {
    return const _OrganReportStatus(
      conditionKey: 'Bad',
      messageKeys: [
        'Building stability',
        'More consistency will help',
        'A better rhythm can start today',
      ],
      color: Color(0xFFFB8C00),
    );
  }
  if (colorValue == 0xFF43A047) {
    return const _OrganReportStatus(
      conditionKey: 'Good',
      messageKeys: [
        'Doing well',
        'Positive habits are showing',
        'Strong and steady progress',
      ],
      color: Color(0xFF43A047),
    );
  }
  if (colorValue == 0xFF1E88E5) {
    return const _OrganReportStatus(
      conditionKey: 'Excellent',
      messageKeys: [
        'Excellent progress',
        'Consistency is paying off',
        'Keep up the great rhythm',
      ],
      color: Color(0xFF1E88E5),
    );
  }
  return const _OrganReportStatus(
    conditionKey: 'OK',
    messageKeys: [
      'Steady progress',
      'Holding a balanced course',
      'Keep the momentum moving',
    ],
    color: Color(0xFFFFCA28),
  );
}

class BodyFrame extends StatelessWidget {
  const BodyFrame({
    this.bodyAssetPath = 'assets/images/body/hmn body canva.webp',
    this.bodySemanticLabel = 'Human body and organs illustration',
    this.bodyOverlayAssetPath,
    this.bodyOverlaySemanticLabel,
    this.bodyOverlayTop = 0,
    this.bodyOverlayLeft = 0,
    this.bodyOverlayRight = 0,
    this.bodyOverlayWidth = 300,
    this.bodyOverlayHeight = 540,
    this.bodyOverlayRotationDegrees = 0,
    this.showMaleViewControls = true,
    this.muscleLayers,
    this.backMuscleLayers,
    this.backViewLocked = false,
    this.onUpgradeBack,
    super.key,
  });

  final String bodyAssetPath;
  final String bodySemanticLabel;
  final String? bodyOverlayAssetPath;
  final String? bodyOverlaySemanticLabel;
  final double bodyOverlayTop;
  final double bodyOverlayLeft;
  final double bodyOverlayRight;
  final double bodyOverlayWidth;
  final double bodyOverlayHeight;
  final double bodyOverlayRotationDegrees;
  final bool showMaleViewControls;
  final List<MuscleLayerConfig>? muscleLayers;
  final List<MuscleLayerConfig>? backMuscleLayers;
  final bool backViewLocked;
  final VoidCallback? onUpgradeBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = theme.colorScheme;
    final frameColor = isDark
        ? const Color(0xFF24272E)
        : const Color(0xFFF0F2F5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          height: 560,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: frameColor,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: colors.primary.withValues(alpha: .22),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  bodyAssetPath,
                  fit: BoxFit.contain,
                  semanticLabel: bodySemanticLabel,
                ),
              ),
              if (bodyOverlayAssetPath != null)
                Positioned(
                  top: bodyOverlayTop,
                  left: bodyOverlayLeft,
                  right: bodyOverlayRight,
                  child: Center(
                    child: SizedBox(
                      width: bodyOverlayWidth,
                      height: bodyOverlayHeight,
                      child: Transform.rotate(
                        angle: bodyOverlayRotationDegrees * math.pi / 180,
                        child: Image.asset(
                          bodyOverlayAssetPath!,
                          fit: BoxFit.contain,
                          semanticLabel: bodyOverlaySemanticLabel,
                        ),
                      ),
                    ),
                  ),
                ),
              ValueListenableBuilder<Color?>(
                valueListenable: BodyVisualState.brainTint,
                builder: (context, tintColor, child) {
                  return _PositionedOrgan(
                    assetPath: 'assets/images/body/brain.webp',
                    semanticLabel: 'Brain',
                    top: -12,
                    left: 93,
                    right: 91,
                    width: 80,
                    height: 80,
                    tintColor: tintColor,
                  );
                },
              ),

              // Lungs come before the heart, so the heart is drawn on top.
              ValueListenableBuilder<Color?>(
                valueListenable: BodyVisualState.lungsTint,
                builder: (context, tintColor, child) {
                  return _PositionedOrgan(
                    assetPath: 'assets/images/body/lungs (1).png',
                    semanticLabel: 'Lungs',
                    top: 65,
                    left: 83,
                    right: 81,
                    width: 115,
                    height: 115,
                    rotationDegrees: -1,
                    tintColor: tintColor,
                  );
                },
              ),
              ValueListenableBuilder<Color?>(
                valueListenable: BodyVisualState.heartTint,
                builder: (context, tintColor, child) {
                  return _PositionedOrgan(
                    assetPath: 'assets/images/body/heart.png',
                    semanticLabel: 'Heart',
                    top: 115,
                    left: 130,
                    right: 110,
                    width: 30,
                    height: 52,
                    tintColor: tintColor,
                  );
                },
              ),
              ValueListenableBuilder<Color?>(
                valueListenable: BodyVisualState.gutTint,
                builder: (context, tintColor, child) {
                  return _PositionedOrgan(
                    assetPath: 'assets/images/body/gut.png',
                    semanticLabel: 'Gut',
                    top: 178,
                    left: 90,
                    right: 90,
                    width: 115,
                    height: 115,
                    rotationDegrees: 4,
                    tintColor: tintColor,
                  );
                },
              ),

              // Kidneys appear above the gut but below the stomach and liver.
              ValueListenableBuilder<Color?>(
                valueListenable: BodyVisualState.kidneysTint,
                builder: (context, tintColor, child) {
                  return _PositionedOrgan(
                    assetPath: 'assets/images/body/leftkidney.png',
                    semanticLabel: 'Left kidney',
                    top: 175,
                    left: 67,
                    right: 89,
                    width: 60,
                    height: 55,
                    rotationDegrees: -10,
                    tintColor: tintColor,
                  );
                },
              ),
              ValueListenableBuilder<Color?>(
                valueListenable: BodyVisualState.kidneysTint,
                builder: (context, tintColor, child) {
                  return _PositionedOrgan(
                    assetPath: 'assets/images/body/leftkidney.png',
                    semanticLabel: 'Right kidney',
                    top: 175,
                    left: 95,
                    right: 61,
                    width: 60,
                    height: 55,
                    rotationDegrees: 20,
                    flipHorizontally: true,
                    tintColor: tintColor,
                  );
                },
              ),

              // Stomach and liver come after the kidneys, so they render on top.
              ValueListenableBuilder<Color?>(
                valueListenable: BodyVisualState.stomachTint,
                builder: (context, tintColor, child) {
                  return _PositionedOrgan(
                    assetPath: 'assets/images/body/stomach.webp',
                    semanticLabel: 'Stomach',
                    top: 160,
                    left: 115,
                    right: 90,
                    width: 60,
                    height: 55,
                    tintColor: tintColor,
                  );
                },
              ),
              ValueListenableBuilder<Color?>(
                valueListenable: BodyVisualState.liverTint,
                builder: (context, tintColor, child) {
                  return _PositionedOrgan(
                    assetPath: 'assets/images/body/liver (1).png',
                    semanticLabel: 'Liver',
                    top: 140,
                    left: 85,
                    right: 95,
                    width: 80,
                    height: 80,
                    tintColor: tintColor,
                  );
                },
              ),

              if (showMaleViewControls)
                Positioned.fill(
                  child: ValueListenableBuilder<MaleBodyView>(
                    valueListenable: BodyVisualState.maleBodyView,
                    builder: (context, bodyView, child) {
                      if (bodyView == MaleBodyView.organs) {
                        return const AnimatedSwitcher(
                          duration: Duration(milliseconds: 280),
                          child: SizedBox.shrink(
                            key: ValueKey(MaleBodyView.organs),
                          ),
                        );
                      }
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 280),
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeIn,
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(
                              scale: Tween<double>(
                                begin: .98,
                                end: 1,
                              ).animate(animation),
                              child: child,
                            ),
                          );
                        },
                        child: muscleLayers != null && backMuscleLayers == null
                            ? Stack(
                                key: const ValueKey(MaleBodyView.muscles),
                                children: [
                                  Positioned.fill(
                                    child: ColoredBox(color: frameColor),
                                  ),
                                  for (final layer in muscleLayers!)
                                    _buildMuscleLayer(layer),
                                ],
                              )
                            : ValueListenableBuilder<MuscleBodySide>(
                                valueListenable: BodyVisualState.muscleBodySide,
                                builder: (context, side, child) {
                                  return Stack(
                                    key: const ValueKey(MaleBodyView.muscles),
                                    children: [
                                      Positioned.fill(
                                        child: ColoredBox(color: frameColor),
                                      ),
                                      Positioned.fill(
                                        child: AnimatedSwitcher(
                                          duration: const Duration(
                                            milliseconds: 320,
                                          ),
                                          switchInCurve: Curves.easeOutCubic,
                                          switchOutCurve: Curves.easeInCubic,
                                          transitionBuilder:
                                              (child, animation) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: SlideTransition(
                                                    position: Tween<Offset>(
                                                      begin: const Offset(
                                                        .045,
                                                        0,
                                                      ),
                                                      end: Offset.zero,
                                                    ).animate(animation),
                                                    child: child,
                                                  ),
                                                );
                                              },
                                          child: _muscleSideContent(side),
                                        ),
                                      ),
                                      if (side == MuscleBodySide.back &&
                                          backViewLocked)
                                        Positioned.fill(
                                          top: 54,
                                          child: Center(
                                            child: Container(
                                              constraints: const BoxConstraints(
                                                maxWidth: 250,
                                              ),
                                              margin: const EdgeInsets.all(18),
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: colors.surface
                                                    .withValues(alpha: .9),
                                                borderRadius:
                                                    BorderRadius.circular(22),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    Icons.lock_outline_rounded,
                                                    size: 34,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    context.tr(
                                                      'Upgrade to Plus to unlock',
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  FilledButton(
                                                    onPressed: onUpgradeBack,
                                                    child: Text(
                                                      context.tr(
                                                        'Upgrade to Plus',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: _MuscleSideControl(
                                          selectedSide: side,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                      );
                    },
                  ),
                ),
              if (showMaleViewControls)
                ValueListenableBuilder<MaleBodyView>(
                  valueListenable: BodyVisualState.maleBodyView,
                  builder: (context, bodyView, child) {
                    return Positioned(
                      right: 8,
                      bottom: 8,
                      child: _MaleBodyViewControls(selectedView: bodyView),
                    );
                  },
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _PerformanceScale(backgroundColor: frameColor, showShadow: !isDark),
      ],
    );
  }

  Widget _muscleSideContent(MuscleBodySide side) {
    final locked = side == MuscleBodySide.back && backViewLocked;
    final layers = side == MuscleBodySide.front
        ? muscleLayers == null
              ? _maleFrontMuscleLayers()
              : [for (final layer in muscleLayers!) _buildMuscleLayer(layer)]
        : backMuscleLayers == null
        ? _maleBackMuscleLayers(tintEnabled: !locked)
        : [
            for (final layer in backMuscleLayers!)
              _buildMuscleLayer(layer, tintEnabled: !locked),
          ];
    final content = Stack(children: layers);
    return ClipRect(
      key: ValueKey(side),
      child: locked
          ? ImageFiltered(
              imageFilter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Opacity(opacity: .46, child: content),
            )
          : content,
    );
  }

  List<Widget> _maleFrontMuscleLayers() {
    // Every front PNG shares one canvas. Identical values preserve alignment.
    return const [
      _ResponsiveMuscleLayer(
        group: MuscleGroup.shoulders,
        assetPath: 'assets/images/body/mshoulders.png',
        semanticLabel: 'Shoulder muscles',
        top: 0,
        left: 0,
        right: 0,
        width: 300,
        height: 540,
        imageFit: BoxFit.cover,
      ),
      // Front-visible back/neck muscles sit above shoulders and below the head.
      _ResponsiveMuscleLayer(
        group: MuscleGroup.back,
        assetPath: 'assets/images/body/mbackf.png',
        semanticLabel: 'Front-visible back and neck muscles',
        top: 0,
        left: 0,
        right: 0,
        width: 300,
        height: 540,
        imageFit: BoxFit.cover,
      ),
      _PositionedOrgan(
        assetPath: 'assets/images/body/mhead2.png',
        semanticLabel: 'Head muscles',
        top: 0,
        left: 0,
        right: 0,
        width: 300,
        height: 540,
        imageFit: BoxFit.cover,
      ),
      _ResponsiveMuscleLayer(
        group: MuscleGroup.legs,
        assetPath: 'assets/images/body/mlegs.png',
        semanticLabel: 'Leg muscles',
        top: 0,
        left: 0,
        right: 0,
        width: 300,
        height: 540,
        imageFit: BoxFit.cover,
      ),
      _ResponsiveMuscleLayer(
        group: MuscleGroup.abs,
        assetPath: 'assets/images/body/mabs.png',
        semanticLabel: 'Abdominal muscles',
        top: 0,
        left: 0,
        right: 0,
        width: 300,
        height: 540,
        imageFit: BoxFit.cover,
      ),
      _ResponsiveMuscleLayer(
        group: MuscleGroup.chest,
        assetPath: 'assets/images/body/mchest2.png',
        semanticLabel: 'Chest muscles',
        top: 0,
        left: 0,
        right: 0,
        width: 300,
        height: 540,
        imageFit: BoxFit.cover,
      ),
      _ResponsiveMuscleLayer(
        group: MuscleGroup.arms,
        assetPath: 'assets/images/body/marms (1).png',
        semanticLabel: 'Arm muscles',
        top: 0,
        left: 0,
        right: 0,
        width: 300,
        height: 540,
        imageFit: BoxFit.cover,
      ),
      _PositionedOrgan(
        assetPath: 'assets/images/body/munderwear.png',
        semanticLabel: 'Underwear',
        top: 0,
        left: 0,
        right: 0,
        width: 300,
        height: 540,
        imageFit: BoxFit.cover,
      ),
    ];
  }

  List<Widget> _maleBackMuscleLayers({required bool tintEnabled}) {
    // Every back PNG shares one canvas. Identical values preserve alignment.
    return [
      // Head is drawn first so the back/neck layer covers its lower edge.
      _PositionedOrgan(
        assetPath: 'assets/images/body/mbhead.png',
        semanticLabel: 'Back of head',
        top: 0,
        left: 0,
        right: 0,
        width: 300,
        height: 540,
        imageFit: BoxFit.cover,
      ),
      _ResponsiveMuscleLayer(
        group: MuscleGroup.back,
        assetPath: 'assets/images/body/mback.png',
        semanticLabel: 'Back muscles',
        top: 0,
        left: 0,
        right: 0,
        width: 300,
        height: 540,
        imageFit: BoxFit.cover,
        tintEnabled: tintEnabled,
      ),
      _ResponsiveMuscleLayer(
        group: MuscleGroup.shoulders,
        assetPath: 'assets/images/body/mbshoulders.png',
        semanticLabel: 'Back shoulder muscles',
        top: 0,
        left: 0,
        right: 0,
        width: 300,
        height: 540,
        imageFit: BoxFit.cover,
        tintEnabled: tintEnabled,
      ),
      _ResponsiveMuscleLayer(
        group: MuscleGroup.legs,
        assetPath: 'assets/images/body/mblegs.png',
        semanticLabel: 'Back leg muscles',
        top: 0,
        left: 0,
        right: 0,
        width: 300,
        height: 540,
        imageFit: BoxFit.cover,
        tintEnabled: tintEnabled,
      ),
      _ResponsiveMuscleLayer(
        group: MuscleGroup.arms,
        assetPath: 'assets/images/body/mbarms.png',
        semanticLabel: 'Back arm muscles',
        top: 0,
        left: 0,
        right: 0,
        width: 300,
        height: 540,
        imageFit: BoxFit.cover,
        tintEnabled: tintEnabled,
      ),
      _PositionedOrgan(
        assetPath: 'assets/images/body/mbunderwear.png',
        semanticLabel: 'Back underwear',
        top: 0,
        left: 0,
        right: 0,
        width: 300,
        height: 540,
        imageFit: BoxFit.cover,
      ),
    ];
  }

  Widget _buildMuscleLayer(MuscleLayerConfig layer, {bool tintEnabled = true}) {
    if (layer.group != null) {
      return _ResponsiveMuscleLayer(
        group: layer.group!,
        assetPath: layer.assetPath,
        semanticLabel: layer.semanticLabel,
        top: layer.top,
        left: layer.left,
        right: layer.right,
        width: layer.width,
        height: layer.height,
        rotationDegrees: layer.rotationDegrees,
        imageFit: layer.imageFit,
        tintEnabled: tintEnabled,
      );
    }
    return _PositionedOrgan(
      assetPath: layer.assetPath,
      semanticLabel: layer.semanticLabel,
      top: layer.top,
      left: layer.left,
      right: layer.right,
      width: layer.width,
      height: layer.height,
      rotationDegrees: layer.rotationDegrees,
      imageFit: layer.imageFit,
    );
  }
}

class _PerformanceScale extends StatelessWidget {
  const _PerformanceScale({
    required this.backgroundColor,
    required this.showShadow,
  });

  static const _levelColors = [
    Color(0xFFE53935),
    Color(0xFFFB8C00),
    Color(0xFFFDD835),
    Color(0xFF43A047),
    Color(0xFF1E88E5),
  ];

  static const _levelLabels = ['Terrible', 'Bad', 'OK', 'Good', 'Excellent'];

  final Color backgroundColor;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (showShadow)
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
          Text(
            context.tr('Performance'),
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              for (var index = 0; index < _levelColors.length; index++)
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 12,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: _levelColors[index],
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        context.tr(_levelLabels[index]),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
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
}

class _ResponsiveMuscleLayer extends StatelessWidget {
  const _ResponsiveMuscleLayer({
    required this.group,
    required this.assetPath,
    required this.semanticLabel,
    required this.top,
    required this.left,
    required this.right,
    required this.width,
    required this.height,
    this.rotationDegrees = 0,
    this.imageFit = BoxFit.cover,
    this.tintEnabled = true,
  });

  final MuscleGroup group;
  final String assetPath;
  final String semanticLabel;
  final double top;
  final double left;
  final double right;
  final double width;
  final double height;
  final double rotationDegrees;
  final BoxFit imageFit;
  final bool tintEnabled;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<MuscleGroup, int>>(
      valueListenable: BodyVisualState.muscleWorkoutCounts,
      builder: (context, counts, child) {
        return _PositionedOrgan(
          assetPath: assetPath,
          semanticLabel: semanticLabel,
          top: top,
          left: left,
          right: right,
          width: width,
          height: height,
          rotationDegrees: rotationDegrees,
          imageFit: imageFit,
          tintColor: tintEnabled
              ? BodyVisualState.muscleTintForCount(counts[group] ?? 0)
              : null,
        );
      },
    );
  }
}

class _PositionedOrgan extends StatelessWidget {
  const _PositionedOrgan({
    required this.assetPath,
    required this.semanticLabel,
    required this.top,
    required this.left,
    required this.right,
    required this.width,
    required this.height,
    this.rotationDegrees = 0,
    this.tintColor,
    this.flipHorizontally = false,
    this.imageFit = BoxFit.contain,
  });

  final String assetPath;
  final String semanticLabel;
  final double top;
  final double left;
  final double right;
  final double width;
  final double height;
  final double rotationDegrees;
  final Color? tintColor;
  final bool flipHorizontally;
  final BoxFit imageFit;

  @override
  Widget build(BuildContext context) {
    Widget displayedImage = _AnimatedTintedBodyPart(
      tintColor: tintColor,
      child: Image.asset(
        assetPath,
        fit: imageFit,
        semanticLabel: semanticLabel,
      ),
    );
    if (flipHorizontally) {
      displayedImage = Transform.flip(flipX: true, child: displayedImage);
    }

    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: Transform.rotate(
            angle: rotationDegrees * math.pi / 180,
            child: displayedImage,
          ),
        ),
      ),
    );
  }
}

class _AnimatedTintedBodyPart extends StatefulWidget {
  const _AnimatedTintedBodyPart({required this.tintColor, required this.child});

  final Color? tintColor;
  final Widget child;

  @override
  State<_AnimatedTintedBodyPart> createState() =>
      _AnimatedTintedBodyPartState();
}

class _AnimatedTintedBodyPartState extends State<_AnimatedTintedBodyPart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _curve;
  late List<double> _fromMatrix;
  late List<double> _toMatrix;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
      value: 1,
    );
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic);
    _fromMatrix = _bodyPartTintMatrix(widget.tintColor);
    _toMatrix = List<double>.from(_fromMatrix);
  }

  @override
  void didUpdateWidget(covariant _AnimatedTintedBodyPart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tintColor == widget.tintColor) return;
    _fromMatrix = _currentMatrix;
    _toMatrix = _bodyPartTintMatrix(widget.tintColor);
    _controller.forward(from: 0);
  }

  List<double> get _currentMatrix {
    final progress = _curve.value;
    return List<double>.generate(
      _toMatrix.length,
      (index) =>
          _fromMatrix[index] +
          (_toMatrix[index] - _fromMatrix[index]) * progress,
      growable: false,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final pulse = math.sin(_controller.value * math.pi) * .04;
        return Transform.scale(
          scale: 1 + pulse,
          child: ColorFiltered(
            colorFilter: ColorFilter.matrix(_currentMatrix),
            child: child,
          ),
        );
      },
    );
  }
}

const _identityColorMatrix = <double>[
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
];

List<double> _bodyPartTintMatrix(Color? color) {
  if (color == null) return List<double>.from(_identityColorMatrix);
  return [
    .2126 * color.r,
    .7152 * color.r,
    .0722 * color.r,
    0,
    0,
    .2126 * color.g,
    .7152 * color.g,
    .0722 * color.g,
    0,
    0,
    .2126 * color.b,
    .7152 * color.b,
    .0722 * color.b,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ];
}

class _MuscleSideControl extends StatelessWidget {
  const _MuscleSideControl({required this.selectedSide});

  final MuscleBodySide selectedSide;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: 116,
      height: 36,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: .84),
        borderRadius: BorderRadius.circular(99),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: .12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _sideButton(
              context,
              label: context.tr('Front'),
              selected: selectedSide == MuscleBodySide.front,
              onTap: BodyVisualState.showMuscleFront,
            ),
          ),
          Expanded(
            child: _sideButton(
              context,
              label: context.tr('Back view'),
              selected: selectedSide == MuscleBodySide.back,
              onTap: BodyVisualState.showMuscleBack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sideButton(
    BuildContext context, {
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: selected ? colors.primary : Colors.transparent,
      borderRadius: BorderRadius.circular(99),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(99),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: selected ? colors.onPrimary : colors.onSurfaceVariant,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class _MaleBodyViewControls extends StatelessWidget {
  const _MaleBodyViewControls({required this.selectedView});

  final MaleBodyView selectedView;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _button(
          context: context,
          tooltip: context.tr('Show organs'),
          icon: Icons.remove_rounded,
          selected: selectedView == MaleBodyView.organs,
          onPressed: BodyVisualState.showOrgans,
        ),
        const SizedBox(width: 6),
        _button(
          context: context,
          tooltip: context.tr('Show muscles'),
          icon: Icons.add_rounded,
          selected: selectedView == MaleBodyView.muscles,
          onPressed: BodyVisualState.showMuscles,
        ),
      ],
    );
  }

  Widget _button({
    required BuildContext context,
    required String tooltip,
    required IconData icon,
    required bool selected,
    required VoidCallback onPressed,
  }) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox.square(
      dimension: 32,
      child: IconButton(
        tooltip: tooltip,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
          backgroundColor: selected
              ? colors.primary
              : colors.surface.withValues(alpha: .86),
          foregroundColor: selected
              ? colors.onPrimary
              : colors.onSurfaceVariant,
          shadowColor: colors.shadow.withValues(alpha: .18),
          elevation: 3,
        ),
        icon: Icon(icon, size: 19),
      ),
    );
  }
}
