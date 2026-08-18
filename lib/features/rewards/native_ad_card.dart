import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:visualyou/features/rewards/rewarded_ad_service.dart';

class NativeAdCard extends StatefulWidget {
  const NativeAdCard({this.bottomSpacing = 12, super.key});

  final double bottomSpacing;

  @override
  State<NativeAdCard> createState() => _NativeAdCardState();
}

class _NativeAdCardState extends State<NativeAdCard> {
  NativeAd? _nativeAd;
  bool _loaded = false;
  int? _styleSignature;

  bool get _isSupported =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isSupported) return;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final signature = Object.hash(
      theme.brightness,
      colors.surfaceContainerHigh,
      colors.onSurface,
      colors.onSurfaceVariant,
      colors.primary,
    );
    if (_styleSignature == signature) return;
    _styleSignature = signature;
    _loadAd(colors);
  }

  Future<void> _loadAd(ColorScheme colors) async {
    _nativeAd?.dispose();
    _loaded = false;
    final requestedStyle = _styleSignature;
    await RewardedAdService.instance.initialize();
    if (!mounted || requestedStyle != _styleSignature) return;
    final adUnitId = RewardedAdService.nativeAdUnitIdFor(defaultTargetPlatform);
    if (adUnitId.isEmpty) return;
    final ad = NativeAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (!mounted || !identical(ad, _nativeAd)) {
            ad.dispose();
            return;
          }
          setState(() => _loaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Native ad failed to load: $error');
          ad.dispose();
          if (mounted && identical(ad, _nativeAd)) {
            setState(() {
              _nativeAd = null;
              _loaded = false;
            });
          }
        },
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.small,
        mainBackgroundColor: colors.surfaceContainerHigh,
        cornerRadius: 24,
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: colors.onPrimary,
          backgroundColor: colors.primary,
          style: NativeTemplateFontStyle.bold,
          size: 14,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: colors.onSurface,
          backgroundColor: colors.surfaceContainerHigh,
          style: NativeTemplateFontStyle.bold,
          size: 15,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: colors.onSurfaceVariant,
          backgroundColor: colors.surfaceContainerHigh,
          style: NativeTemplateFontStyle.normal,
          size: 12,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: colors.onSurfaceVariant,
          backgroundColor: colors.surfaceContainerHigh,
          style: NativeTemplateFontStyle.normal,
          size: 11,
        ),
      ),
    );
    _nativeAd = ad;
    ad.load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ad = _nativeAd;
    return AnimatedSize(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      child: !_loaded || ad == null
          ? const SizedBox.shrink()
          : Padding(
              padding: EdgeInsets.only(bottom: widget.bottomSpacing),
              child: Container(
                width: double.infinity,
                height: 112,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    if (Theme.of(context).brightness == Brightness.light)
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.shadow.withValues(alpha: .12),
                        blurRadius: 16,
                        offset: const Offset(0, 7),
                      ),
                  ],
                ),
                child: AdWidget(ad: ad),
              ),
            ),
    );
  }
}
