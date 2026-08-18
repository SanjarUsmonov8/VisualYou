import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:visualyou/features/rewards/rewarded_ad_service.dart';
import 'package:visualyou/features/rewards/rewards_controller.dart';
import 'package:visualyou/features/rewards/rewards_models.dart';
import 'package:visualyou/l10n/app_strings.dart';

class TokenChip extends StatelessWidget {
  const TokenChip({required this.amount, this.compact = false, super.key});

  final int amount;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 7 : 10,
        vertical: compact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: .82),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/badges/token.png',
            width: compact ? 18 : 22,
            height: compact ? 18 : 22,
          ),
          const SizedBox(width: 4),
          Text('$amount', style: const TextStyle(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

enum _PurchaseChoice { cancel, ad, tokens }

Future<bool> confirmTokenOrAdPurchase(
  BuildContext context, {
  required RewardsController controller,
  required int amount,
  required String reason,
  required String title,
  bool chargePlus = false,
}) async {
  final choice =
      await showDialog<_PurchaseChoice>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(title),
          content: Text(
            context.tr('Choose how you want to unlock this change.'),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(dialogContext, _PurchaseChoice.cancel),
              child: Text(context.tr('Cancel')),
            ),
            OutlinedButton.icon(
              onPressed: () => Navigator.pop(dialogContext, _PurchaseChoice.ad),
              icon: const Icon(Icons.play_circle_outline_rounded),
              label: Text(context.tr('Watch ad')),
            ),
            FilledButton.icon(
              onPressed: () =>
                  Navigator.pop(dialogContext, _PurchaseChoice.tokens),
              icon: Image.asset(
                'assets/images/badges/token.png',
                width: 21,
                height: 21,
              ),
              label: Text('$amount'),
            ),
          ],
        ),
      ) ??
      _PurchaseChoice.cancel;
  if (choice == _PurchaseChoice.cancel || !context.mounted) return false;
  if (choice == _PurchaseChoice.ad) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.tr('Loading rewarded ad...'))),
    );
    final result = await RewardedAdService.instance.showRewardedAd();
    if (!context.mounted) return false;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (result == RewardedAdResult.earned) return true;
    final message = result == RewardedAdResult.notEarned
        ? 'Watch the complete ad to receive the reward.'
        : 'The rewarded ad is not ready. Please try again.';
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.tr(message))));
    return false;
  }
  final paid = await controller.spend(amount, reason, chargePlus: chargePlus);
  if (paid || !context.mounted) return paid;
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(context.tr('Not enough tokens'))));
  return false;
}

class RewardFeatureGate extends StatelessWidget {
  const RewardFeatureGate({
    required this.controller,
    required this.feature,
    required this.title,
    required this.child,
    super.key,
  });

  final RewardsController controller;
  final GatedFeature feature;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final unlocked = controller.isUnlocked(feature);
        if (controller.isPlus) return child;
        return Stack(
          children: [
            AbsorbPointer(
              absorbing: !unlocked,
              child: unlocked
                  ? child
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: ImageFiltered(
                        imageFilter: ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                        child: Opacity(opacity: .42, child: child),
                      ),
                    ),
            ),
            if (!unlocked)
              Positioned.fill(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 260),
                    margin: const EdgeInsets.all(18),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surface.withValues(alpha: .92),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.lock_clock_rounded, size: 34),
                        const SizedBox(height: 7),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          context.tr('Unlock for 7 days'),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        FilledButton(
                          onPressed: controller.busy
                              ? null
                              : () => _unlock(context),
                          child: Text(context.tr('Choose token or ad')),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const Positioned(
              top: 10,
              left: 12,
              child: TokenChip(amount: 70, compact: true),
            ),
          ],
        );
      },
    );
  }

  Future<void> _unlock(BuildContext context) async {
    final paid = await confirmTokenOrAdPurchase(
      context,
      controller: controller,
      amount: 70,
      reason: 'unlock-${feature.name}',
      title: context.tr('Do you want to unlock this feature?'),
    );
    if (!paid) return;
    await controller.repository.unlockFeatureAfterPayment(feature);
    await controller.refresh();
  }
}
