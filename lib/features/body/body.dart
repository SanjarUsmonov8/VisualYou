import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:visualyou/data/habits/habit_repository.dart';
import 'package:visualyou/l10n/app_strings.dart';

enum MaleBodyView { organs, muscles }

enum MuscleGroup { arms, shouldersBack, chest, abs, legs }

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
  static final ValueNotifier<Color?> brainTint = ValueNotifier(null);
  static final ValueNotifier<Color?> heartTint = ValueNotifier(null);
  static final ValueNotifier<Color?> gutTint = ValueNotifier(null);
  static final ValueNotifier<Color?> stomachTint = ValueNotifier(null);
  static final ValueNotifier<Color?> liverTint = ValueNotifier(null);
  static final ValueNotifier<Color?> lungsTint = ValueNotifier(null);
  static final ValueNotifier<Color?> kidneysTint = ValueNotifier(null);
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
    muscleWorkoutCounts.value = Map.unmodifiable({
      MuscleGroup.arms: state.parts[BodyPartKey.arms]?.level ?? 0,
      MuscleGroup.shouldersBack:
          state.parts[BodyPartKey.shouldersBack]?.level ?? 0,
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
                        child: Stack(
                          key: const ValueKey(MaleBodyView.muscles),
                          children: [
                            Positioned.fill(
                              child: ColoredBox(color: frameColor),
                            ),
                            if (muscleLayers != null)
                              for (final layer in muscleLayers!)
                                _buildMuscleLayer(layer),
                            if (muscleLayers == null) ...[
                              // All muscle PNGs share one canvas. Keep these values
                              // identical to preserve their original alignment.
                              // Shoulder is beneath the abs, chest, and arms.
                              _ResponsiveMuscleLayer(
                                group: MuscleGroup.shouldersBack,
                                assetPath: 'assets/images/body/shoulder.png',
                                semanticLabel: 'Shoulder and back muscles',
                                top: 0,
                                left: 0,
                                right: 0,
                                width: 300,
                                height: 540,
                                imageFit: BoxFit.cover,
                              ),
                              // Head comes after shoulder, so it renders above it.
                              _PositionedOrgan(
                                assetPath: 'assets/images/body/head.png',
                                semanticLabel: 'Head muscles',
                                top: 0,
                                left: 0,
                                right: 0,
                                width: 300,
                                height: 540,
                                imageFit: BoxFit.cover,
                              ),

                              // Legs are beneath underwear.
                              _ResponsiveMuscleLayer(
                                group: MuscleGroup.legs,
                                assetPath: 'assets/images/body/legs.png',
                                semanticLabel: 'Leg muscles',
                                top: 0,
                                left: 0,
                                right: 0,
                                width: 300,
                                height: 540,
                                imageFit: BoxFit.cover,
                              ),

                              // Abs are above shoulder but below chest and arms.
                              _ResponsiveMuscleLayer(
                                group: MuscleGroup.abs,
                                assetPath: 'assets/images/body/abs.png',
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
                                assetPath: 'assets/images/body/chest.png',
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
                                assetPath: 'assets/images/body/arms.png',
                                semanticLabel: 'Arm muscles',
                                top: 0,
                                left: 0,
                                right: 0,
                                width: 300,
                                height: 540,
                                imageFit: BoxFit.cover,
                              ),

                              // Underwear is above both abs and legs.
                              _PositionedOrgan(
                                assetPath: 'assets/images/body/underwear.png',
                                semanticLabel: 'Underwear',
                                top: 0,
                                left: 0,
                                right: 0,
                                width: 300,
                                height: 540,
                                imageFit: BoxFit.cover,
                              ),
                            ],
                          ],
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

  Widget _buildMuscleLayer(MuscleLayerConfig layer) {
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
              for (var index = 0; index < _levelColors.length; index++) ...[
                if (index > 0) const SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: _levelColors[index],
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                context.tr('Bad'),
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                context.tr('Good'),
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w700,
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
          tintColor: BodyVisualState.muscleTintForCount(counts[group] ?? 0),
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
    Widget displayedImage = Image.asset(
      assetPath,
      fit: imageFit,
      semanticLabel: semanticLabel,
    );
    if (tintColor != null) {
      displayedImage = ColorFiltered(
        colorFilter: ColorFilter.matrix(_tintMatrix(tintColor!)),
        child: displayedImage,
      );
    }
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

  List<double> _tintMatrix(Color color) {
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
