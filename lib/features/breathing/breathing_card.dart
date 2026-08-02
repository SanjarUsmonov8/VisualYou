import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visualyou/l10n/app_strings.dart';

enum _BreathingPhase { inhale, holdAfterInhale, exhale, holdAfterExhale }

class BreathingCard extends StatefulWidget {
  const BreathingCard({super.key});

  @override
  State<BreathingCard> createState() => _BreathingCardState();
}

class _BreathingCardState extends State<BreathingCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _phaseTimer;
  bool _isRunning = false;
  _BreathingPhase _phase = _BreathingPhase.inhale;
  int _secondsRemaining = 4;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
  }

  @override
  void dispose() {
    _phaseTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
      decoration: BoxDecoration(
        color: isDark
            ? colors.primaryContainer.withValues(alpha: .78)
            : colors.secondaryContainer.withValues(alpha: .72),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: colors.primary.withValues(alpha: .22),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox.square(
                dimension: 78,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final scale = .68 + (_controller.value * .32);
                    return Center(
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                colors.primary.withValues(alpha: .42),
                                colors.primary.withValues(alpha: .14),
                              ],
                            ),
                            border: Border.all(
                              color: colors.primary.withValues(alpha: .4),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.air_rounded,
                            color: colors.primary,
                            size: 28,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr('Breathing'),
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      child: Text(
                        _isRunning
                            ? '${context.tr(_phaseLabel)} · ${_secondsRemaining}s'
                            : context.tr('Take a calm breath'),
                        key: ValueKey('$_isRunning-$_phase-$_secondsRemaining'),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.onSecondaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton.filled(
                key: const Key('breathingToggleButton'),
                tooltip: context.tr(
                  _isRunning ? 'Pause breathing' : 'Start breathing',
                ),
                onPressed: _toggle,
                icon: Icon(
                  _isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            context.tr(
              'Breathe after a good habit to link each breath with that positive feeling. Before an unwanted habit, breathe to pause, think, and remember how good your better choice felt.',
            ),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSecondaryContainer.withValues(alpha: .82),
              fontSize: 14.5,
              height: 1.3,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _toggle() {
    setState(() => _isRunning = !_isRunning);
    if (_isRunning) {
      _runCurrentPhase();
    } else {
      _phaseTimer?.cancel();
      _controller.stop();
    }
  }

  String get _phaseLabel {
    return switch (_phase) {
      _BreathingPhase.inhale => 'Inhale',
      _BreathingPhase.exhale => 'Exhale',
      _BreathingPhase.holdAfterInhale ||
      _BreathingPhase.holdAfterExhale => 'Hold',
    };
  }

  int get _phaseDuration {
    return switch (_phase) {
      _BreathingPhase.inhale || _BreathingPhase.exhale => 4,
      _BreathingPhase.holdAfterInhale || _BreathingPhase.holdAfterExhale => 2,
    };
  }

  void _runCurrentPhase() {
    _phaseTimer?.cancel();
    final duration = Duration(seconds: _secondsRemaining);
    switch (_phase) {
      case _BreathingPhase.inhale:
        _controller.animateTo(1, duration: duration, curve: Curves.easeInOut);
        break;
      case _BreathingPhase.holdAfterInhale:
        _controller
          ..stop()
          ..value = 1;
        break;
      case _BreathingPhase.exhale:
        _controller.animateTo(0, duration: duration, curve: Curves.easeInOut);
        break;
      case _BreathingPhase.holdAfterExhale:
        _controller
          ..stop()
          ..value = 0;
        break;
    }
    _phaseTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || !_isRunning) return;
      if (_secondsRemaining > 1) {
        setState(() => _secondsRemaining--);
      } else {
        _advancePhase();
      }
    });
  }

  void _advancePhase() {
    _phaseTimer?.cancel();
    _phase = switch (_phase) {
      _BreathingPhase.inhale => _BreathingPhase.holdAfterInhale,
      _BreathingPhase.holdAfterInhale => _BreathingPhase.exhale,
      _BreathingPhase.exhale => _BreathingPhase.holdAfterExhale,
      _BreathingPhase.holdAfterExhale => _BreathingPhase.inhale,
    };
    _secondsRemaining = _phaseDuration;
    setState(() {});
    _runCurrentPhase();
  }
}
