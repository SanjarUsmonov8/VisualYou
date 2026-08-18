# visualyou

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## AdMob ads

The Google Mobile Ads SDK is initialized at app startup. Debug/profile builds
use Google's official rewarded and native test ad units. Release builds use the
configured Android and iOS production rewarded and native IDs automatically.

The iOS Debug configuration uses Google's sample App ID, while Release uses the
Visual You iOS App ID. On iOS 14+, the app resolves ATT authorization before it
initializes Mobile Ads. `Info.plist` also contains the ATT usage description and
Google's SKAdNetwork identifiers.

Native ads are shown below the breathing card and above the useful-information
cards on Home, between the body and graphs on Body Statistics, and above the
gradual-reduction calendar on Calendar. Existing `Watch ad` choices use a
rewarded ad and unlock the requested action only after Google reports that the
reward was earned.

Run safely with test ads:

```sh
flutter run
```

Publishing builds select production IDs automatically:

```sh
flutter build appbundle --release
flutter build ios --release
```

To test release-mode behavior without live ad units, explicitly override the
selection:

```sh
flutter run --release --dart-define=ADMOB_USE_PRODUCTION=false
```

Never click live ads during development.
