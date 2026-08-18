import 'dart:async';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

enum RewardedAdResult { earned, notEarned, unavailable }

class RewardedAdService {
  RewardedAdService._();

  static final RewardedAdService instance = RewardedAdService._();

  static const bool useProductionAds = bool.fromEnvironment(
    'ADMOB_USE_PRODUCTION',
    defaultValue: kReleaseMode,
  );
  static const String _androidProductionRewardedId =
      'ca-app-pub-5785529344181904/8865307585';
  static const String _androidProductionNativeId =
      'ca-app-pub-5785529344181904/7488596402';
  static const String _iosProductionRewardedId =
      'ca-app-pub-5785529344181904/8582236552';
  static const String _iosProductionNativeId =
      'ca-app-pub-5785529344181904/9934846676';
  static const String _androidTestRewardedId =
      'ca-app-pub-3940256099942544/5224354917';
  static const String _iosTestRewardedId =
      'ca-app-pub-3940256099942544/1712485313';
  static const String _androidTestNativeId =
      'ca-app-pub-3940256099942544/2247696110';
  static const String _iosTestNativeId =
      'ca-app-pub-3940256099942544/3986624511';

  RewardedAd? _cachedAd;
  Future<RewardedAd?>? _loadingAd;
  Future<void>? _initializing;
  bool _initialized = false;

  bool get _isSupported =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  @visibleForTesting
  static String adUnitIdFor(
    TargetPlatform platform, {
    bool production = useProductionAds,
  }) {
    if (platform == TargetPlatform.android) {
      return production ? _androidProductionRewardedId : _androidTestRewardedId;
    }
    if (platform == TargetPlatform.iOS) {
      return production ? _iosProductionRewardedId : _iosTestRewardedId;
    }
    return '';
  }

  static String nativeAdUnitIdFor(
    TargetPlatform platform, {
    bool production = useProductionAds,
  }) {
    if (platform == TargetPlatform.android) {
      return production ? _androidProductionNativeId : _androidTestNativeId;
    }
    if (platform == TargetPlatform.iOS) {
      return production ? _iosProductionNativeId : _iosTestNativeId;
    }
    return '';
  }

  String get adUnitId => adUnitIdFor(defaultTargetPlatform);

  Future<void> initialize() async {
    if (!_isSupported || _initialized) return;
    final activeInitialization = _initializing;
    if (activeInitialization != null) return activeInitialization;

    final initialization = _initializeOnce();
    _initializing = initialization;
    try {
      await initialization;
    } finally {
      if (identical(_initializing, initialization)) _initializing = null;
    }
  }

  Future<void> _initializeOnce() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      try {
        // ATT must be requested while the app is visible, before ads load.
        await Future<void>.delayed(const Duration(milliseconds: 250));
        final status =
            await AppTrackingTransparency.trackingAuthorizationStatus;
        if (status == TrackingStatus.notDetermined) {
          await AppTrackingTransparency.requestTrackingAuthorization();
        }
      } catch (error, stackTrace) {
        // Ads can still be non-personalized when ATT is unavailable or denied.
        debugPrint('ATT authorization request failed: $error');
        debugPrintStack(stackTrace: stackTrace);
      }
    }

    try {
      await MobileAds.instance.initialize();
      _initialized = true;
      unawaited(_preload());
    } catch (error, stackTrace) {
      debugPrint('AdMob initialization failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<RewardedAdResult> showRewardedAd() async {
    if (!_isSupported || adUnitId.isEmpty) {
      return RewardedAdResult.unavailable;
    }
    await initialize();
    if (!_initialized) return RewardedAdResult.unavailable;

    final ad = await _loadAd();
    if (ad == null) return RewardedAdResult.unavailable;
    if (identical(_cachedAd, ad)) _cachedAd = null;

    final result = Completer<RewardedAdResult>();
    var earnedReward = false;

    void finish(RewardedAdResult value) {
      if (!result.isCompleted) result.complete(value);
    }

    ad.fullScreenContentCallback = FullScreenContentCallback<RewardedAd>(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        finish(
          earnedReward ? RewardedAdResult.earned : RewardedAdResult.notEarned,
        );
        unawaited(_preload());
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('Rewarded ad failed to show: $error');
        ad.dispose();
        finish(RewardedAdResult.unavailable);
        unawaited(_preload());
      },
    );

    try {
      ad.show(
        onUserEarnedReward: (_, reward) {
          earnedReward = true;
        },
      );
    } catch (error, stackTrace) {
      debugPrint('Rewarded ad show failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      ad.dispose();
      finish(RewardedAdResult.unavailable);
      unawaited(_preload());
    }
    return result.future;
  }

  Future<void> _preload() async {
    if (_cachedAd != null || !_isSupported || adUnitId.isEmpty) return;
    await _loadAd();
  }

  Future<RewardedAd?> _loadAd() {
    final cached = _cachedAd;
    if (cached != null) return Future.value(cached);
    final existingLoad = _loadingAd;
    if (existingLoad != null) return existingLoad;

    final completer = Completer<RewardedAd?>();
    _loadingAd = completer.future;
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _cachedAd = ad;
          completer.complete(ad);
        },
        onAdFailedToLoad: (error) {
          debugPrint('Rewarded ad failed to load: $error');
          completer.complete(null);
        },
      ),
    );
    return completer.future.whenComplete(() => _loadingAd = null);
  }
}
