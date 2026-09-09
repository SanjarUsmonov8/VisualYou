import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:visualyou/features/rewards/rewarded_ad_service.dart';
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
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: _rewardCardColor(context),
                borderRadius: BorderRadius.circular(22),
                boxShadow: _rewardShadow(context),
              ),
              child: Row(
                children: [
                  _StatItem(
                    asset: 'assets/images/badges/streakfire1.png',
                    value: data.currentStreak,
                    label: context.tr('Streak'),
                    onTap: () => _showRewardDetail(
                      context,
                      controller,
                      _RewardDetailKind.streak,
                    ),
                  ),
                  const _StatDivider(),
                  _StatItem(
                    asset: 'assets/images/badges/token.png',
                    value: data.tokenBalance,
                    label: context.tr('Tokens'),
                    onTap: () => _showRewardDetail(
                      context,
                      controller,
                      _RewardDetailKind.tokens,
                    ),
                  ),
                  const _StatDivider(),
                  _StatItem(
                    asset: 'assets/images/badges/aid (1).png',
                    value: data.streakAidBalance,
                    label: context.tr('Aid'),
                    onTap: () => _showRewardDetail(
                      context,
                      controller,
                      _RewardDetailKind.aid,
                    ),
                  ),
                  const _StatDivider(),
                  _StatItem(
                    asset: 'assets/images/badges/badgesicon.png',
                    value: data.earnedBadgeCount,
                    label: context.tr('Badges'),
                    onTap: () => _showRewardDetail(
                      context,
                      controller,
                      _RewardDetailKind.badges,
                    ),
                  ),
                ],
              ),
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
              protectedDays: data.protectedStreakDays,
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
                    onTap: () => _showBadgeDetail(
                      context,
                      _BadgeDetailKind.profile,
                      data.profileProgress,
                      800,
                    ),
                  ),
                  _BadgeCard(
                    asset: 'assets/images/badges/bronze male new (1).png',
                    label: context.tr('Body'),
                    value: data.bodyProgress,
                    maximum: 500,
                    onTap: () => _showBadgeDetail(
                      context,
                      _BadgeDetailKind.body,
                      data.bodyProgress,
                      500,
                    ),
                  ),
                  _BadgeCard(
                    asset: 'assets/images/badges/bronze calendar new (1).png',
                    label: context.tr('Calendar'),
                    value: data.calendarProgress,
                    maximum: 500,
                    onTap: () => _showBadgeDetail(
                      context,
                      _BadgeDetailKind.calendar,
                      data.calendarProgress,
                      500,
                    ),
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

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.asset,
    this.onTap,
    required this.value,
    required this.label,
  });
  final String asset;
  final VoidCallback? onTap;
  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
          child: Column(
            children: [
              Image.asset(asset, width: 34, height: 34, fit: BoxFit.contain),
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
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) => Container(
    width: 1,
    height: 48,
    color: Theme.of(context).dividerColor.withValues(alpha: .45),
  );
}

enum _RewardDetailKind { streak, tokens, aid, badges }

Future<void> _showRewardDetail(
  BuildContext context,
  RewardsController controller,
  _RewardDetailKind kind,
) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 280),
    transitionBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: ScaleTransition(
            scale: Tween(begin: .96, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
            child: child,
          ),
        ),
    pageBuilder: (context, animation, secondaryAnimation) => Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
            child: ColoredBox(color: Colors.black.withValues(alpha: .12)),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: _RewardDetailView(controller: controller, kind: kind),
          ),
        ),
      ],
    ),
  );
}

class _RewardDetailView extends StatelessWidget {
  const _RewardDetailView({required this.controller, required this.kind});

  final RewardsController controller;
  final _RewardDetailKind kind;

  Color get _accent => switch (kind) {
    _RewardDetailKind.streak => const Color(0xFFFF8A24),
    _RewardDetailKind.tokens => const Color(0xFF4A8DFF),
    _RewardDetailKind.aid => const Color(0xFFE35E65),
    _RewardDetailKind.badges => const Color(0xFFE1B52F),
  };

  String get _title => switch (kind) {
    _RewardDetailKind.streak => 'Your streaks',
    _RewardDetailKind.tokens => 'Your tokens',
    _RewardDetailKind.aid => 'Your streak aids',
    _RewardDetailKind.badges => 'Your badges',
  };

  String get _asset => switch (kind) {
    _RewardDetailKind.streak => 'assets/images/badges/streakfire1.png',
    _RewardDetailKind.tokens => 'assets/images/badges/token.png',
    _RewardDetailKind.aid => 'assets/images/badges/aid (1).png',
    _RewardDetailKind.badges => 'assets/images/badges/badgesicon.png',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              final data = controller.snapshot;
              if (data == null) {
                return const Center(child: CircularProgressIndicator());
              }
              final value = switch (kind) {
                _RewardDetailKind.streak => data.currentStreak,
                _RewardDetailKind.tokens => data.tokenBalance,
                _RewardDetailKind.aid => data.streakAidBalance,
                _RewardDetailKind.badges => data.earnedBadgeCount,
              };
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _accent.withValues(alpha: dark ? .20 : .16),
                      theme.colorScheme.surface.withValues(alpha: .96),
                      theme.colorScheme.surface.withValues(alpha: .91),
                    ],
                    stops: const [0, .48, 1],
                  ),
                  border: Border.all(
                    color: _accent.withValues(alpha: dark ? .32 : .22),
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 18, 0),
                      child: Row(
                        children: [
                          IconButton.filledTonal(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back_rounded),
                          ),
                          Expanded(
                            child: Text(
                              context.tr(_title),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          const SizedBox(width: 48),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(12, 18, 12, 12),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.asset(_asset, fit: BoxFit.contain),
                              ),
                            ),
                            const SizedBox(height: 18),
                            Text(
                              _valueText(context, value),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineMedium?.copyWith(
                                color: _accent,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              context.tr(_description),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleMedium?.copyWith(
                                height: 1.45,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (kind == _RewardDetailKind.streak) ...[
                              const SizedBox(height: 22),
                              const _StreakRewardMilestones(),
                            ],
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 10, 22, 22),
                      child: _actions(context),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String _valueText(BuildContext context, int value) => switch (kind) {
    _RewardDetailKind.streak => context.tr('You have $value streak days'),
    _RewardDetailKind.tokens => context.tr('You have $value tokens'),
    _RewardDetailKind.aid => context.tr('You have $value streak aids'),
    _RewardDetailKind.badges => context.tr('You have $value badges'),
  };

  String get _description => switch (kind) {
    _RewardDetailKind.streak =>
      'Track at least one habit every day to grow your streak. Aided missed days keep it connected, but do not count as streak days.',
    _RewardDetailKind.tokens =>
      'Earn more tokens through badges, streak milestones, rewarded ads, and other rewards.',
    _RewardDetailKind.aid =>
      'One streak aid protects up to two consecutive missed days. Those days stay blue and preserve the path without increasing your streak.',
    _RewardDetailKind.badges =>
      'Build your profile, body, and calendar progress to earn badges and their token rewards.',
  };

  Widget _actions(BuildContext context) {
    final close = FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: _accent,
        minimumSize: const Size(0, 52),
        padding: const EdgeInsets.symmetric(horizontal: 24),
      ),
      onPressed: () => Navigator.pop(context),
      child: Text(
        context.tr(
          kind == _RewardDetailKind.badges || kind == _RewardDetailKind.tokens
              ? "Let's get them!"
              : "Let's go!",
        ),
      ),
    );
    if (kind == _RewardDetailKind.tokens) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: controller.busy
                  ? null
                  : () => _earnAdTokens(context, controller),
              icon: const Icon(Icons.play_circle_outline_rounded),
              label: Text(context.tr('Get 35 \u00B7 AD')),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: close),
        ],
      );
    }
    if (kind == _RewardDetailKind.aid) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: controller.busy
                  ? null
                  : () => _buyStreakAid(context, controller),
              icon: Image.asset(
                'assets/images/badges/token.png',
                width: 20,
                height: 20,
              ),
              label: Text(context.tr('Get one · 35')),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: close),
        ],
      );
    }
    return Center(child: FractionallySizedBox(widthFactor: .68, child: close));
  }
}

class _StreakRewardMilestones extends StatelessWidget {
  const _StreakRewardMilestones();

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          context.tr('Ways to earn tokens with your streak'),
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      const SizedBox(height: 10),
      for (final task in const [
        _BadgeRewardTask('Reach a 7-day streak', 35),
        _BadgeRewardTask('Reach a 14-day streak', 80),
        _BadgeRewardTask('Reach a 21-day streak', 100),
        _BadgeRewardTask('Reach a 30-day streak', 150),
      ]) ...[
        _BadgeRewardTaskTile(task: task, accent: const Color(0xFFFF8A24)),
        const SizedBox(height: 8),
      ],
    ],
  );
}

Future<void> _earnAdTokens(
  BuildContext context,
  RewardsController controller,
) async {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(context.tr('Loading rewarded ad...'))));
  final result = await RewardedAdService.instance.showRewardedAd();
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  if (result == RewardedAdResult.earned) {
    await controller.awardRewardedAdTokens();
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.tr('35 tokens added.'))));
    return;
  }
  final message = result == RewardedAdResult.notEarned
      ? 'Watch the complete ad to receive the reward.'
      : 'The rewarded ad is not ready. Please try again.';
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(context.tr(message))));
}

Future<void> _buyStreakAid(
  BuildContext context,
  RewardsController controller,
) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(dialogContext.tr('Buy streak aid?')),
      content: Text(
        dialogContext.tr(
          'One aid protects an active streak through up to two consecutive missed days.',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: Text(
            MaterialLocalizations.of(dialogContext).cancelButtonLabel,
          ),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.pop(dialogContext, true),
          icon: Image.asset(
            'assets/images/badges/token.png',
            width: 20,
            height: 20,
          ),
          label: const Text('35'),
        ),
      ],
    ),
  );
  if (confirmed != true || !context.mounted) return;
  final purchased = await controller.purchaseStreakAid();
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        context.tr(
          purchased
              ? 'Streak aid added.'
              : 'You need 35 tokens for a streak aid.',
        ),
      ),
    ),
  );
}

class _StreakCalendar extends StatefulWidget {
  const _StreakCalendar({
    required this.activityDays,
    required this.protectedDays,
    required this.joinedAt,
  });
  final Set<DateTime> activityDays;
  final Set<DateTime> protectedDays;
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

  bool _protected(DateTime day) =>
      day.isBefore(_today) &&
      widget.protectedDays.any(
        (value) =>
            value.year == day.year &&
            value.month == day.month &&
            value.day == day.day,
      );

  bool _connected(DateTime day) => _active(day) || _protected(day);

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
                    _connected(day) &&
                    index % 7 != 0 &&
                    _connected(day.subtract(const Duration(days: 1))),
                connectRight:
                    _connected(day) &&
                    index % 7 != 6 &&
                    _connected(day.add(const Duration(days: 1))),
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

enum _BadgeDetailKind { profile, body, calendar }

Future<void> _showBadgeDetail(
  BuildContext context,
  _BadgeDetailKind kind,
  int value,
  int maximum,
) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 280),
    transitionBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: ScaleTransition(
            scale: Tween(begin: .96, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
            child: child,
          ),
        ),
    pageBuilder: (context, animation, secondaryAnimation) => Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
            child: ColoredBox(color: Colors.black.withValues(alpha: .12)),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: _BadgeDetailView(kind: kind, value: value, maximum: maximum),
          ),
        ),
      ],
    ),
  );
}

class _BadgeDetailView extends StatelessWidget {
  const _BadgeDetailView({
    required this.kind,
    required this.value,
    required this.maximum,
  });

  static const bronze = Color(0xFFB97945);
  final _BadgeDetailKind kind;
  final int value;
  final int maximum;

  String get _name => switch (kind) {
    _BadgeDetailKind.profile => 'Profile Bronze',
    _BadgeDetailKind.body => 'Body Bronze',
    _BadgeDetailKind.calendar => 'Calendar Bronze',
  };

  String get _asset => switch (kind) {
    _BadgeDetailKind.profile => 'assets/images/badges/profilebronze1.png',
    _BadgeDetailKind.body => 'assets/images/badges/bronze male new (1).png',
    _BadgeDetailKind.calendar =>
      'assets/images/badges/bronze calendar new (1).png',
  };

  List<_BadgeRewardTask> get _tasks => switch (kind) {
    _BadgeDetailKind.profile => const [
      _BadgeRewardTask('Complete your starting profile', 140),
      _BadgeRewardTask('Reach a 7-day streak', 35),
      _BadgeRewardTask('Reach a 14-day streak', 80),
      _BadgeRewardTask('Reach a 21-day streak', 100),
      _BadgeRewardTask('Reach a 30-day streak', 150),
      _BadgeRewardTask('Complete the Body Bronze badge', 70),
      _BadgeRewardTask('Complete the Calendar Bronze badge', 70),
    ],
    _BadgeDetailKind.body => const [
      _BadgeRewardTask(
        'Keep every organ at green or blue for at least 5 days in a week',
        30,
      ),
      _BadgeRewardTask('Bring every muscle to at least green', 20),
      _BadgeRewardTask(
        'Finish 5 days in a week with a positive custom-graph score',
        30,
      ),
      _BadgeRewardTask('Complete the Body Bronze badge', 70),
    ],
    _BadgeDetailKind.calendar => const [
      _BadgeRewardTask('Finish all 7 days of a week as excellent', 30),
      _BadgeRewardTask('Finish all 7 days as good or excellent', 10),
      _BadgeRewardTask(
        'Track a full reduction-plan week with no violations',
        25,
      ),
      _BadgeRewardTask('Complete the Calendar Bronze badge', 70),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final progress = (value / maximum).clamp(0.0, 1.0);
    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  bronze.withValues(alpha: dark ? .22 : .17),
                  theme.colorScheme.surface.withValues(alpha: .96),
                  theme.colorScheme.surface.withValues(alpha: .91),
                ],
                stops: const [0, .48, 1],
              ),
              border: Border.all(
                color: bronze.withValues(alpha: dark ? .36 : .25),
              ),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 18, 0),
                  child: Row(
                    children: [
                      IconButton.filledTonal(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_rounded),
                      ),
                      Expanded(
                        child: Text(
                          context.tr(_name),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(22, 12, 22, 16),
                    child: Column(
                      children: [
                        Image.asset(
                          _asset,
                          width: 230,
                          height: 230,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          '$value / $maximum',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: bronze,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: progress,
                          minHeight: 9,
                          color: bronze,
                          backgroundColor: bronze.withValues(alpha: .16),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        const SizedBox(height: 22),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            context.tr('Ways to earn badge points and tokens'),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        for (final task in _tasks) ...[
                          _BadgeRewardTaskTile(task: task),
                          const SizedBox(height: 8),
                        ],
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 8, 22, 22),
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 220,
                      height: 52,
                      child: FilledButton(
                        style: FilledButton.styleFrom(backgroundColor: bronze),
                        onPressed: () => Navigator.pop(context),
                        child: Text(context.tr("Let's go!")),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BadgeRewardTask {
  const _BadgeRewardTask(this.label, this.tokens);
  final String label;
  final int tokens;
}

class _BadgeRewardTaskTile extends StatelessWidget {
  const _BadgeRewardTaskTile({
    required this.task,
    this.accent = _BadgeDetailView.bronze,
  });
  final _BadgeRewardTask task;
  final Color accent;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface.withValues(alpha: .70),
      borderRadius: BorderRadius.circular(17),
      border: Border.all(color: accent.withValues(alpha: .16)),
    ),
    child: Row(
      children: [
        Icon(Icons.check_circle_outline_rounded, color: accent, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            context.tr(task.label),
            style: const TextStyle(fontWeight: FontWeight.w700, height: 1.3),
          ),
        ),
        const SizedBox(width: 9),
        Image.asset('assets/images/badges/token.png', width: 20, height: 20),
        const SizedBox(width: 3),
        Text(
          '+${task.tokens}',
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ],
    ),
  );
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({
    required this.asset,
    required this.label,
    required this.value,
    required this.maximum,
    required this.onTap,
  });
  final String asset;
  final String label;
  final int value;
  final int maximum;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final progress = (value / maximum).clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: _rewardCardColor(context),
          borderRadius: BorderRadius.circular(24),
          boxShadow: _rewardShadow(context),
        ),
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(24),
            child: Padding(
              padding: const EdgeInsets.all(12),
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
                                  child: Image.asset(
                                    asset,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    label,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
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
            ),
          ),
        ),
      ),
    );
  }
}
