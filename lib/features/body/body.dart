import 'dart:math' as math;

import 'package:flutter/material.dart';

class BodyVisualState {
  static final ValueNotifier<Color?> brainTint = ValueNotifier(null);
  static final ValueNotifier<Color?> heartTint = ValueNotifier(null);
  static final ValueNotifier<Color?> gutTint = ValueNotifier(null);
  static final ValueNotifier<Color?> stomachTint = ValueNotifier(null);
  static final ValueNotifier<Color?> liverTint = ValueNotifier(null);

  static void addAlcoholHabit() {
    const red = Color(0xFFE53935);
    const yellow = Color(0xFFFFCA28);
    brainTint.value = red;
    heartTint.value = yellow;
    liverTint.value = red;
  }

  static void addHealthyEatingHabit() {
    const blue = Color(0xFF2979FF);
    const green = Color(0xFF43A047);
    gutTint.value = blue;
    stomachTint.value = blue;
    liverTint.value = green;
  }
}

class BodyFrame extends StatelessWidget {
  const BodyFrame({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      height: 560,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF24272E)
            : const Color(0xFFF0F2F5),
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
              'assets/images/body/hmn body canva.webp',
              fit: BoxFit.contain,
              semanticLabel: 'Human body and organs illustration',
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
          const _PositionedOrgan(
            assetPath: 'assets/images/body/lungs (1).png',
            semanticLabel: 'Lungs',
            top: 65,
            left: 83,
            right: 81,
            width: 115,
            height: 115,
            rotationDegrees: -1,
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

          // Stomach comes before the liver, so the liver is drawn on top.
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
        ],
      ),
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

  @override
  Widget build(BuildContext context) {
    final organImage = Image.asset(
      assetPath,
      fit: BoxFit.contain,
      semanticLabel: semanticLabel,
    );

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
            child: tintColor == null
                ? organImage
                : ColorFiltered(
                    colorFilter: ColorFilter.matrix(
                      _tintMatrix(tintColor!),
                    ),
                    child: organImage,
                  ),
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
