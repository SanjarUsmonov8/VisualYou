import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/features/rewards/rewarded_ad_service.dart';

void main() {
  test('development builds use Google rewarded test units', () {
    expect(
      RewardedAdService.adUnitIdFor(TargetPlatform.android, production: false),
      'ca-app-pub-3940256099942544/5224354917',
    );
    expect(
      RewardedAdService.adUnitIdFor(TargetPlatform.iOS, production: false),
      'ca-app-pub-3940256099942544/1712485313',
    );
    expect(
      RewardedAdService.nativeAdUnitIdFor(
        TargetPlatform.android,
        production: false,
      ),
      'ca-app-pub-3940256099942544/2247696110',
    );
    expect(
      RewardedAdService.nativeAdUnitIdFor(
        TargetPlatform.iOS,
        production: false,
      ),
      'ca-app-pub-3940256099942544/3986624511',
    );
  });

  test('Android publishing builds use the configured production unit', () {
    expect(
      RewardedAdService.adUnitIdFor(TargetPlatform.android, production: true),
      'ca-app-pub-5785529344181904/8865307585',
    );
    expect(
      RewardedAdService.nativeAdUnitIdFor(
        TargetPlatform.android,
        production: true,
      ),
      'ca-app-pub-5785529344181904/7488596402',
    );
  });

  test('iOS publishing builds use the configured rewarded production unit', () {
    expect(
      RewardedAdService.adUnitIdFor(TargetPlatform.iOS, production: true),
      'ca-app-pub-5785529344181904/8582236552',
    );
    expect(
      RewardedAdService.nativeAdUnitIdFor(TargetPlatform.iOS, production: true),
      'ca-app-pub-5785529344181904/9934846676',
    );
  });
}
