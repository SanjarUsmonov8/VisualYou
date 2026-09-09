import 'package:flutter/material.dart';
import 'package:visualyou/features/rewards/rewards_controller.dart';
import 'package:visualyou/features/rewards/rewards_models.dart';
import 'package:visualyou/l10n/app_strings.dart';

class PremiumButton extends StatelessWidget {
  const PremiumButton({required this.controller, super.key});

  final RewardsController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) => IconButton(
        key: const Key('premiumButton'),
        tooltip: context.tr('Visual You Plus'),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => PremiumPage(controller: controller),
          ),
        ),
        icon: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFE66D), Color(0xFFFF9F43), Color(0xFFE056FD)],
          ).createShader(bounds),
          child: Icon(
            controller.isPlus
                ? Icons.workspace_premium
                : Icons.diamond_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

Future<void> openPremiumPlan(
  BuildContext context, {
  required RewardsController controller,
  required MembershipPlan plan,
}) {
  return Navigator.of(context).push<void>(
    MaterialPageRoute<void>(
      builder: (_) => PremiumPage(controller: controller, initialPlan: plan),
    ),
  );
}

MembershipPlan? nextMembershipPlan(MembershipPlan plan) => switch (plan) {
  MembershipPlan.free => MembershipPlan.plus,
  MembershipPlan.plus => MembershipPlan.pro,
  MembershipPlan.pro => MembershipPlan.ultra,
  MembershipPlan.ultra => null,
};

String membershipPlanNameKey(MembershipPlan plan) => switch (plan) {
  MembershipPlan.free => 'Free',
  MembershipPlan.plus => 'Plus',
  MembershipPlan.pro => 'Pro',
  MembershipPlan.ultra => 'Ultra',
};

class UpgradePlanButton extends StatelessWidget {
  const UpgradePlanButton({
    required this.controller,
    required this.targetPlan,
    this.label,
    this.icon = Icons.workspace_premium_rounded,
    super.key,
  });

  final RewardsController controller;
  final MembershipPlan targetPlan;
  final String? label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () =>
          openPremiumPlan(context, controller: controller, plan: targetPlan),
      icon: Icon(icon),
      label: Text(
        label ??
            '${context.tr('Upgrade to')} '
                '${context.tr(membershipPlanNameKey(targetPlan))}',
      ),
    );
  }
}

class PremiumPage extends StatefulWidget {
  const PremiumPage({required this.controller, this.initialPlan, super.key});

  final RewardsController controller;
  final MembershipPlan? initialPlan;

  static const _freeFeatures = [
    'Core limited features',
    'Limited habits',
    'Limited AI usage',
    'On-board ads',
    'Two habit streaks, 35 tokens each',
  ];

  static const _plusFeatures = [
    'Unlimited core features',
    'Extended features',
    'More tokens',
    'Extended AI usage',
    'Fewer on-board ads',
  ];

  static const _proFeatures = [
    'Unlimited Plus extended features',
    'Even more extended features',
    'More tokens',
    'Extended better AI usage',
    'Almost no on-board ads',
  ];

  static const _ultraFeatures = [
    'Unlimited every feature',
    'Every single feature',
    'More tokens',
    'Unlimited best AI usage',
    'No on-board ads',
  ];

  static const _unlimitedCoreDetails = [
    'Body progress without weekly locks',
    'Core graphs without weekly locks',
    'Main gradual-reduction plan without weekly locks',
    'Main gradual-growth plan without weekly locks',
    'Full calendar history',
  ];

  static const _extendedFeatureDetails = [
    'More custom-graph slots',
    'Two additional single-habit graphs',
    'A second gradual-reduction plan',
    'Three gradual-growth plans; the two extra plans share one weekly 70-token unlock',
    'More habits and up to two custom habits',
    'Numerical tracking for up to 4 habits',
    'Main custom graph with 6 habit slots',
    'One group graph with a weekly 70-token unlock',
    'Five habit streaks; 3 included and 2 cost 35 tokens',
    'Four numerical heatmaps; 2 included and 2 share one 35-token unlock',
  ];

  static const _unlimitedPlusExtendedDetails = [
    'All Plus custom-graph slots without weekly locks',
    'Two additional single-habit graphs without token or ad unlocks',
    'A second gradual-reduction plan without token or ad unlocks',
    'The first three gradual-growth plans without token or ad unlocks',
    'Unlimited numerical habit tracking',
  ];

  static const _proExtendedDetails = [
    'Create up to 5 custom habits',
    'Add organ effects to 3 custom habits',
    'Customize organ effects for 2 existing habits',
    'Main custom graph with 10 slots; the last 4 cost 35 tokens to change',
    'Four group graphs: 2 included and 2 weekly 35-token unlocks',
    'Six gradual-growth plans; the last 3 share one weekly 70-token unlock',
    'Four gradual-reduction plans; the last 2 share one weekly 35-token unlock',
    'Unlimited habit streaks with custom colors',
    'Five numerical heatmaps; 3 included and 2 share one 35-token unlock',
  ];

  static const _ultraExtendedDetails = [
    'Create up to 10 custom habits',
    'Add organ effects to 6 custom habits',
    'Customize organ effects for 4 existing habits',
    'Unlimited main custom-graph habit slots',
    'Six included group graphs',
    'Unlimited gradual-growth and gradual-reduction plans without token unlocks',
    'Unlimited habit streaks with custom colors',
    'Unlimited numerical habit heatmaps',
  ];

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  RewardsController get controller => widget.controller;
  List<String> get _freeFeatures => PremiumPage._freeFeatures;
  List<String> get _plusFeatures => PremiumPage._plusFeatures;
  List<String> get _proFeatures => PremiumPage._proFeatures;
  List<String> get _ultraFeatures => PremiumPage._ultraFeatures;
  List<String> get _unlimitedCoreDetails => PremiumPage._unlimitedCoreDetails;
  List<String> get _extendedFeatureDetails =>
      PremiumPage._extendedFeatureDetails;
  List<String> get _unlimitedPlusExtendedDetails =>
      PremiumPage._unlimitedPlusExtendedDetails;
  List<String> get _proExtendedDetails => PremiumPage._proExtendedDetails;
  List<String> get _ultraExtendedDetails => PremiumPage._ultraExtendedDetails;

  final Map<MembershipPlan, GlobalKey> _planKeys = {
    for (final plan in MembershipPlan.values) plan: GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusInitialPlan());
  }

  void _focusInitialPlan() {
    final plan = widget.initialPlan;
    final targetContext = plan == null ? null : _planKeys[plan]?.currentContext;
    if (targetContext == null) return;
    Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
      alignment: .08,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFFFD76A), Color(0xFFFF8A3D), Color(0xFFC45CFF)],
          ).createShader(bounds),
          child: Text(
            context.tr('Choose your plan'),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) => SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color(0xFF67D8F7),
                    Color(0xFF8B6FE8),
                    Color(0xFFF2A65A),
                  ],
                ).createShader(bounds),
                child: Text(
                  context.tr('Build your best Visual You'),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                context.tr(
                  'Choose the plan that fits your journey. You can change it later.',
                ),
                style: TextStyle(color: colors.onSurfaceVariant),
              ),
              const SizedBox(height: 22),
              KeyedSubtree(
                key: _planKeys[MembershipPlan.free],
                child: _PlanCard(
                  title: context.tr('Free'),
                  price: r'$0',
                  features: _freeFeatures.map(context.tr).toList(),
                  selected: controller.isPlan(MembershipPlan.free),
                  buttonText: context.tr(
                    controller.isPlan(MembershipPlan.free)
                        ? 'Current plan'
                        : 'Switch to Free',
                  ),
                  onPressed: controller.isPlan(MembershipPlan.free)
                      ? null
                      : () => controller.setPlan(MembershipPlan.free),
                ),
              ),
              const SizedBox(height: 16),
              KeyedSubtree(
                key: _planKeys[MembershipPlan.plus],
                child: _PlanCard(
                  title: context.tr('Plus'),
                  price: r'$2.99 / month',
                  features: _plusFeatures.map(context.tr).toList(),
                  expandableFeatureDetails: {
                    context.tr('Unlimited core features'): _unlimitedCoreDetails
                        .map(context.tr)
                        .toList(),
                    context.tr('Extended features'): _extendedFeatureDetails
                        .map(context.tr)
                        .toList(),
                  },
                  expandableFeatures: {
                    context.tr('Unlimited core features'),
                    context.tr('Extended features'),
                  },
                  selected: controller.isPlan(MembershipPlan.plus),
                  emphasized: true,
                  planAccent: const Color(0xFFF2B72B),
                  buttonText: context.tr(
                    controller.isPlan(MembershipPlan.plus)
                        ? 'Current plan'
                        : 'Preview Plus',
                  ),
                  onPressed: controller.isPlan(MembershipPlan.plus)
                      ? null
                      : () => controller.setPlan(MembershipPlan.plus),
                ),
              ),
              const SizedBox(height: 16),
              KeyedSubtree(
                key: _planKeys[MembershipPlan.pro],
                child: _PlanCard(
                  title: context.tr('Pro'),
                  price: r'$4.99 / month',
                  features: _proFeatures.map(context.tr).toList(),
                  expandableFeatureDetails: {
                    context.tr('Unlimited Plus extended features'):
                        _unlimitedPlusExtendedDetails.map(context.tr).toList(),
                    context.tr('Even more extended features'):
                        _proExtendedDetails.map(context.tr).toList(),
                  },
                  expandableFeatures: {
                    context.tr('Unlimited Plus extended features'),
                    context.tr('Even more extended features'),
                  },
                  selected: controller.isPlan(MembershipPlan.pro),
                  planAccent: const Color(0xFFE0525C),
                  buttonText: context.tr(
                    controller.isPlan(MembershipPlan.pro)
                        ? 'Current plan'
                        : 'Preview Pro',
                  ),
                  onPressed: controller.isPlan(MembershipPlan.pro)
                      ? null
                      : () => controller.setPlan(MembershipPlan.pro),
                ),
              ),
              const SizedBox(height: 16),
              KeyedSubtree(
                key: _planKeys[MembershipPlan.ultra],
                child: _PlanCard(
                  title: context.tr('Ultra'),
                  price: r'$9.99 / month',
                  features: _ultraFeatures.map(context.tr).toList(),
                  expandableFeatureDetails: {
                    context.tr('Unlimited every feature'):
                        _unlimitedPlusExtendedDetails.map(context.tr).toList(),
                    context.tr('Every single feature'): _ultraExtendedDetails
                        .map(context.tr)
                        .toList(),
                  },
                  expandableFeatures: {
                    context.tr('Unlimited every feature'),
                    context.tr('Every single feature'),
                  },
                  selected: controller.isPlan(MembershipPlan.ultra),
                  planAccent: const Color(0xFF2FAF72),
                  buttonText: context.tr(
                    controller.isPlan(MembershipPlan.ultra)
                        ? 'Current plan'
                        : 'Preview Ultra',
                  ),
                  onPressed: controller.isPlan(MembershipPlan.ultra)
                      ? null
                      : () => controller.setPlan(MembershipPlan.ultra),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                context.tr(
                  'This is a local preview. Store billing will be connected before release.',
                ),
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
              ),
              if (widget.initialPlan != null)
                SizedBox(height: MediaQuery.sizeOf(context).height * .72),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.price,
    required this.features,
    required this.selected,
    required this.buttonText,
    required this.onPressed,
    this.emphasized = false,
    this.planAccent,
    this.expandableFeatureDetails = const {},
    this.expandableFeatures = const {},
  });

  final String title;
  final String price;
  final List<String> features;
  final bool selected;
  final bool emphasized;
  final Color? planAccent;
  final Map<String, List<String>> expandableFeatureDetails;
  final Set<String> expandableFeatures;
  final String buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final customPlan = planAccent != null;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: emphasized || customPlan
            ? isDark
                  ? const Color(0xFF222327)
                  : Colors.white
            : colors.surfaceContainer,
        gradient: customPlan
            ? RadialGradient(
                center: Alignment.topRight,
                radius: 1.35,
                colors: [
                  planAccent!.withValues(alpha: isDark ? .52 : .28),
                  planAccent!.withValues(alpha: isDark ? .24 : .12),
                  Colors.transparent,
                ],
                stops: const [0, .38, 1],
              )
            : emphasized && isDark
            ? RadialGradient(
                center: Alignment.topRight,
                radius: 1.35,
                colors: const [
                  Color(0xB3F28C18),
                  Color(0x80F5C542),
                  Colors.transparent,
                ],
                stops: const [0, .34, 1],
              )
            : null,
        image: emphasized && !isDark && !customPlan
            ? const DecorationImage(
                image: AssetImage('assets/images/badges/plusback-mild.png'),
                fit: BoxFit.fill,
                filterQuality: FilterQuality.high,
              )
            : null,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: selected ? colors.primary : colors.outlineVariant,
          width: selected ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: emphasized || customPlan
                    ? ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) => LinearGradient(
                          colors: customPlan
                              ? _customTitleColors(planAccent!, isDark)
                              : isDark
                              ? const [
                                  Color(0xFFFFF3A0),
                                  Color(0xFFFFB300),
                                  Color(0xFFE68A00),
                                ]
                              : const [
                                  Color(0xFF765000),
                                  Color(0xFFB96800),
                                  Color(0xFFE59A00),
                                ],
                        ).createShader(bounds),
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                shadows: isDark
                                    ? null
                                    : const [
                                        Shadow(
                                          color: Color(0x24000000),
                                          blurRadius: 2,
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                              ),
                        ),
                      )
                    : Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
              ),
              if (selected)
                Icon(Icons.check_circle_rounded, color: colors.primary),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            price,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 15),
          if (features.isEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule_rounded,
                    size: 19,
                    color: planAccent ?? colors.primary,
                  ),
                  const SizedBox(width: 9),
                  Text(context.tr('Features coming soon')),
                ],
              ),
            ),
          for (final feature in features)
            _PlanFeatureRow(
              label: feature,
              details: expandableFeatureDetails[feature] ?? const [],
              expandable: expandableFeatures.contains(feature),
            ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton(onPressed: onPressed, child: Text(buttonText)),
          ),
        ],
      ),
    );
  }

  List<Color> _customTitleColors(Color accent, bool isDark) {
    if (accent == const Color(0xFFF2B72B)) {
      return isDark
          ? const [Color(0xFFFFF3A0), Color(0xFFFFC53D), Color(0xFFE68A00)]
          : const [Color(0xFF765000), Color(0xFFB96800), Color(0xFFE59A00)];
    }
    if (accent == const Color(0xFF2FAF72)) {
      return isDark
          ? const [Color(0xFFA8F0C8), Color(0xFF42CE87), Color(0xFF15985A)]
          : const [Color(0xFF12643D), Color(0xFF218B57), Color(0xFF35AE70)];
    }
    return isDark
        ? const [Color(0xFFFFB0A9), Color(0xFFFF6B67), Color(0xFFD83C4A)]
        : const [Color(0xFF8D2632), Color(0xFFC43A48), Color(0xFFE25A58)];
  }
}

class _PlanFeatureRow extends StatefulWidget {
  const _PlanFeatureRow({
    required this.label,
    required this.details,
    required this.expandable,
  });

  final String label;
  final List<String> details;
  final bool expandable;

  @override
  State<_PlanFeatureRow> createState() => _PlanFeatureRowState();
}

class _PlanFeatureRowState extends State<_PlanFeatureRow> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: widget.expandable
                ? () => setState(() => _expanded = !_expanded)
                : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.check_rounded, size: 19, color: colors.primary),
                  const SizedBox(width: 9),
                  Expanded(child: Text(widget.label)),
                  if (widget.expandable)
                    AnimatedRotation(
                      turns: _expanded ? .5 : 0,
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      child: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            child: !_expanded || widget.details.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(28, 7, 4, 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final detail in widget.details)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: colors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    detail,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: colors.onSurfaceVariant,
                                          height: 1.3,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
