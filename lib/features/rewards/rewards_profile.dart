import 'package:flutter/material.dart';
import 'package:visualyou/features/rewards/rewards_controller.dart';
import 'package:visualyou/l10n/app_strings.dart';

class RewardsProfileSection extends StatelessWidget {
  const RewardsProfileSection({required this.controller, super.key});
  final RewardsController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final data = controller.snapshot;
        if (data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 28),
            Row(
              children: [
                _StatCard(
                  asset: 'assets/images/badges/streakfire1.png',
                  value: data.currentStreak,
                  label: context.tr('Streak'),
                ),
                const SizedBox(width: 8),
                _StatCard(
                  asset: 'assets/images/badges/token.png',
                  value: data.tokenBalance,
                  label: context.tr('Tokens'),
                ),
                const SizedBox(width: 8),
                _StatCard(
                  icon: Icons.workspace_premium_rounded,
                  value: data.earnedBadgeCount,
                  label: context.tr('Badges'),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              context.tr('Your streak calendar'),
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            _StreakCalendar(
              activityDays: data.activityDays,
              joinedAt: data.joinedAt,
            ),
            const SizedBox(height: 24),
            Text(
              context.tr('Bronze badges'),
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 215,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _BadgeCard(
                    asset: 'assets/images/badges/profilebronze1.png',
                    label: context.tr('Profile'),
                    value: data.profileProgress,
                    maximum: 800,
                  ),
                  _BadgeCard(
                    asset: 'assets/images/badges/bronze male new (1).png',
                    label: context.tr('Body'),
                    value: data.bodyProgress,
                    maximum: 500,
                  ),
                  _BadgeCard(
                    asset: 'assets/images/badges/bronze calendar new (1).png',
                    label: context.tr('Calendar'),
                    value: data.calendarProgress,
                    maximum: 500,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

Color _rewardCardColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
    ? const Color(0xFF282C33)
    : Colors.white;

List<BoxShadow> _rewardShadow(BuildContext context) => [
  BoxShadow(
    color: Theme.of(context).colorScheme.shadow.withValues(alpha: .12),
    blurRadius: 14,
    offset: const Offset(0, 6),
  ),
];

class _StatCard extends StatelessWidget {
  const _StatCard({
    this.asset,
    this.icon,
    required this.value,
    required this.label,
  });
  final String? asset;
  final IconData? icon;
  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        decoration: BoxDecoration(
          color: _rewardCardColor(context),
          borderRadius: BorderRadius.circular(20),
          boxShadow: _rewardShadow(context),
        ),
        child: Column(
          children: [
            if (asset != null)
              Image.asset(asset!, width: 34, height: 34, fit: BoxFit.contain)
            else
              Icon(icon, size: 32, color: colors.primary),
            const SizedBox(height: 4),
            Text(
              '$value',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
            ),
            Text(
              label,
              maxLines: 1,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _StreakCalendar extends StatefulWidget {
  const _StreakCalendar({required this.activityDays, required this.joinedAt});
  final Set<DateTime> activityDays;
  final DateTime joinedAt;

  @override
  State<_StreakCalendar> createState() => _StreakCalendarState();
}

class _StreakCalendarState extends State<_StreakCalendar> {
  late DateTime _month;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _month = DateTime(now.year, now.month);
  }

  DateTime get _today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  bool get _isCurrentMonth =>
      _month.year == _today.year && _month.month == _today.month;

  bool _active(DateTime day) => widget.activityDays.any(
    (value) =>
        value.year == day.year &&
        value.month == day.month &&
        value.day == day.day,
  );

  DateTime get _streakStartedOn {
    final joined = DateTime(
      widget.joinedAt.year,
      widget.joinedAt.month,
      widget.joinedAt.day,
    );
    if (widget.activityDays.isEmpty) return joined;
    final firstActivity = widget.activityDays
        .map((day) => DateTime(day.year, day.month, day.day))
        .reduce((first, day) => day.isBefore(first) ? day : first);
    return firstActivity.isBefore(joined) ? firstActivity : joined;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final firstDay = DateTime(_month.year, _month.month);
    final leading = firstDay.weekday - 1;
    final dayCount = DateTime(_month.year, _month.month + 1, 0).day;
    final cellCount = leading + dayCount <= 35 ? 35 : 42;
    final sundayFirst = MaterialLocalizations.of(context).narrowWeekdays;
    final weekdays = [...sundayFirst.skip(1), sundayFirst.first];
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
      decoration: BoxDecoration(
        color: _rewardCardColor(context),
        borderRadius: BorderRadius.circular(24),
        boxShadow: _rewardShadow(context),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => setState(
                  () => _month = DateTime(_month.year, _month.month - 1),
                ),
                icon: const Icon(Icons.chevron_left_rounded),
                tooltip: context.tr('Previous month'),
              ),
              Expanded(
                child: Text(
                  MaterialLocalizations.of(context).formatMonthYear(_month),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              IconButton(
                onPressed: _isCurrentMonth
                    ? null
                    : () => setState(
                        () => _month = DateTime(_month.year, _month.month + 1),
                      ),
                icon: const Icon(Icons.chevron_right_rounded),
                tooltip: context.tr('Next month'),
              ),
            ],
          ),
          Row(
            children: [
              for (final weekday in weekdays)
                Expanded(
                  child: Text(
                    weekday,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 5),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cellCount,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              final number = index - leading + 1;
              if (number < 1 || number > dayCount) {
                return const SizedBox.shrink();
              }
              final day = DateTime(_month.year, _month.month, number);
              final active = _active(day);
              return _StreakDay(
                day: number,
                active: active,
                frozen:
                    !active &&
                    day.isBefore(_today) &&
                    !day.isBefore(_streakStartedOn),
                connectLeft:
                    active &&
                    index % 7 != 0 &&
                    _active(day.subtract(const Duration(days: 1))),
                connectRight:
                    active &&
                    index % 7 != 6 &&
                    _active(day.add(const Duration(days: 1))),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StreakDay extends StatelessWidget {
  const _StreakDay({
    required this.day,
    required this.active,
    required this.frozen,
    required this.connectLeft,
    required this.connectRight,
  });
  final int day;
  final bool active;
  final bool frozen;
  final bool connectLeft;
  final bool connectRight;

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFFFF8A24);
    final color = active
        ? activeColor
        : frozen
        ? const Color(0xFFBFEAFF)
        : Theme.of(context).colorScheme.surfaceContainerHighest;
    return LayoutBuilder(
      builder: (context, constraints) {
        final diameter = constraints.maxWidth * .74;
        return Stack(
          alignment: Alignment.center,
          children: [
            if (connectLeft)
              Positioned(
                left: 0,
                right: constraints.maxWidth / 2,
                height: diameter,
                child: const ColoredBox(color: activeColor),
              ),
            if (connectRight)
              Positioned(
                left: constraints.maxWidth / 2,
                right: 0,
                height: diameter,
                child: const ColoredBox(color: activeColor),
              ),
            Container(
              width: diameter,
              height: diameter,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Text(
                '$day',
                style: TextStyle(
                  color: active
                      ? Colors.white
                      : frozen
                      ? const Color(0xFF245A73)
                      : null,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({
    required this.asset,
    required this.label,
    required this.value,
    required this.maximum,
  });
  final String asset;
  final String label;
  final int value;
  final int maximum;

  @override
  Widget build(BuildContext context) {
    final progress = (value / maximum).clamp(0.0, 1.0);
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _rewardCardColor(context),
        borderRadius: BorderRadius.circular(24),
        boxShadow: _rewardShadow(context),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 105,
            height: 120,
            child: LayoutBuilder(
              builder: (context, constraints) => Stack(
                fit: StackFit.expand,
                children: [
                  ColorFiltered(
                    colorFilter: const ColorFilter.matrix(<double>[
                      .2126,
                      .7152,
                      .0722,
                      0,
                      0,
                      .2126,
                      .7152,
                      .0722,
                      0,
                      0,
                      .2126,
                      .7152,
                      .0722,
                      0,
                      0,
                      0,
                      0,
                      0,
                      1,
                      0,
                    ]),
                    child: Image.asset(asset, fit: BoxFit.contain),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: constraints.maxHeight * progress,
                    child: ClipRect(
                      child: OverflowBox(
                        alignment: Alignment.bottomCenter,
                        minHeight: constraints.maxHeight,
                        maxHeight: constraints.maxHeight,
                        child: SizedBox(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          child: Image.asset(asset, fit: BoxFit.contain),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w900)),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: progress,
            borderRadius: BorderRadius.circular(99),
          ),
          const SizedBox(height: 4),
          Text(
            '$value / $maximum',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
