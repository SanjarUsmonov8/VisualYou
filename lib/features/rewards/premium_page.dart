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

class PremiumPage extends StatelessWidget {
  const PremiumPage({required this.controller, super.key});

  final RewardsController controller;

  static const _freeFeatures = [
    'Core limited features',
    'Limited habits',
    'Limited AI usage',
    'On-board ads',
  ];

  static const _plusFeatures = [
    'Unlimited core features',
    'Extended features',
    'More and your own habits',
    'More tokens',
    'Extended AI usage',
    'Fewer on-board ads',
  ];

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
        builder: (context, _) => ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 36),
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
            _PlanCard(
              title: context.tr('Free'),
              price: r'$0',
              features: _freeFeatures.map(context.tr).toList(),
              selected: !controller.isPlus,
              buttonText: context.tr(
                controller.isPlus ? 'Switch to Free' : 'Current plan',
              ),
              onPressed: controller.isPlus
                  ? () => controller.setPlan(MembershipPlan.free)
                  : null,
            ),
            const SizedBox(height: 16),
            _PlanCard(
              title: context.tr('Plus'),
              price: r'$2.99 / month',
              features: _plusFeatures.map(context.tr).toList(),
              selected: controller.isPlus,
              emphasized: true,
              buttonText: context.tr(
                controller.isPlus ? 'Current plan' : 'Preview Plus',
              ),
              onPressed: controller.isPlus
                  ? null
                  : () => controller.setPlan(MembershipPlan.plus),
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
          ],
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
  });

  final String title;
  final String price;
  final List<String> features;
  final bool selected;
  final bool emphasized;
  final String buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: emphasized
            ? isDark
                  ? const Color(0xFF222327)
                  : Colors.white
            : colors.surfaceContainer,
        gradient: emphasized && isDark
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
        image: emphasized && !isDark
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
                child: emphasized
                    ? ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) => LinearGradient(
                          colors: isDark
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
          for (final feature in features)
            Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_rounded, size: 19, color: colors.primary),
                  const SizedBox(width: 9),
                  Expanded(child: Text(feature)),
                ],
              ),
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
}
