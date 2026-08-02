import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:visualyou/l10n/app_strings.dart';

class HabitInfoCards extends StatefulWidget {
  const HabitInfoCards({super.key});

  @override
  State<HabitInfoCards> createState() => _HabitInfoCardsState();
}

class _HabitInfoCardsState extends State<HabitInfoCards> {
  static const _facts = [
    _HabitFact(
      textKey:
          'Alcohol can affect many organs and may also strain relationships and friendships.',
      icon: Icons.local_bar_rounded,
    ),
    _HabitFact(
      textKey:
          'Cigarette smoke contains more than 7,000 chemicals, including many that are toxic.',
      icon: Icons.smoking_rooms_rounded,
    ),
    _HabitFact(
      textKey:
          'Frequent explicit content can create unrealistic expectations about bodies and intimacy, and may contribute to guilt or distress.',
      icon: Icons.visibility_off_rounded,
    ),
    _HabitFact(
      textKey:
          'Drinking enough water supports normal physical and mental performance.',
      icon: Icons.water_drop_rounded,
    ),
    _HabitFact(
      textKey:
          'Regular physical activity supports the heart, muscles, bones, and mental well-being.',
      icon: Icons.fitness_center_rounded,
    ),
    _HabitFact(
      textKey:
          'A balanced and varied diet supports energy and helps protect long-term health.',
      icon: Icons.eco_rounded,
    ),
  ];

  late final List<_HabitFact> _selectedFacts;

  @override
  void initState() {
    super.initState();
    final shuffled = [..._facts]..shuffle(math.Random());
    _selectedFacts = shuffled.take(3).toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    final displayedFacts = [..._selectedFacts]
      ..sort(
        (first, second) => context
            .tr(second.textKey)
            .length
            .compareTo(context.tr(first.textKey).length),
      );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr('Useful information'),
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 9),
        _HabitInfoCard(
          fact: displayedFacts[0],
          height: 142,
          iconSize: 142,
          fontSize: 17,
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: _HabitInfoCard(
                  fact: displayedFacts[1],
                  iconSize: 132,
                  fontSize: 15.5,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: _HabitInfoCard(
                  fact: displayedFacts[2],
                  iconSize: 132,
                  fontSize: 15.5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HabitInfoCard extends StatelessWidget {
  const _HabitInfoCard({
    required this.fact,
    required this.iconSize,
    required this.fontSize,
    this.height,
  });

  final _HabitFact fact;
  final double? height;
  final double iconSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isSquare = height == null;
    final cardColor = isDark
        ? theme.colorScheme.primaryContainer.withValues(alpha: .48)
        : theme.colorScheme.primaryContainer.withValues(alpha: .72);
    return Container(
      width: double.infinity,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: .12),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: isSquare ? 12 : 4,
            right: isSquare ? 14 : -8,
            child: Icon(
              fact.icon,
              size: iconSize,
              color: theme.colorScheme.primary.withValues(alpha: .09),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: isSquare
                  ? const EdgeInsets.fromLTRB(12, 66, 12, 12)
                  : const EdgeInsets.fromLTRB(14, 14, 112, 14),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Text(
                    context.tr(fact.textKey),
                    maxLines: isSquare ? 5 : 5,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: fontSize,
                      height: 1.22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HabitFact {
  const _HabitFact({required this.textKey, required this.icon});

  final String textKey;
  final IconData icon;
}
