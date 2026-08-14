import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/habits/habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/auth/email_auth_sheet.dart';
import 'package:visualyou/features/auth/email_auth.dart';
import 'package:visualyou/features/body/body.dart';
import 'package:visualyou/features/breathing/breathing_card.dart';
import 'package:visualyou/features/calendar/calendar_repository.dart';
import 'package:visualyou/features/calendar/habit_calendar.dart';
import 'package:visualyou/features/custom_graph/custom_graph.dart';
import 'package:visualyou/features/custom_graph/custom_graph_repository.dart';
import 'package:visualyou/features/female_body/female_body.dart';
import 'package:visualyou/features/habit_info/habit_info_cards.dart';
import 'package:visualyou/features/home_widgets/home_widget_service.dart';
import 'package:visualyou/features/reduction_calendar/reduction_calendar.dart';
import 'package:visualyou/features/reduction_calendar/reduction_calendar_repository.dart';
import 'package:visualyou/features/rewards/premium_page.dart';
import 'package:visualyou/features/rewards/rewards_controller.dart';
import 'package:visualyou/features/rewards/rewards_models.dart';
import 'package:visualyou/features/rewards/rewards_profile.dart';
import 'package:visualyou/features/rewards/rewards_repository.dart';
import 'package:visualyou/features/rewards/rewards_widgets.dart';
import 'package:visualyou/l10n/app_strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HomeWidgetService.initialize();
  runApp(const VisualYouApp());
}

class VisualYouApp extends StatefulWidget {
  const VisualYouApp({
    this.habitRepository,
    this.customGraphRepository,
    this.calendarRepository,
    this.reductionCalendarRepository,
    this.skipOnboarding = false,
    super.key,
  });

  final HabitRepository? habitRepository;
  final CustomGraphRepository? customGraphRepository;
  final CalendarRepository? calendarRepository;
  final ReductionCalendarRepository? reductionCalendarRepository;
  final bool skipOnboarding;

  @override
  State<VisualYouApp> createState() => _VisualYouAppState();
}

class _VisualYouAppState extends State<VisualYouApp>
    with WidgetsBindingObserver {
  final ThemeController _themeController = ThemeController();
  AppDatabase? _ownedDatabase;
  late final HabitRepository _habitRepository;
  late final CustomGraphRepository _customGraphRepository;
  late final CalendarRepository _calendarRepository;
  late final ReductionCalendarRepository _reductionCalendarRepository;
  late final RewardsController _rewardsController;
  bool _storageReady = false;
  bool _onboardingComplete = false;
  Object? _storageError;
  bool _refreshingDailyRecovery = false;
  final GlobalKey<_HomePageState> _homePageKey = GlobalKey<_HomePageState>();
  StreamSubscription<Uri?>? _widgetClickSubscription;
  final List<StreamSubscription<Object?>> _widgetDataSubscriptions = [];
  Uri? _pendingWidgetLaunch;
  bool _syncingWidgets = false;
  bool _syncWidgetsAgain = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final injectedRepository = widget.habitRepository;
    if (injectedRepository != null) {
      final database = (injectedRepository as DriftHabitRepository).database;
      _database = database;
      _habitRepository = injectedRepository;
      _customGraphRepository =
          widget.customGraphRepository ?? DriftCustomGraphRepository(database);
      _calendarRepository =
          widget.calendarRepository ?? DriftCalendarRepository(database);
      _reductionCalendarRepository =
          widget.reductionCalendarRepository ??
          DriftReductionCalendarRepository(database);
      _rewardsController = RewardsController(RewardsRepository(database));
    } else {
      final database = AppDatabase.defaults();
      _database = database;
      _ownedDatabase = database;
      _habitRepository = DriftHabitRepository(database);
      _customGraphRepository =
          widget.customGraphRepository ?? DriftCustomGraphRepository(database);
      _calendarRepository =
          widget.calendarRepository ?? DriftCalendarRepository(database);
      _reductionCalendarRepository =
          widget.reductionCalendarRepository ??
          DriftReductionCalendarRepository(database);
      _rewardsController = RewardsController(RewardsRepository(database));
    }
    _widgetClickSubscription = HomeWidgetService.clicked.listen(
      _handleWidgetLaunch,
    );
    unawaited(HomeWidgetService.initiallyLaunched().then(_handleWidgetLaunch));
    unawaited(_initializeStorage());
  }

  Future<void> _initializeStorage() async {
    try {
      await _habitRepository.initialize();
      await _rewardsController.initialize();
      await _themeController.restoreFrom(_habitRepository);
      BodyVisualState.restore(await _habitRepository.loadBodyState());
      final onboardingComplete =
          widget.skipOnboarding ||
          await _habitRepository.isOnboardingComplete();
      if (!mounted) return;
      setState(() {
        _storageReady = true;
        _storageError = null;
        _onboardingComplete = onboardingComplete;
      });
      _startWidgetDataObservers();
      _scheduleWidgetSync();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _deliverPendingWidgetLaunch();
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _storageReady = true;
        _storageError = error;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    final database = _ownedDatabase;
    if (database != null) unawaited(database.close());
    _themeController.removeListener(_scheduleWidgetSync);
    _themeController.dispose();
    _rewardsController.removeListener(_scheduleWidgetSync);
    _rewardsController.dispose();
    unawaited(_widgetClickSubscription?.cancel());
    for (final subscription in _widgetDataSubscriptions) {
      unawaited(subscription.cancel());
    }
    super.dispose();
  }

  late final AppDatabase _database;

  void _startWidgetDataObservers() {
    if (_widgetDataSubscriptions.isNotEmpty) return;
    _widgetDataSubscriptions.addAll([
      _habitRepository.watchHabitPreferences().listen(
        (_) => _scheduleWidgetSync(),
      ),
      _calendarRepository
          .watchMonth(DateTime.now())
          .listen((_) => _scheduleWidgetSync()),
      _reductionCalendarRepository
          .watchPlansMonth(DateTime.now())
          .listen((_) => _scheduleWidgetSync()),
    ]);
    _rewardsController.addListener(_scheduleWidgetSync);
    _themeController.addListener(_scheduleWidgetSync);
  }

  void _scheduleWidgetSync() {
    if (!_storageReady || _storageError != null) return;
    if (_syncingWidgets) {
      _syncWidgetsAgain = true;
      return;
    }
    _syncingWidgets = true;
    unawaited(() async {
      try {
        await HomeWidgetService.syncFromDatabase(_database);
      } catch (error) {
        debugPrint('Could not refresh home-screen widgets: $error');
      } finally {
        _syncingWidgets = false;
        if (_syncWidgetsAgain) {
          _syncWidgetsAgain = false;
          _scheduleWidgetSync();
        }
      }
    }());
  }

  void _handleWidgetLaunch(Uri? uri) {
    if (uri == null || uri.host != 'open') return;
    _pendingWidgetLaunch = uri;
    _deliverPendingWidgetLaunch();
  }

  void _deliverPendingWidgetLaunch() {
    if (!_storageReady || !_onboardingComplete) return;
    final uri = _pendingWidgetLaunch;
    final state = _homePageKey.currentState;
    if (uri == null || state == null) return;
    _pendingWidgetLaunch = null;
    state.openWidgetTarget(uri);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        _storageReady &&
        _storageError == null) {
      unawaited(_refreshDailyRecovery());
    }
  }

  Future<void> _refreshDailyRecovery() async {
    if (_refreshingDailyRecovery) return;
    _refreshingDailyRecovery = true;
    try {
      final bodyState = await _habitRepository.applyDailyRecovery();
      BodyVisualState.restore(bodyState);
      await _rewardsController.refresh();
    } catch (_) {
      // A later habit action or app resume will safely retry this local update.
    } finally {
      _refreshingDailyRecovery = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _themeController,
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VisualYou',
        locale: Locale(_themeController.language.code),
        supportedLocales: AppStrings.supportedLocales,
        localizationsDelegates: const [
          AppStrings.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        themeMode: _themeController.mode,
        theme: _buildTheme(_themeController.seedColor, Brightness.light),
        darkTheme: _buildTheme(_themeController.seedColor, Brightness.dark),
        home: !_storageReady
            ? const _StorageLoadingPage()
            : _storageError != null
            ? _StorageErrorPage(
                onRetry: () {
                  setState(() {
                    _storageReady = false;
                    _storageError = null;
                  });
                  unawaited(_initializeStorage());
                },
              )
            : !_onboardingComplete
            ? WelcomeFlow(
                themeController: _themeController,
                onFinished: _finishOnboarding,
              )
            : HomePage(
                key: _homePageKey,
                themeController: _themeController,
                habitRepository: _habitRepository,
                customGraphRepository: _customGraphRepository,
                calendarRepository: _calendarRepository,
                reductionCalendarRepository: _reductionCalendarRepository,
                rewardsController: _rewardsController,
              ),
      ),
    );
  }

  Future<void> _finishOnboarding() async {
    await _themeController.flushPersistence();
    await _habitRepository.completeOnboarding();
    if (!mounted) return;
    setState(() => _onboardingComplete = true);
  }

  ThemeData _buildTheme(Color seed, Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      fontFamily: 'sans-serif',
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }
}

class WelcomeFlow extends StatefulWidget {
  const WelcomeFlow({
    required this.themeController,
    required this.onFinished,
    this.previewMode = false,
    super.key,
  });

  final ThemeController themeController;
  final Future<void> Function() onFinished;
  final bool previewMode;

  @override
  State<WelcomeFlow> createState() => _WelcomeFlowState();
}

class _WelcomeFlowState extends State<WelcomeFlow> {
  static const int _profileSetupPageIndex = 6;
  final PageController _pageController = PageController();
  final GlobalKey<_WelcomeProfileSetupSlideState> _profileSetupKey =
      GlobalKey<_WelcomeProfileSetupSlideState>();
  final GlobalKey<_WelcomeAgreementSlideState> _agreementKey =
      GlobalKey<_WelcomeAgreementSlideState>();
  int _currentPage = 0;
  bool _finishing = false;

  List<Widget> get _pages => [
    _WelcomeIntroSlide(themeController: widget.themeController),
    const _WelcomeBodyProgressSlide(),
    const _WelcomeGradualReductionSlide(),
    const _WelcomeCustomCalendarSlide(),
    const _WelcomeMoreFeaturesSlide(),
    const _WelcomeAccountSlide(),
    _WelcomeProfileSetupSlide(
      key: _profileSetupKey,
      themeController: widget.themeController,
    ),
    _WelcomeAgreementSlide(
      key: _agreementKey,
      themeController: widget.themeController,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _next() async {
    if (_currentPage == _profileSetupPageIndex) {
      if (!widget.previewMode) {
        final profileReady = _profileSetupKey.currentState?.validateAndSave();
        if (profileReady == false) return;
      } else {
        _profileSetupKey.currentState?.saveDraft();
      }
    }
    if (_currentPage < _pages.length - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 360),
        curve: Curves.easeOutCubic,
      );
      return;
    }
    if (!widget.previewMode) {
      final agreementReady = _agreementKey.currentState?.validateAgreement();
      if (agreementReady == false) return;
    }
    if (_finishing) return;
    setState(() => _finishing = true);
    try {
      await _saveWelcomeSettings();
      await widget.onFinished();
    } finally {
      if (mounted) setState(() => _finishing = false);
    }
  }

  void _previous() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 360),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _closePreview() async {
    if (_finishing) return;
    setState(() => _finishing = true);
    try {
      await _saveWelcomeSettings();
      await widget.onFinished();
    } finally {
      if (mounted) setState(() => _finishing = false);
    }
  }

  Future<void> _saveWelcomeSettings() async {
    _profileSetupKey.currentState?.saveDraft();
    await widget.themeController.flushPersistence();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.themeController,
      builder: (context, _) => _buildFlow(context),
    );
  }

  Widget _buildFlow(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final keyboardVisible = MediaQuery.viewInsetsOf(context).bottom > 0;
    final appliesSelectedTheme = _currentPage >= _profileSetupPageIndex;
    final platformBrightness = MediaQuery.platformBrightnessOf(context);
    final selectedBrightness = switch (widget.themeController.mode) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system => platformBrightness,
    };
    final brightness = appliesSelectedTheme
        ? selectedBrightness
        : Brightness.light;
    final seedColor = appliesSelectedTheme
        ? widget.themeController.seedColor
        : const Color(0xFF526DFF);
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
      surface: appliesSelectedTheme ? null : Colors.white,
    );
    final welcomeTheme = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      fontFamily: 'sans-serif',
    );
    return Theme(
      data: welcomeTheme,
      child: Scaffold(
        backgroundColor: welcomeTheme.scaffoldBackgroundColor,
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (page) => setState(() => _currentPage = page),
              children: _pages,
            ),
            if (!keyboardVisible)
              Positioned(
                left: 24,
                right: 24,
                bottom: 16 + bottomPadding,
                child: Row(
                  children: [
                    if (_currentPage > 0)
                      TextButton.icon(
                        onPressed: _previous,
                        icon: const Icon(Icons.arrow_back_rounded),
                        label: Text(context.tr('Previous')),
                      ),
                    const Spacer(),
                    FilledButton.icon(
                      key: const Key('welcomeNextButton'),
                      onPressed: _finishing ? null : _next,
                      iconAlignment: IconAlignment.end,
                      icon: _finishing
                          ? const SizedBox.square(
                              dimension: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Icon(
                              _currentPage == _pages.length - 1
                                  ? Icons.check_rounded
                                  : Icons.arrow_forward_rounded,
                            ),
                      label: Text(
                        _currentPage == _pages.length - 1
                            ? context.tr('Done')
                            : context.tr('Next'),
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.previewMode)
              Positioned(
                left: 12,
                top: MediaQuery.paddingOf(context).top + 8,
                child: IconButton.filledTonal(
                  key: const Key('closeWelcomePreviewButton'),
                  tooltip: context.tr('Close preview'),
                  onPressed: _finishing ? null : _closePreview,
                  icon: const Icon(Icons.close_rounded),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeIntroSlide extends StatelessWidget {
  const _WelcomeIntroSlide({required this.themeController});

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 104),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/welcomepage/logocolor.png',
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/images/welcomepage/logoclose.png',
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 10, 16, 0),
            child: Align(
              alignment: Alignment.centerRight,
              child: PopupMenuButton<AppLanguage>(
                tooltip: context.tr('Choose language'),
                initialValue: themeController.language,
                onSelected: themeController.setLanguage,
                itemBuilder: (context) => AppLanguage.values
                    .map(
                      (language) => PopupMenuItem(
                        value: language,
                        child: Row(
                          children: [
                            if (language == themeController.language) ...[
                              Icon(
                                Icons.check_rounded,
                                size: 19,
                                color: colors.primary,
                              ),
                              const SizedBox(width: 8),
                            ],
                            Text(language.displayLabel(context)),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.language_rounded, size: 20),
                        const SizedBox(width: 7),
                        Text(themeController.language.displayLabel(context)),
                        const SizedBox(width: 3),
                        const Icon(Icons.arrow_drop_down_rounded, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 14, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  context.tr('Welcome to'),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF56C8E8),
                      Color(0xFF7A6DE8),
                      Color(0xFFE86596),
                      Color(0xFFF2A65A),
                    ],
                  ).createShader(bounds),
                  child: Text(
                    'Visual You',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.w800,
                      height: 1.05,
                    ),
                  ),
                ),
                const SizedBox(height: 34),
                Text(
                  context.tr(
                    'Track your habits visually, build healthier routines, reduce unwanted behaviors with clear plans, and get guidance from AI—all in one place.',
                  ),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontFamily: 'sans-serif-medium',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeBodyProgressSlide extends StatelessWidget {
  const _WelcomeBodyProgressSlide();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 104),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 26),
            child: AspectRatio(
              aspectRatio: 1394 / 864,
              child: Image.asset(
                'assets/images/welcomepage/quartrio2.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 34, 24, 0),
            child: Column(
              children: [
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF00A6C8),
                      Color(0xFF2FBF71),
                      Color(0xFFF2C94C),
                      Color(0xFFFF6B6B),
                    ],
                  ).createShader(bounds),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.tr('Body'),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                            height: 1.08,
                          ),
                        ),
                        Text(
                          context.tr('Progress'),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                            height: 1.08,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 92),
                Text(
                  context.tr('welcome_body_description'),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontFamily: 'sans-serif-medium',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeGradualReductionSlide extends StatelessWidget {
  const _WelcomeGradualReductionSlide();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 104),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 26),
            child: AspectRatio(
              aspectRatio: 1407 / 1118,
              child: Image.asset(
                'assets/images/welcomepage/calendar wp.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 34, 24, 0),
            child: Column(
              children: [
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF243B8F),
                      Color(0xFF5B5FEF),
                      Color(0xFF9B7EDE),
                      Color(0xFF63C7DA),
                    ],
                  ).createShader(bounds),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.tr('Gradual title line'),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                            height: 1.08,
                          ),
                        ),
                        Text(
                          context.tr('Reduction title line'),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                            height: 1.08,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 92),
                Text(
                  context.tr(
                    'Choose an unwanted habit and follow a custom hard, medium, or easy calendar that spaces allowed days farther apart over time. Adjust when needed, record honestly, and reduce at a pace you can sustain.',
                  ),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontFamily: 'sans-serif-medium',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeCustomCalendarSlide extends StatelessWidget {
  const _WelcomeCustomCalendarSlide();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 104),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 26),
            child: AspectRatio(
              aspectRatio: 1536 / 1024,
              child: Image.asset(
                'assets/images/welcomepage/customgraphwp.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 34, 24, 0),
            child: Column(
              children: [
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF8E2DE2),
                      Color(0xFFDA4453),
                      Color(0xFFF6A623),
                      Color(0xFF4BC0C8),
                    ],
                  ).createShader(bounds),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.tr('Custom title line'),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                            height: 1.08,
                          ),
                        ),
                        Text(
                          context.tr('Graph title line'),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                            height: 1.08,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 92),
                Text(
                  context.tr(
                    'Build a personalized calendar graph from up to three habits. Give each success or miss its own positive or negative value, then see all three combine into one line that reveals your progress over time.',
                  ),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontFamily: 'sans-serif-medium',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeMoreFeaturesSlide extends StatelessWidget {
  const _WelcomeMoreFeaturesSlide();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 104),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 26),
            child: AspectRatio(
              aspectRatio: 1536 / 1024,
              child: Image.asset(
                'assets/images/welcomepage/wp cards.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 34, 24, 0),
            child: Column(
              children: [
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF6A11CB),
                      Color(0xFF2575FC),
                      Color(0xFF00C9A7),
                      Color(0xFFFFC857),
                    ],
                  ).createShader(bounds),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.tr('More title line'),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                            height: 1.08,
                          ),
                        ),
                        Text(
                          context.tr('Features title line'),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                            height: 1.08,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 92),
                Text(
                  context.tr(
                    'Stay motivated with calendars, streaks, badges, reminders, and weekly insights. Personalize your experience and get helpful AI guidance as Visual You grows with you.',
                  ),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontFamily: 'sans-serif-medium',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeAccountSlide extends StatelessWidget {
  const _WelcomeAccountSlide();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 104),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/welcomepage/logocolor.png',
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/images/welcomepage/logoclose.png',
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 30, 24, 0),
            child: Column(
              children: [
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF3454D1),
                      Color(0xFF7B61D1),
                      Color(0xFFD14D8B),
                    ],
                  ).createShader(bounds),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${context.tr('Create title line')} ${context.tr('Account title line')}',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          height: 1.08,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    _AccountOptionButton(
                      icon: const Icon(Icons.email_outlined),
                      label: context.tr('Sign up with email'),
                      onPressed: () => showEmailSignupSheet(context),
                    ),
                    const SizedBox(height: 12),
                    _AccountOptionButton(
                      icon: Image.asset(
                        'assets/images/welcomepage/googlelogo.png',
                        width: 22,
                        height: 22,
                        fit: BoxFit.contain,
                      ),
                      label: context.tr('Continue with Google'),
                    ),
                    const SizedBox(height: 12),
                    _AccountOptionButton(
                      icon: const Icon(Icons.apple_rounded, size: 24),
                      label: context.tr('Continue with Apple'),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(context.tr('Already have an account?')),
                        TextButton(
                          onPressed: () => showEmailLoginSheet(context),
                          child: Text(context.tr('Log in')),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountOptionButton extends StatelessWidget {
  const _AccountOptionButton({
    required this.icon,
    required this.label,
    this.onPressed,
  });

  final Widget icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(
          label,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF242735),
          backgroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFFD9DCE5)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}

class _WelcomeProfileSetupSlide extends StatefulWidget {
  const _WelcomeProfileSetupSlide({required this.themeController, super.key});

  final ThemeController themeController;

  @override
  State<_WelcomeProfileSetupSlide> createState() =>
      _WelcomeProfileSetupSlideState();
}

class _WelcomeProfileSetupSlideState extends State<_WelcomeProfileSetupSlide> {
  late final TextEditingController _nameController;
  int? _day;
  int? _month;
  int? _year;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.themeController.profileName,
    );
    final birthDate = widget.themeController.profileBirthDate;
    _day = birthDate?.day;
    _month = birthDate?.month;
    _year = birthDate?.year;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  bool validateAndSave() {
    final birthDate = _selectedBirthDate;
    if (_nameController.text.trim().isEmpty || birthDate == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.tr('Complete your name and date of birth')),
          ),
        );
      return false;
    }
    widget.themeController.updateProfile(
      name: _nameController.text,
      birthDate: birthDate,
    );
    return true;
  }

  void saveDraft() {
    widget.themeController.updateProfile(
      name: _nameController.text,
      birthDate: _selectedBirthDate ?? widget.themeController.profileBirthDate,
    );
  }

  DateTime? get _selectedBirthDate {
    final day = _day;
    final month = _month;
    final year = _year;
    if (day == null || month == null || year == null) return null;
    final date = DateTime(year, month, day);
    if (date.year != year || date.month != month || date.day != day) {
      return null;
    }
    final today = DateTime.now();
    if (date.isAfter(DateTime(today.year, today.month, today.day))) return null;
    return date;
  }

  int get _daysInSelectedMonth {
    return DateUtils.getDaysInMonth(_year ?? 2000, _month ?? 1);
  }

  void _keepDayValid() {
    if (_day != null && _day! > _daysInSelectedMonth) _day = null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = widget.themeController;
    final currentYear = DateTime.now().year;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 112),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 38),
            child: Center(
              child: _EditableProfilePhoto(
                themeController: controller,
                radius: 58,
                showLabel: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 22, 24, 0),
            child: Column(
              children: [
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF35B8C8),
                      Color(0xFF6767D9),
                      Color(0xFFE45B8D),
                    ],
                  ).createShader(bounds),
                  child: Text(
                    context.tr('Almost done'),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  key: const Key('welcomeProfileName'),
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.done,
                  onChanged: (_) => saveDraft(),
                  onSubmitted: (_) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    labelText: context.tr('Name'),
                    prefixIcon: const Icon(Icons.person_outline_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) => SizedBox(
                    width: double.infinity,
                    child: SegmentedButton<AppGender>(
                      segments: [
                        ButtonSegment(
                          value: AppGender.male,
                          icon: const Icon(Icons.male_rounded),
                          label: Text(context.tr('Male')),
                        ),
                        ButtonSegment(
                          value: AppGender.female,
                          icon: const Icon(Icons.female_rounded),
                          label: Text(context.tr('Female')),
                        ),
                      ],
                      selected: {controller.gender},
                      onSelectionChanged: (selection) {
                        controller.setGender(selection.first);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        key: ValueKey('day-$_day-$_month-$_year'),
                        initialValue: _day,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: context.tr('Day'),
                          border: const OutlineInputBorder(),
                        ),
                        items: [
                          for (var day = 1; day <= _daysInSelectedMonth; day++)
                            DropdownMenuItem(value: day, child: Text('$day')),
                        ],
                        onChanged: (value) {
                          setState(() => _day = value);
                          saveDraft();
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        initialValue: _month,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: context.tr('Month'),
                          border: const OutlineInputBorder(),
                        ),
                        items: [
                          for (var month = 1; month <= 12; month++)
                            DropdownMenuItem(
                              value: month,
                              child: Text('$month'),
                            ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _month = value;
                            _keepDayValid();
                          });
                          saveDraft();
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        initialValue: _year,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: context.tr('Year'),
                          border: const OutlineInputBorder(),
                        ),
                        items: [
                          for (
                            var year = currentYear;
                            year >= currentYear - 120;
                            year--
                          )
                            DropdownMenuItem(value: year, child: Text('$year')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _year = value;
                            _keepDayValid();
                          });
                          saveDraft();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) => SizedBox(
                    width: double.infinity,
                    child: SegmentedButton<ThemeMode>(
                      segments: [
                        ButtonSegment(
                          value: ThemeMode.light,
                          icon: const Icon(Icons.light_mode_rounded),
                          label: Text(context.tr('Light')),
                        ),
                        ButtonSegment(
                          value: ThemeMode.system,
                          icon: const Icon(Icons.brightness_auto_rounded),
                          label: Text(context.tr('System')),
                        ),
                        ButtonSegment(
                          value: ThemeMode.dark,
                          icon: const Icon(Icons.dark_mode_rounded),
                          label: Text(context.tr('Dark')),
                        ),
                      ],
                      selected: {controller.mode},
                      onSelectionChanged: (selection) {
                        controller.setMode(selection.first);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) => SizedBox(
                    width: double.infinity,
                    child: SegmentedButton<AppAccent>(
                      segments: [
                        ButtonSegment(
                          value: AppAccent.blue,
                          icon: const Icon(
                            Icons.water_drop_rounded,
                            color: Color(0xFF526DFF),
                          ),
                          label: Text(context.tr('Blue')),
                        ),
                        ButtonSegment(
                          value: AppAccent.pink,
                          icon: const Icon(
                            Icons.favorite_rounded,
                            color: Color(0xFFE5478D),
                          ),
                          label: Text(context.tr('Pink')),
                        ),
                      ],
                      selected: {controller.accent},
                      onSelectionChanged: (selection) {
                        controller.setAccent(selection.first);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeAgreementSlide extends StatefulWidget {
  const _WelcomeAgreementSlide({required this.themeController, super.key});

  final ThemeController themeController;

  @override
  State<_WelcomeAgreementSlide> createState() => _WelcomeAgreementSlideState();
}

class _WelcomeAgreementSlideState extends State<_WelcomeAgreementSlide> {
  late bool _honestyAccepted;
  late bool _symbolicProgressAccepted;
  late bool _allAccepted;

  @override
  void initState() {
    super.initState();
    _allAccepted = widget.themeController.termsAccepted;
    _honestyAccepted = _allAccepted;
    _symbolicProgressAccepted = _allAccepted;
  }

  bool validateAgreement() {
    if (_allAccepted) return true;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            context.tr('Please accept the terms and policies to continue'),
          ),
        ),
      );
    return false;
  }

  void _setNote({required bool honesty, required bool value}) {
    setState(() {
      if (honesty) {
        _honestyAccepted = value;
      } else {
        _symbolicProgressAccepted = value;
      }
      _allAccepted = _honestyAccepted && _symbolicProgressAccepted;
    });
    widget.themeController.setTermsAccepted(_allAccepted);
  }

  void _setAll(bool value) {
    setState(() {
      _allAccepted = value;
      _honestyAccepted = value;
      _symbolicProgressAccepted = value;
    });
    widget.themeController.setTermsAccepted(value);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 54, 22, 116),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colors.primary.withValues(alpha: .72),
                  colors.primary,
                  colors.tertiary,
                ],
              ).createShader(bounds),
              child: Text(
                context.tr('Before you begin'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              context.tr(
                'Please read and acknowledge these important notes about using Visual You.',
              ),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colors.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 26),
            _AgreementNoteCard(
              key: const Key('honestyAgreementNote'),
              checked: _honestyAccepted,
              title: context.tr('Track honestly and consistently'),
              body: context.tr('agreement_honesty_note'),
              onChanged: (value) => _setNote(honesty: true, value: value),
            ),
            const SizedBox(height: 14),
            _AgreementNoteCard(
              key: const Key('symbolicAgreementNote'),
              checked: _symbolicProgressAccepted,
              title: context.tr('Understand symbolic progress'),
              body: context.tr('agreement_symbolic_note'),
              onChanged: (value) => _setNote(honesty: false, value: value),
            ),
            const SizedBox(height: 20),
            Material(
              color: _allAccepted
                  ? colors.primaryContainer
                  : colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(22),
              child: InkWell(
                key: const Key('allTermsAgreement'),
                borderRadius: BorderRadius.circular(22),
                onTap: () => _setAll(!_allAccepted),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 17,
                  ),
                  child: Row(
                    children: [
                      _CircularAgreementCheck(checked: _allAccepted),
                      const SizedBox(width: 13),
                      Expanded(
                        child: Text(
                          context.tr('I agree to the terms and policies'),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AgreementNoteCard extends StatelessWidget {
  const _AgreementNoteCard({
    required this.checked,
    required this.title,
    required this.body,
    required this.onChanged,
    super.key,
  });

  final bool checked;
  final String title;
  final String body;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: checked
          ? colors.primaryContainer.withValues(alpha: .62)
          : colors.surfaceContainer,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => onChanged(!checked),
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CircularAgreementCheck(checked: checked),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      body,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.48,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircularAgreementCheck extends StatelessWidget {
  const _CircularAgreementCheck({required this.checked});

  final bool checked;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 180),
      child: Icon(
        checked ? Icons.check_circle_rounded : Icons.circle_outlined,
        key: ValueKey(checked),
        size: 28,
        color: checked ? colors.primary : colors.outline,
      ),
    );
  }
}

class _EditableProfilePhoto extends StatelessWidget {
  const _EditableProfilePhoto({
    required this.themeController,
    required this.radius,
    this.showLabel = false,
  });

  final ThemeController themeController;
  final double radius;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        final imageBytes = themeController.profileImageBytes;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(
              button: true,
              label: context.tr(
                imageBytes == null
                    ? 'Add profile picture'
                    : 'Change profile picture',
              ),
              child: GestureDetector(
                key: const Key('profilePhotoButton'),
                onTap: () => _handleProfilePictureTap(context, themeController),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: radius * 2,
                      height: radius * 2,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [colors.primaryContainer, colors.primary],
                        ),
                      ),
                      child: ClipOval(
                        child: ColoredBox(
                          color: colors.surfaceContainer,
                          child: imageBytes == null
                              ? Icon(
                                  Icons.person_rounded,
                                  size: radius,
                                  color: colors.primary,
                                )
                              : Image.memory(
                                  imageBytes,
                                  fit: BoxFit.cover,
                                  alignment:
                                      themeController.profileImageAlignment,
                                  gaplessPlayback: true,
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: -2,
                      bottom: 2,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.primary,
                          border: Border.all(color: colors.surface, width: 3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Icon(
                            imageBytes == null
                                ? Icons.add_a_photo_rounded
                                : Icons.edit_rounded,
                            size: 19,
                            color: colors.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (showLabel) ...[
              const SizedBox(height: 10),
              Text(
                context.tr(
                  imageBytes == null
                      ? 'Add profile picture'
                      : 'Change profile picture',
                ),
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ],
        );
      },
    );
  }
}

enum _ProfilePhotoAction { choose, position, remove }

Future<void> _handleProfilePictureTap(
  BuildContext context,
  ThemeController themeController,
) async {
  if (themeController.profileImageBytes == null) {
    await _chooseProfilePicture(context, themeController);
    return;
  }
  final action = await showModalBottomSheet<_ProfilePhotoAction>(
    context: context,
    showDragHandle: true,
    builder: (sheetContext) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: Text(sheetContext.tr('Choose new picture')),
            onTap: () =>
                Navigator.pop(sheetContext, _ProfilePhotoAction.choose),
          ),
          ListTile(
            leading: const Icon(Icons.open_with_rounded),
            title: Text(sheetContext.tr('Adjust picture position')),
            onTap: () =>
                Navigator.pop(sheetContext, _ProfilePhotoAction.position),
          ),
          ListTile(
            leading: Icon(
              Icons.delete_outline_rounded,
              color: Theme.of(sheetContext).colorScheme.error,
            ),
            title: Text(sheetContext.tr('Remove picture')),
            onTap: () =>
                Navigator.pop(sheetContext, _ProfilePhotoAction.remove),
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
  if (!context.mounted || action == null) return;
  switch (action) {
    case _ProfilePhotoAction.choose:
      await _chooseProfilePicture(context, themeController);
      break;
    case _ProfilePhotoAction.position:
      await _adjustProfilePicturePosition(context, themeController);
      break;
    case _ProfilePhotoAction.remove:
      themeController.setProfileImage(null);
      break;
  }
}

Future<void> _chooseProfilePicture(
  BuildContext context,
  ThemeController themeController,
) async {
  try {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 82,
      requestFullMetadata: false,
    );
    if (image == null) return;
    themeController.setProfileImage(await image.readAsBytes());
    if (context.mounted) {
      await _adjustProfilePicturePosition(context, themeController);
    }
  } catch (_) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(context.tr('Could not open your photos'))),
      );
  }
}

Future<void> _adjustProfilePicturePosition(
  BuildContext context,
  ThemeController themeController,
) async {
  final imageBytes = themeController.profileImageBytes;
  if (imageBytes == null) return;
  var draftAlignment = themeController.profileImageAlignment;
  final selectedAlignment = await showDialog<Alignment>(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (context, setDialogState) => AlertDialog(
        title: Text(context.tr('Picture position')),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.tr('Drag the picture to position it inside the circle'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              GestureDetector(
                key: const Key('profilePictureCropArea'),
                behavior: HitTestBehavior.opaque,
                onPanUpdate: (details) {
                  setDialogState(() {
                    final nextX = (draftAlignment.x - details.delta.dx / 90)
                        .clamp(-1.0, 1.0)
                        .toDouble();
                    final nextY = (draftAlignment.y - details.delta.dy / 90)
                        .clamp(-1.0, 1.0)
                        .toDouble();
                    draftAlignment = Alignment(nextX, nextY);
                  });
                },
                child: SizedBox.square(
                  dimension: 250,
                  child: ClipRect(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.memory(
                          imageBytes,
                          fit: BoxFit.cover,
                          alignment: draftAlignment,
                          gaplessPlayback: true,
                        ),
                        IgnorePointer(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.onSurface,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        IgnorePointer(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: const [
                                BoxShadow(color: Colors.black54, blurRadius: 2),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(context.tr('Cancel')),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, draftAlignment),
            child: Text(context.tr('Save')),
          ),
        ],
      ),
    ),
  );
  if (selectedAlignment != null) {
    themeController.setProfileImageAlignment(selectedAlignment);
  }
}

class _StorageLoadingPage extends StatelessWidget {
  const _StorageLoadingPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _StorageErrorPage extends StatelessWidget {
  const _StorageErrorPage({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.storage_rounded, size: 52, color: colors.error),
                const SizedBox(height: 16),
                Text(
                  context.tr('Could not open offline storage'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(context.tr('Retry')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum AppAccent { blue, pink }

enum AppGender { male, female }

enum AppLanguage { english, spanish, russian, french, uzbek }

extension AppLanguageCode on AppLanguage {
  String get code => switch (this) {
    AppLanguage.english => 'en',
    AppLanguage.spanish => 'es',
    AppLanguage.russian => 'ru',
    AppLanguage.french => 'fr',
    AppLanguage.uzbek => 'uz',
  };

  String get labelKey => switch (this) {
    AppLanguage.english => 'English',
    AppLanguage.spanish => 'Spanish',
    AppLanguage.russian => 'Russian',
    AppLanguage.french => 'French',
    AppLanguage.uzbek => 'Uzbek',
  };

  String get nativeName => switch (this) {
    AppLanguage.english => 'English',
    AppLanguage.spanish => 'Español',
    AppLanguage.russian => 'Русский',
    AppLanguage.french => 'Français',
    AppLanguage.uzbek => 'O‘zbekcha',
  };

  String displayLabel(BuildContext context) {
    return '${context.tr(labelKey)} ($nativeName)';
  }
}

class ThemeController extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;
  AppAccent _accent = AppAccent.blue;
  AppGender _gender = AppGender.male;
  AppLanguage _language = AppLanguage.english;
  String _profileName = '';
  DateTime? _profileBirthDate;
  Uint8List? _profileImageBytes;
  double _profileImageAlignmentX = 0;
  double _profileImageAlignmentY = 0;
  bool _termsAccepted = false;
  HabitRepository? _repository;
  Future<void> _pendingSave = Future<void>.value();

  ThemeMode get mode => _mode;
  AppAccent get accent => _accent;
  AppGender get gender => _gender;
  AppLanguage get language => _language;
  String get profileName => _profileName;
  DateTime? get profileBirthDate => _profileBirthDate;
  Uint8List? get profileImageBytes => _profileImageBytes;
  Alignment get profileImageAlignment =>
      Alignment(_profileImageAlignmentX, _profileImageAlignmentY);
  bool get termsAccepted => _termsAccepted;
  int? get profileAge {
    final birthDate = _profileBirthDate;
    if (birthDate == null) return null;
    final today = DateTime.now();
    var age = today.year - birthDate.year;
    final birthdayPassed =
        today.month > birthDate.month ||
        (today.month == birthDate.month && today.day >= birthDate.day);
    if (!birthdayPassed) age--;
    return age;
  }

  bool get isUnder18 {
    final age = profileAge;
    return age != null && age < 18;
  }

  Color get seedColor => switch (_accent) {
    AppAccent.blue => const Color(0xFF526DFF),
    AppAccent.pink => const Color(0xFFE5478D),
  };

  void setMode(ThemeMode value) {
    if (_mode == value) return;
    _mode = value;
    notifyListeners();
    _persist();
  }

  void setAccent(AppAccent value) {
    if (_accent == value) return;
    _accent = value;
    notifyListeners();
    _persist();
  }

  void setGender(AppGender value) {
    if (_gender == value) return;
    _gender = value;
    notifyListeners();
    _persist();
  }

  void setLanguage(AppLanguage value) {
    if (_language == value) return;
    _language = value;
    notifyListeners();
    _persist();
  }

  void updateProfile({
    required String name,
    required DateTime? birthDate,
    AppGender? gender,
  }) {
    final trimmedName = name.trim();
    _profileName = trimmedName;
    _profileBirthDate = birthDate == null
        ? null
        : DateTime(birthDate.year, birthDate.month, birthDate.day);
    if (gender != null) _gender = gender;
    notifyListeners();
    _persist();
  }

  void setProfileImage(Uint8List? bytes) {
    _profileImageBytes = bytes;
    if (bytes == null) {
      _profileImageAlignmentX = 0;
      _profileImageAlignmentY = 0;
    }
    notifyListeners();
    _persist();
  }

  void setProfileImageAlignment(Alignment alignment) {
    _profileImageAlignmentX = alignment.x.clamp(-1.0, 1.0).toDouble();
    _profileImageAlignmentY = alignment.y.clamp(-1.0, 1.0).toDouble();
    notifyListeners();
    _persist();
  }

  void setTermsAccepted(bool accepted) {
    if (_termsAccepted == accepted) return;
    _termsAccepted = accepted;
    notifyListeners();
    _persist();
  }

  Future<void> restoreFrom(HabitRepository repository) async {
    _repository = repository;
    final preferences = await repository.loadAppPreferences();
    _mode = switch (preferences.themeMode) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
    _accent = preferences.accent == 'pink' ? AppAccent.pink : AppAccent.blue;
    _gender = preferences.gender == 'female'
        ? AppGender.female
        : AppGender.male;
    _language = AppLanguage.values.firstWhere(
      (language) => language.name == preferences.language,
      orElse: () => AppLanguage.english,
    );
    _profileName = preferences.profileName;
    _profileBirthDate = preferences.birthDate;
    try {
      _profileImageBytes = preferences.profileImageBase64.isEmpty
          ? null
          : base64Decode(preferences.profileImageBase64);
    } on FormatException {
      _profileImageBytes = null;
    }
    _profileImageAlignmentX = preferences.profileImageAlignmentX
        .clamp(-1.0, 1.0)
        .toDouble();
    _profileImageAlignmentY = preferences.profileImageAlignmentY
        .clamp(-1.0, 1.0)
        .toDouble();
    _termsAccepted = preferences.termsAccepted;
    notifyListeners();
  }

  Future<void> flushPersistence() => _pendingSave;

  void _persist() {
    final repository = _repository;
    if (repository == null) return;
    final snapshot = PersistedAppPreferences(
      themeMode: _mode.name,
      accent: _accent.name,
      gender: _gender.name,
      language: _language.name,
      profileName: _profileName,
      birthDate: _profileBirthDate,
      profileImageBase64: _profileImageBytes == null
          ? ''
          : base64Encode(_profileImageBytes!),
      profileImageAlignmentX: _profileImageAlignmentX,
      profileImageAlignmentY: _profileImageAlignmentY,
      termsAccepted: _termsAccepted,
    );
    _pendingSave = repository
        .saveAppPreferences(snapshot)
        .catchError((Object _) {});
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    required this.themeController,
    required this.habitRepository,
    required this.customGraphRepository,
    required this.calendarRepository,
    required this.reductionCalendarRepository,
    required this.rewardsController,
    super.key,
  });

  final ThemeController themeController;
  final HabitRepository habitRepository;
  final CustomGraphRepository customGraphRepository;
  final CalendarRepository calendarRepository;
  final ReductionCalendarRepository reductionCalendarRepository;
  final RewardsController rewardsController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final GlobalKey _addButtonKey = GlobalKey();
  final GlobalKey _quickAddKey = GlobalKey();
  final GlobalKey _reductionCalendarKey = GlobalKey();

  void openWidgetTarget(Uri uri) {
    final target = uri.pathSegments.firstOrNull;
    switch (target) {
      case 'quick-add':
        setState(() => _selectedIndex = 0);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final targetContext = _quickAddKey.currentContext;
          if (targetContext != null) {
            Scrollable.ensureVisible(
              targetContext,
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeOutCubic,
              alignment: .08,
            );
          }
        });
        break;
      case 'single-habit':
        setState(() => _selectedIndex = 0);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _showAddPage(context);
        });
        break;
      case 'calendar':
        setState(() => _selectedIndex = 2);
        break;
      case 'reduction':
        setState(() => _selectedIndex = 2);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final targetContext = _reductionCalendarKey.currentContext;
          if (targetContext != null) {
            Scrollable.ensureVisible(
              targetContext,
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeOutCubic,
              alignment: .08,
            );
          }
        });
        break;
      case 'streak':
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => ProfilePage(
              themeController: widget.themeController,
              rewardsController: widget.rewardsController,
              scrollToStreak: true,
            ),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                _HomeContent(
                  quickAddKey: _quickAddKey,
                  themeController: widget.themeController,
                  habitRepository: widget.habitRepository,
                  customGraphRepository: widget.customGraphRepository,
                  rewardsController: widget.rewardsController,
                ),
                _NavigationPage(
                  title: context.tr('Body statistics'),
                  icon: const AnatomyIcon(size: 72),
                  themeController: widget.themeController,
                  rewardsController: widget.rewardsController,
                  content: _GenderBodyFrame(
                    themeController: widget.themeController,
                    customGraphRepository: widget.customGraphRepository,
                    rewardsController: widget.rewardsController,
                    showSpecialHabitGraphs: true,
                  ),
                  showIcon: false,
                  topAligned: true,
                  gradientTitle: true,
                ),
                _NavigationPage(
                  title: context.tr('Calendar'),
                  icon: const Icon(Icons.calendar_month_rounded, size: 68),
                  themeController: widget.themeController,
                  rewardsController: widget.rewardsController,
                  content: Column(
                    children: [
                      HabitCalendar(
                        repository: widget.calendarRepository,
                        rewardsController: widget.rewardsController,
                      ),
                      AnimatedBuilder(
                        animation: widget.themeController,
                        builder: (context, _) =>
                            widget.themeController.isUnder18
                            ? const SizedBox.shrink()
                            : Column(
                                children: [
                                  const SizedBox(height: 14),
                                  RewardFeatureGate(
                                    key: _reductionCalendarKey,
                                    controller: widget.rewardsController,
                                    feature: GatedFeature.reductionCalendar,
                                    title: context.tr(
                                      'Gradual-reduction calendar',
                                    ),
                                    child: ReductionCalendar(
                                      repository:
                                          widget.reductionCalendarRepository,
                                      rewardsController:
                                          widget.rewardsController,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                  showIcon: false,
                  topAligned: true,
                  gradientTitle: true,
                ),
                _NavigationPage(
                  title: context.tr('AI coach'),
                  icon: const Icon(Icons.auto_awesome_rounded, size: 68),
                  themeController: widget.themeController,
                  rewardsController: widget.rewardsController,
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: VisualYouNavigationBar(
              addButtonKey: _addButtonKey,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              onAddPressed: () => _showAddPage(context),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddPage(BuildContext context) {
    final renderBox =
        _addButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final origin = renderBox.localToGlobal(renderBox.size.center(Offset.zero));
    Navigator.of(context).push(
      _CircularRevealRoute(
        origin: origin,
        page: AddHabitPage(
          habitRepository: widget.habitRepository,
          rewardsController: widget.rewardsController,
        ),
      ),
    );
  }
}

class _TopHeader extends StatelessWidget {
  const _TopHeader({
    required this.themeController,
    required this.rewardsController,
    this.useTestKeys = false,
  });

  final ThemeController themeController;
  final RewardsController rewardsController;
  final bool useTestKeys;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnimatedBuilder(
          animation: themeController,
          builder: (context, _) => InkWell(
            key: useTestKeys ? const Key('profileButton') : null,
            customBorder: const CircleBorder(),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => ProfilePage(
                  themeController: themeController,
                  rewardsController: rewardsController,
                ),
              ),
            ),
            child: _HeaderAvatar(themeController: themeController),
          ),
        ),
        Material(
          color: colors.primaryContainer.withValues(alpha: .72),
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAlias,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PremiumButton(controller: rewardsController),
              Container(
                width: 1,
                height: 25,
                color: colors.outlineVariant.withValues(alpha: .7),
              ),
              IconButton(
                key: useTestKeys ? const Key('settingsButton') : null,
                tooltip: context.tr('Settings'),
                icon: const Icon(Icons.settings_rounded),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) =>
                        SettingsPage(themeController: themeController),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeaderAvatar extends StatelessWidget {
  const _HeaderAvatar({required this.themeController});
  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final bytes = themeController.profileImageBytes;
    return Container(
      width: 52,
      height: 52,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [colors.primaryContainer, colors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipOval(
        child: bytes == null
            ? ColoredBox(
                color: colors.primary,
                child: Icon(
                  Icons.person_rounded,
                  color: colors.onPrimary,
                  size: 30,
                ),
              )
            : Image.memory(
                bytes,
                fit: BoxFit.cover,
                alignment: themeController.profileImageAlignment,
                gaplessPlayback: true,
              ),
      ),
    );
  }
}

List<Color> _pageTitleColors(String title) {
  if (title.contains('Calendar')) {
    return const [Color(0xFFFFB347), Color(0xFFFF6B6B), Color(0xFF8E54E9)];
  }
  if (title.contains('Body')) {
    return const [Color(0xFF26D0CE), Color(0xFF6A82FB), Color(0xFFB06AB3)];
  }
  if (title.contains('AI')) {
    return const [Color(0xFF00F2FE), Color(0xFF4FACFE), Color(0xFFA18CD1)];
  }
  return const [Color(0xFFFFD86F), Color(0xFFFC6262), Color(0xFF8B5CF6)];
}

class _GradientPageTitle extends StatelessWidget {
  const _GradientPageTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) =>
          LinearGradient(colors: _pageTitleColors(text)).createShader(bounds),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.quickAddKey,
    required this.themeController,
    required this.habitRepository,
    required this.customGraphRepository,
    required this.rewardsController,
  });

  final GlobalKey quickAddKey;
  final ThemeController themeController;
  final HabitRepository habitRepository;
  final CustomGraphRepository customGraphRepository;
  final RewardsController rewardsController;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final quickPanelColor = isDark
        ? colors.primaryContainer.withValues(alpha: .78)
        : colors.primaryContainer;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopHeader(
                themeController: themeController,
                rewardsController: rewardsController,
                useTestKeys: true,
              ),
              const SizedBox(height: 5),
              AnimatedBuilder(
                animation: themeController,
                builder: (context, _) => Text(
                  themeController.profileName.trim().isEmpty
                      ? context.tr('Hi!')
                      : '${context.tr('Hi!')} ${themeController.profileName.trim()}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: const [
                    Color(0xFF67D8F7),
                    Color(0xFF8B6FE8),
                    Color(0xFFF06F9B),
                    Color(0xFFF2A65A),
                  ],
                  stops: const [0, .34, .68, 1],
                ).createShader(bounds),
                child: Text(
                  context.tr('Let\'s build a better you'),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -.7,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              BreathingCard(
                onThreeMinutesReached: () =>
                    unawaited(_recordBreathingReward(context)),
              ),
              const SizedBox(height: 12),
              Container(
                key: quickAddKey,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: quickPanelColor,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    if (!isDark)
                      BoxShadow(
                        color: colors.primary.withValues(alpha: .22),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 11, 14, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('Quick add'),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8), //
                      StreamBuilder<List<HabitPreference>>(
                        stream: habitRepository.watchHabitPreferences(),
                        builder: (context, snapshot) {
                          final favorites =
                              (snapshot.data ?? const <HabitPreference>[])
                                  .where(
                                    (habit) =>
                                        habit.isActive &&
                                        habit.isFavorite &&
                                        (rewardsController.isPlus ||
                                            (habit.id != 'consuming_sugar' &&
                                                habit.id != 'studying' &&
                                                !habit.id.startsWith(
                                                  'custom_',
                                                ))),
                                  )
                                  .toList();
                          if (favorites.isEmpty) {
                            return Text(
                              context.tr(
                                'Choose Quick Add favorites with the pen on the add-habits page.',
                              ),
                              style: Theme.of(context).textTheme.bodySmall,
                            );
                          }
                          return Wrap(
                            spacing: 7,
                            runSpacing: 7,
                            children: [
                              for (final habit in favorites)
                                _QuickAddPill(
                                  label: context.tr(_quickAddLabelKey(habit)),
                                  isUnwanted:
                                      habit.category == 'reduction' ||
                                      habit.category == 'custom_bad',
                                  onThumbUp: () => unawaited(
                                    _showQuickAdded(
                                      context,
                                      _quickAddLabelKey(habit),
                                      didHabit:
                                          habit.category != 'reduction' &&
                                          habit.category != 'custom_bad',
                                    ),
                                  ),
                                  onThumbDown: () => unawaited(
                                    _showQuickAdded(
                                      context,
                                      _quickAddLabelKey(habit),
                                      didHabit:
                                          habit.category == 'reduction' ||
                                          habit.category == 'custom_bad',
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              _GenderBodyFrame(
                themeController: themeController,
                customGraphRepository: customGraphRepository,
                rewardsController: rewardsController,
                showSpecialHabitGraphs: false,
              ),
              const SizedBox(height: 14),
              const HabitInfoCards(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showQuickAdded(
    BuildContext context,
    String habit, {
    required bool didHabit,
  }) async {
    try {
      final bodyState = await habitRepository.recordHabit(
        habit,
        didHabit: didHabit,
      );
      BodyVisualState.restore(bodyState);
      await rewardsController.refresh();
    } catch (_) {
      if (!context.mounted) return;
      _showStorageFailure(context);
      return;
    }
    if (!context.mounted) return;
    _showHabitToast(
      context,
      didHabit
          ? context.habitAdded(context.tr(habit))
          : context.tr('Habit status saved'),
    );
  }

  Future<void> _recordBreathingReward(BuildContext context) async {
    try {
      final bodyState = await habitRepository.applyBreathingReward();
      BodyVisualState.restore(bodyState);
      await rewardsController.refresh();
      if (!context.mounted) return;
      _showHabitToast(
        context,
        context.tr('Three-minute breathing reward added'),
      );
    } catch (_) {
      if (context.mounted) _showStorageFailure(context);
    }
  }
}

class _QuickAddPill extends StatelessWidget {
  const _QuickAddPill({
    required this.label,
    required this.isUnwanted,
    required this.onThumbUp,
    required this.onThumbDown,
  });

  final String label;
  final bool isUnwanted;
  final VoidCallback onThumbUp;
  final VoidCallback onThumbDown;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final pillColor = isDark ? const Color(0xFFE8EAF0) : Colors.white;
    final contentColor = isDark
        ? const Color(0xFF30323A) // Dark-mode text and Plus color
        : colors.primary; // Keep Light mode unchanged
    return Material(
      color: pillColor,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: contentColor,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 6),
            SizedBox(
              width: 62,
              height: 44,
              child: Row(
                children: [
                  Expanded(
                    child: Tooltip(
                      message: context.tr('I did this habit'),
                      child: InkWell(
                        onTap: isUnwanted ? onThumbDown : onThumbUp,
                        child: Center(
                          child: Text(
                            isUnwanted ? '\u{1F44E}' : '\u{1F44D}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: contentColor.withValues(alpha: .25),
                  ),
                  Expanded(
                    child: Tooltip(
                      message: context.tr(
                        isUnwanted
                            ? 'I avoided this habit'
                            : 'I missed this habit',
                      ),
                      child: InkWell(
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(20),
                        ),
                        onTap: isUnwanted ? onThumbUp : onThumbDown,
                        child: Center(
                          child: Text(
                            isUnwanted ? '\u{1F44D}' : '\u{1F44E}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showStorageFailure(BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(context.tr('Could not save habit offline')),
        behavior: SnackBarBehavior.floating,
      ),
    );
}

OverlayEntry? _activeHabitToast;
Timer? _activeHabitToastTimer;

void _showHabitToast(BuildContext context, String message) {
  final overlay = Overlay.of(context, rootOverlay: true);
  final theme = Theme.of(context);
  final colors = theme.colorScheme;
  final bottomPadding = MediaQuery.paddingOf(context).bottom;

  _activeHabitToastTimer?.cancel();
  _activeHabitToast?.remove();

  late final OverlayEntry entry;
  entry = OverlayEntry(
    builder: (context) => Positioned(
      left: 20,
      right: 20,
      bottom: bottomPadding + 88,
      child: IgnorePointer(
        child: Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            builder: (context, value, child) => Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 8 * (1 - value)),
                child: child,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surface.withValues(
                      alpha: theme.brightness == Brightness.dark ? .72 : .78,
                    ),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: colors.outlineVariant.withValues(alpha: .45),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colors.shadow.withValues(alpha: .16),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  _activeHabitToast = entry;
  overlay.insert(entry);
  _activeHabitToastTimer = Timer(const Duration(milliseconds: 2200), () {
    if (_activeHabitToast == entry) _activeHabitToast = null;
    if (entry.mounted) entry.remove();
  });
}

String _quickAddLabelKey(HabitPreference habit) {
  return switch (habit.id) {
    'water' => 'Water',
    'healthy_eating' => 'Healthy meal',
    'workout_arms' => 'Arm workout',
    'workout_abs' => 'Abs workout',
    _ => habit.nameKey,
  };
}

class _GenderBodyFrame extends StatelessWidget {
  const _GenderBodyFrame({
    required this.themeController,
    required this.customGraphRepository,
    required this.showSpecialHabitGraphs,
    required this.rewardsController,
  });

  final ThemeController themeController;
  final CustomGraphRepository customGraphRepository;
  final bool showSpecialHabitGraphs;
  final RewardsController rewardsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        final body = themeController.gender == AppGender.male
            ? const BodyFrame(key: ValueKey('maleBody'))
            : const FemaleBodyFrame(key: ValueKey('femaleBody'));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RewardFeatureGate(
              controller: rewardsController,
              feature: GatedFeature.body,
              title: context.tr('Visual body'),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 320),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(
                        begin: .98,
                        end: 1,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: body,
              ),
            ),
            const SizedBox(height: 12),
            RewardFeatureGate(
              controller: rewardsController,
              feature: GatedFeature.graphs,
              title: context.tr('Progress graphs'),
              child: Column(
                children: [
                  CustomGraphCard(
                    repository: customGraphRepository,
                    rewardsController: rewardsController,
                  ),
                  if (showSpecialHabitGraphs) ...[
                    const SizedBox(height: 10),
                    SpecialHabitGraphsSection(
                      repository: customGraphRepository,
                      rewardsController: rewardsController,
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _NavigationPage extends StatelessWidget {
  const _NavigationPage({
    required this.title,
    required this.icon,
    required this.themeController,
    required this.rewardsController,
    this.content,
    this.showIcon = true,
    this.topAligned = false,
    this.gradientTitle = false,
  });

  final String title;
  final Widget icon;
  final ThemeController themeController;
  final RewardsController rewardsController;
  final Widget? content;
  final bool showIcon;
  final bool topAligned;
  final bool gradientTitle;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 110),
          child: Column(
            crossAxisAlignment: topAligned
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              _TopHeader(
                themeController: themeController,
                rewardsController: rewardsController,
              ),
              const SizedBox(height: 18),
              if (showIcon) ...[
                IconTheme(
                  data: IconThemeData(color: colors.primary),
                  child: icon,
                ),
                const SizedBox(height: 16),
              ],
              Align(
                alignment: topAligned ? Alignment.centerLeft : Alignment.center,
                child: gradientTitle
                    ? ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) => LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: _pageTitleColors(title),
                          stops: const [0, .5, 1],
                        ).createShader(bounds),
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -.5,
                              ),
                        ),
                      )
                    : Text(
                        title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
              ),
              if (content != null) ...[
                SizedBox(height: topAligned ? 10 : 20),
                content!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class VisualYouNavigationBar extends StatelessWidget {
  const VisualYouNavigationBar({
    required this.addButtonKey,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.onAddPressed,
    super.key,
  });

  final GlobalKey addButtonKey;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(22, 0, 22, 18),
      child: Row(
        children: [
          Expanded(
            child: _BlurredCapsule(
              height: 55,
              colors: colors,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavButton(
                      tooltip: context.tr('Home'),
                      icon: const Icon(Icons.home_rounded),
                      selected: selectedIndex == 0,
                      onTap: () => onDestinationSelected(0),
                    ),
                    _NavButton(
                      tooltip: context.tr('Body statistics'),
                      icon: const AnatomyIcon(),
                      selected: selectedIndex == 1,
                      onTap: () => onDestinationSelected(1),
                    ),
                    _NavButton(
                      tooltip: context.tr('Calendar'),
                      icon: const Icon(Icons.calendar_month_rounded),
                      selected: selectedIndex == 2,
                      onTap: () => onDestinationSelected(2),
                    ),
                    _NavButton(
                      tooltip: context.tr('AI coach'),
                      icon: const Icon(Icons.auto_awesome_rounded),
                      selected: selectedIndex == 3,
                      onTap: () => onDestinationSelected(3),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          _BlurredCapsule(
            key: addButtonKey,
            width: 55,
            height: 55,
            colors: colors,
            child: IconButton(
              key: const Key('addHabitButton'),
              tooltip: context.tr('Add habit'),
              onPressed: onAddPressed,
              icon: const Icon(Icons.add_rounded, size: 28),
              color: colors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _BlurredCapsule extends StatelessWidget {
  const _BlurredCapsule({
    required this.height,
    required this.colors,
    required this.child,
    this.width,
    super.key,
  });

  final double height;
  final double? width;
  final ColorScheme colors;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const radius = BorderRadius.all(Radius.circular(30));
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: .12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: ColoredBox(
            color: colors.primaryContainer.withValues(alpha: .78),
            child: child,
          ),
        ),
      ),
    );
  }
}

class AddHabitPage extends StatefulWidget {
  const AddHabitPage({
    required this.habitRepository,
    required this.rewardsController,
    super.key,
  });

  final HabitRepository habitRepository;
  final RewardsController rewardsController;

  @override
  State<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  static const _goodHabits = [
    _HabitOption('water', 'Drinking water', Icons.water_drop_rounded),
    _HabitOption('healthy_eating', 'Eating healthy', Icons.eco_rounded),
    _HabitOption('studying', 'Studying', Icons.school_rounded),
  ];

  static const _exercises = [
    _HabitOption('workout_arms', 'Arm', Icons.fitness_center_rounded),
    _HabitOption(
      'workout_shoulders_back',
      'Shoulder / Back',
      Icons.accessibility_new_rounded,
    ),
    _HabitOption('workout_chest', 'Chest', Icons.monitor_heart_outlined),
    _HabitOption('workout_abs', 'Abs', Icons.grid_view_rounded),
    _HabitOption('workout_legs', 'Legs', Icons.directions_run_rounded),
  ];

  static const _badHabits = [
    _HabitOption('smoking', 'Smoking', Icons.smoke_free_rounded),
    _HabitOption('vaping', 'Vaping', Icons.air_rounded),
    _HabitOption('alcohol', 'Alcohol', Icons.local_bar_rounded),
    _HabitOption(
      'unhealthy_eating',
      'Unhealthy eating',
      Icons.fastfood_rounded,
    ),
    _HabitOption('adult_videos', 'Adult videos', Icons.visibility_off_rounded),
    _HabitOption(
      'masturbation',
      'Masturbation',
      Icons.self_improvement_rounded,
    ),
    _HabitOption('consuming_sugar', 'Consuming sugar', Icons.cake_rounded),
  ];

  bool _editing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: context.tr('Close'),
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded),
        ),
        title: _GradientPageTitle(context.tr('Add a habit')),
        actions: [
          IconButton(
            tooltip: context.tr(_editing ? 'Finish editing' : 'Edit habits'),
            onPressed: () => setState(() => _editing = !_editing),
            icon: Icon(_editing ? Icons.check_rounded : Icons.edit_rounded),
          ),
        ],
      ),
      body: StreamBuilder<List<HabitPreference>>(
        stream: widget.habitRepository.watchHabitPreferences(),
        builder: (context, snapshot) {
          final preferences = {
            for (final preference in snapshot.data ?? const <HabitPreference>[])
              preference.id: preference,
          };
          final customGood = preferences.values
              .where((habit) => habit.category == 'custom_good')
              .map(
                (habit) => _HabitOption(
                  habit.id,
                  habit.nameKey,
                  Icons.auto_awesome_rounded,
                ),
              )
              .toList();
          final customBad = preferences.values
              .where((habit) => habit.category == 'custom_bad')
              .map(
                (habit) =>
                    _HabitOption(habit.id, habit.nameKey, Icons.block_rounded),
              )
              .toList();
          final customCount = customGood.length + customBad.length;
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            children: [
              if (_editing) ...[
                Text(
                  context.tr(
                    'Use the star for Quick Add. Remove or restore habits with the button beside it.',
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                if (widget.rewardsController.isPlus) ...[
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.tonalIcon(
                      onPressed: customCount >= 2
                          ? null
                          : () => _createCustomHabit(context),
                      icon: const Icon(Icons.add_rounded),
                      label: Text(
                        customCount >= 2
                            ? context.tr('Two custom habits created')
                            : context.tr('Create your own habit'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ],
              _buildSection(
                context,
                title: 'Good habits',
                options: [..._goodHabits, ...customGood],
                preferences: preferences,
              ),
              const SizedBox(height: 12),
              _buildSection(
                context,
                title: 'Exercises',
                options: _exercises,
                preferences: preferences,
                inCard: true,
              ),
              const SizedBox(height: 14),
              _buildSection(
                context,
                title: 'Bad habits',
                options: [..._badHabits, ...customBad],
                preferences: preferences,
                isUnwanted: true,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<_HabitOption> options,
    required Map<String, HabitPreference> preferences,
    bool inCard = false,
    bool isUnwanted = false,
  }) {
    final availableOptions = !widget.rewardsController.isPlus && !_editing
        ? options.where((option) => !_isPremiumHabit(option.id)).toList()
        : options;
    final visibleOptions = _editing
        ? availableOptions
        : availableOptions
              .where((option) => preferences[option.id]?.isActive ?? true)
              .toList();
    if (visibleOptions.isEmpty && !_editing) {
      return const SizedBox.shrink();
    }

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr(title),
          style:
              (inCard
                      ? Theme.of(context).textTheme.titleMedium
                      : Theme.of(context).textTheme.headlineSmall)
                  ?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: _editing ? 2.55 : (inCard ? 3.5 : 3.2),
          children: [
            for (final option in visibleOptions)
              if (_isPremiumHabit(option.id) &&
                  !widget.rewardsController.isPlus)
                _PremiumHabitTile(
                  label: context.tr(option.nameKey),
                  icon: option.icon,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) =>
                          PremiumPage(controller: widget.rewardsController),
                    ),
                  ),
                )
              else if (_editing)
                _HabitManagementTile(
                  label: context.tr(option.nameKey),
                  icon: option.icon,
                  isActive: preferences[option.id]?.isActive ?? true,
                  isFavorite: preferences[option.id]?.isFavorite ?? false,
                  onActiveChanged: (active) => unawaited(
                    widget.habitRepository.setHabitActive(option.id, active),
                  ),
                  onFavoriteChanged: (favorite) => unawaited(
                    widget.habitRepository.setHabitFavorite(
                      option.id,
                      favorite,
                    ),
                  ),
                  onEdit: option.id.startsWith('custom_')
                      ? () => _editCustomHabit(context, preferences[option.id]!)
                      : null,
                  onDelete: option.id.startsWith('custom_')
                      ? () =>
                            _deleteCustomHabit(context, preferences[option.id]!)
                      : null,
                )
              else if (inCard)
                _ExerciseRow(
                  label: context.tr(option.nameKey),
                  icon: option.icon,
                  onThumbUp: () => unawaited(
                    _showAdded(context, option.nameKey, didHabit: true),
                  ),
                  onThumbDown: () => unawaited(
                    _showAdded(context, option.nameKey, didHabit: false),
                  ),
                  isUnwanted: isUnwanted,
                )
              else
                _HabitTile(
                  label: context.tr(option.nameKey),
                  icon: option.icon,
                  onThumbUp: () => unawaited(
                    _showAdded(context, option.nameKey, didHabit: !isUnwanted),
                  ),
                  onThumbDown: () => unawaited(
                    _showAdded(context, option.nameKey, didHabit: isUnwanted),
                  ),
                  isUnwanted: isUnwanted,
                ),
          ],
        ),
      ],
    );

    if (!inCard) return content;
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
        child: content,
      ),
    );
  }

  Future<void> _showAdded(
    BuildContext context,
    String habit, {
    required bool didHabit,
  }) async {
    try {
      final bodyState = await widget.habitRepository.recordHabit(
        habit,
        didHabit: didHabit,
      );
      BodyVisualState.restore(bodyState);
      await widget.rewardsController.refresh();
    } catch (_) {
      if (!context.mounted) return;
      _showStorageFailure(context);
      return;
    }
    if (!context.mounted) return;
    _showHabitToast(
      context,
      didHabit
          ? context.habitAdded(context.tr(habit))
          : context.tr('Habit status saved'),
    );
  }

  Future<void> _createCustomHabit(BuildContext context) async {
    final draft = await _showCustomHabitDialog(
      context,
      title: context.tr('Create your own habit'),
      action: context.tr('Create'),
    );
    if (draft == null) return;
    try {
      await widget.habitRepository.createCustomHabit(
        name: draft.name,
        isUnwanted: draft.isUnwanted,
      );
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.tr('Could not create habit'))),
      );
    }
  }

  Future<void> _editCustomHabit(
    BuildContext context,
    HabitPreference habit,
  ) async {
    final draft = await _showCustomHabitDialog(
      context,
      title: context.tr('Edit habits'),
      action: context.tr('Save'),
      initialName: habit.nameKey,
      initialUnwanted: habit.category == 'custom_bad',
    );
    if (draft == null) return;
    try {
      await widget.habitRepository.updateCustomHabit(
        habitId: habit.id,
        name: draft.name,
        isUnwanted: draft.isUnwanted,
      );
    } catch (_) {
      if (!context.mounted) return;
      _showStorageFailure(context);
    }
  }

  Future<void> _deleteCustomHabit(
    BuildContext context,
    HabitPreference habit,
  ) async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(context.tr('Remove habit')),
            content: Text('${context.tr('Remove habit')}: “${habit.nameKey}”?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text(context.tr('Cancel')),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: Text(context.tr('Remove habit')),
              ),
            ],
          ),
        ) ??
        false;
    if (!confirmed) return;
    try {
      await widget.habitRepository.deleteCustomHabit(habit.id);
    } catch (_) {
      if (!context.mounted) return;
      _showStorageFailure(context);
    }
  }

  Future<_CustomHabitDraft?> _showCustomHabitDialog(
    BuildContext context, {
    required String title,
    required String action,
    String initialName = '',
    bool initialUnwanted = false,
  }) async {
    final controller = TextEditingController(text: initialName);
    var unwanted = initialUnwanted;
    final result = await showDialog<_CustomHabitDraft>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                autofocus: true,
                maxLength: 40,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: context.tr('Habit name'),
                ),
              ),
              const SizedBox(height: 12),
              SegmentedButton<bool>(
                segments: [
                  ButtonSegment(
                    value: false,
                    label: Text(context.tr('Good habit')),
                    icon: const Icon(Icons.thumb_up_alt_outlined),
                  ),
                  ButtonSegment(
                    value: true,
                    label: Text(context.tr('Unwanted habit')),
                    icon: const Icon(Icons.thumb_down_alt_outlined),
                  ),
                ],
                selected: {unwanted},
                onSelectionChanged: (selection) =>
                    setDialogState(() => unwanted = selection.first),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(context.tr('Cancel')),
            ),
            FilledButton(
              onPressed: () {
                final name = controller.text.trim();
                if (name.isEmpty) return;
                Navigator.pop(
                  dialogContext,
                  _CustomHabitDraft(name: name, isUnwanted: unwanted),
                );
              },
              child: Text(action),
            ),
          ],
        ),
      ),
    );
    controller.dispose();
    return result;
  }

  bool _isPremiumHabit(String habitId) =>
      habitId == 'consuming_sugar' || habitId == 'studying';
}

class _CustomHabitDraft {
  const _CustomHabitDraft({required this.name, required this.isUnwanted});

  final String name;
  final bool isUnwanted;
}

class _PremiumHabitTile extends StatelessWidget {
  const _PremiumHabitTile({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      color: colors.surfaceContainerHighest,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          child: Row(
            children: [
              Icon(icon, color: colors.onSurfaceVariant, size: 19),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Icon(Icons.workspace_premium_rounded, color: colors.primary),
            ],
          ),
        ),
      ),
    );
  }
}

class _HabitOption {
  const _HabitOption(this.id, this.nameKey, this.icon);

  final String id;
  final String nameKey;
  final IconData icon;
}

class _HabitManagementTile extends StatelessWidget {
  const _HabitManagementTile({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.isFavorite,
    required this.onActiveChanged,
    required this.onFavoriteChanged,
    this.onEdit,
    this.onDelete,
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final bool isFavorite;
  final ValueChanged<bool> onActiveChanged;
  final ValueChanged<bool> onFavoriteChanged;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      color: isActive ? null : colors.surfaceContainerHighest,
      child: Row(
        children: [
          const SizedBox(width: 8),
          Icon(icon, color: isActive ? colors.primary : colors.outline),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isActive ? null : colors.onSurfaceVariant,
              ),
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            constraints: const BoxConstraints.tightFor(width: 32, height: 32),
            padding: EdgeInsets.zero,
            tooltip: context.tr(
              isFavorite ? 'Remove from Quick Add' : 'Add to Quick Add',
            ),
            onPressed: isActive ? () => onFavoriteChanged(!isFavorite) : null,
            icon: Icon(
              isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
              size: 20,
              color: isFavorite ? colors.primary : colors.onSurfaceVariant,
            ),
          ),
          if (onEdit != null && onDelete != null)
            PopupMenuButton<_CustomHabitAction>(
              tooltip: context.tr('Edit habits'),
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.more_vert_rounded, size: 20),
              onSelected: (action) {
                switch (action) {
                  case _CustomHabitAction.edit:
                    onEdit!();
                    break;
                  case _CustomHabitAction.delete:
                    onDelete!();
                    break;
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: _CustomHabitAction.edit,
                  child: ListTile(
                    leading: const Icon(Icons.edit_rounded),
                    title: Text(context.tr('Edit habits')),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                PopupMenuItem(
                  value: _CustomHabitAction.delete,
                  child: ListTile(
                    leading: Icon(Icons.delete_outline, color: colors.error),
                    title: Text(context.tr('Remove habit')),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            )
          else
            IconButton(
              visualDensity: VisualDensity.compact,
              constraints: const BoxConstraints.tightFor(width: 32, height: 32),
              padding: EdgeInsets.zero,
              tooltip: context.tr(isActive ? 'Remove habit' : 'Restore habit'),
              onPressed: () => onActiveChanged(!isActive),
              icon: Icon(
                isActive
                    ? Icons.remove_circle_outline
                    : Icons.add_circle_outline,
                size: 20,
                color: isActive ? colors.error : colors.primary,
              ),
            ),
        ],
      ),
    );
  }
}

enum _CustomHabitAction { edit, delete }

class _HabitTile extends StatelessWidget {
  const _HabitTile({
    required this.label,
    required this.icon,
    required this.onThumbUp,
    required this.onThumbDown,
    required this.isUnwanted,
  });

  final String label;
  final IconData icon;
  final VoidCallback onThumbUp;
  final VoidCallback onThumbDown;
  final bool isUnwanted;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 65,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 6, 5, 6),
              child: Row(
                children: [
                  Icon(icon, color: colors.primary, size: 19),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
            ),
          ),
          Container(
            width: 1,
            color: colors.outlineVariant.withValues(alpha: .65),
          ),
          Expanded(
            flex: 35,
            child: _ThumbActions(
              isUnwanted: isUnwanted,
              onThumbUp: onThumbUp,
              onThumbDown: onThumbDown,
              rightRadius: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseRow extends StatelessWidget {
  const _ExerciseRow({
    required this.label,
    required this.icon,
    required this.onThumbUp,
    required this.onThumbDown,
    required this.isUnwanted,
  });

  final String label;
  final IconData icon;
  final VoidCallback onThumbUp;
  final VoidCallback onThumbDown;
  final bool isUnwanted;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.primaryContainer.withValues(alpha: .38),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 65,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(9, 3, 3, 3),
              child: Row(
                children: [
                  Icon(icon, color: colors.primary, size: 17),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13.5),
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
              ),
            ),
          ),
          Container(
            width: 1,
            color: colors.outlineVariant.withValues(alpha: .65),
          ),
          Expanded(
            flex: 35,
            child: _ThumbActions(
              isUnwanted: isUnwanted,
              onThumbUp: onThumbUp,
              onThumbDown: onThumbDown,
              rightRadius: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _ThumbActions extends StatelessWidget {
  const _ThumbActions({
    required this.isUnwanted,
    required this.onThumbUp,
    required this.onThumbDown,
    required this.rightRadius,
  });

  final bool isUnwanted;
  final VoidCallback onThumbUp;
  final VoidCallback onThumbDown;
  final double rightRadius;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Tooltip(
            message: context.tr('I did this habit'),
            child: InkWell(
              onTap: isUnwanted ? onThumbDown : onThumbUp,
              child: Center(
                child: Text(
                  isUnwanted ? '\u{1F44E}' : '\u{1F44D}',
                  style: const TextStyle(fontSize: 17),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 1,
          height: 22,
          color: colors.outlineVariant.withValues(alpha: .65),
        ),
        Expanded(
          child: Tooltip(
            message: context.tr(
              isUnwanted ? 'I avoided this habit' : 'I missed this habit',
            ),
            child: InkWell(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(rightRadius),
                bottomRight: Radius.circular(rightRadius),
              ),
              onTap: isUnwanted ? onThumbUp : onThumbDown,
              child: Center(
                child: Text(
                  isUnwanted ? '\u{1F44D}' : '\u{1F44E}',
                  style: const TextStyle(fontSize: 17),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CircularRevealRoute extends PageRouteBuilder<void> {
  _CircularRevealRoute({required Offset origin, required Widget page})
    : super(
        opaque: false,
        barrierColor: Colors.transparent,
        transitionDuration: const Duration(milliseconds: 480),
        reverseTransitionDuration: const Duration(milliseconds: 360),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          );
          return AnimatedBuilder(
            animation: curvedAnimation,
            child: child,
            builder: (context, child) {
              return ClipPath(
                clipper: _CircularRevealClipper(
                  origin: origin,
                  progress: curvedAnimation.value,
                ),
                child: child,
              );
            },
          );
        },
      );
}

class _CircularRevealClipper extends CustomClipper<Path> {
  const _CircularRevealClipper({required this.origin, required this.progress});

  final Offset origin;
  final double progress;

  @override
  Path getClip(Size size) {
    final farthestX = origin.dx > size.width / 2
        ? origin.dx
        : size.width - origin.dx;
    final farthestY = origin.dy > size.height / 2
        ? origin.dy
        : size.height - origin.dy;
    final maximumRadius = Offset(farthestX, farthestY).distance;
    return Path()..addOval(
      Rect.fromCircle(center: origin, radius: maximumRadius * progress),
    );
  }

  @override
  bool shouldReclip(covariant _CircularRevealClipper oldClipper) {
    return oldClipper.progress != progress || oldClipper.origin != origin;
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.tooltip,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String tooltip;
  final Widget icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Tooltip(
      message: tooltip,
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          width: selected ? 58 : 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: selected ? colors.primary : Colors.transparent,
          ),
          child: IconTheme(
            data: IconThemeData(
              color: selected ? colors.onPrimary : colors.onPrimaryContainer,
              size: 25,
            ),
            child: Center(child: icon),
          ),
        ),
      ),
    );
  }
}

class AnatomyIcon extends StatelessWidget {
  const AnatomyIcon({this.size = 27, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _AnatomyIconPainter(IconTheme.of(context).color ?? Colors.black),
    );
  }
}

class _AnatomyIconPainter extends CustomPainter {
  const _AnatomyIconPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 28;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8 * scale
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path()
      ..moveTo(17 * scale, 4 * scale)
      ..cubicTo(
        12 * scale,
        3 * scale,
        9 * scale,
        6 * scale,
        9 * scale,
        10 * scale,
      )
      ..lineTo(6 * scale, 13 * scale)
      ..lineTo(9 * scale, 14 * scale)
      ..cubicTo(
        9 * scale,
        18 * scale,
        11 * scale,
        19 * scale,
        12 * scale,
        19 * scale,
      )
      ..lineTo(12 * scale, 22 * scale)
      ..cubicTo(
        9 * scale,
        22.5 * scale,
        5 * scale,
        24 * scale,
        3 * scale,
        27 * scale,
      )
      ..moveTo(17 * scale, 4 * scale)
      ..cubicTo(
        21 * scale,
        6 * scale,
        22 * scale,
        11 * scale,
        20 * scale,
        15 * scale,
      )
      ..cubicTo(
        19 * scale,
        17 * scale,
        17 * scale,
        18.5 * scale,
        16 * scale,
        19 * scale,
      )
      ..lineTo(16 * scale, 22 * scale)
      ..cubicTo(
        19 * scale,
        22.5 * scale,
        23 * scale,
        24 * scale,
        25 * scale,
        27 * scale,
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _AnatomyIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    required this.themeController,
    required this.rewardsController,
    this.scrollToStreak = false,
    super.key,
  });

  final ThemeController themeController;
  final RewardsController rewardsController;
  final bool scrollToStreak;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      body: AnimatedBuilder(
        animation: Listenable.merge([themeController, rewardsController]),
        builder: (context, _) => DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                colors.primary.withValues(alpha: isDark ? .48 : .42),
                colors.primaryContainer.withValues(alpha: isDark ? .28 : .38),
                colors.surface.withValues(alpha: .96),
                colors.surface,
              ],
              stops: const [0, .27, .62, 1],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                8,
                20,
                MediaQuery.paddingOf(context).bottom + 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton.filledTonal(
                          tooltip: context.tr('Back'),
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back_rounded),
                        ),
                        const Spacer(),
                        IconButton.filledTonal(
                          tooltip: context.tr('Edit profile'),
                          onPressed: () => _showEditProfileDialog(context),
                          icon: const Icon(Icons.edit_rounded, size: 19),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _EditableProfilePhoto(
                          themeController: themeController,
                          radius: 52,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                themeController.profileName.isEmpty
                                    ? context.tr('Your Name')
                                    : themeController.profileName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      height: 1.1,
                                    ),
                              ),
                              const SizedBox(height: 14),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: _ProfileFact(
                                      label: context.tr('Gender'),
                                      value: switch (themeController.gender) {
                                        AppGender.male => context.tr('Male'),
                                        AppGender.female => context.tr(
                                          'Female',
                                        ),
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _ProfileFact(
                                      label: context.tr('Age'),
                                      value:
                                          themeController.profileAge
                                              ?.toString() ??
                                          context.tr('Not set'),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    flex: 2,
                                    child: _ProfileFact(
                                      label: context.tr('Plan'),
                                      value: _profilePlanText(
                                        context,
                                        rewardsController,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    _AutoReveal(
                      enabled: scrollToStreak,
                      child: RewardsProfileSection(
                        controller: rewardsController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showEditProfileDialog(BuildContext context) async {
    var draftName = themeController.profileName;
    var selectedBirthDate = themeController.profileBirthDate;
    var selectedGender = themeController.gender;

    final result = await showDialog<_ProfileEditResult>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(context.tr('Edit profile')),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: draftName,
                  onChanged: (value) => draftName = value,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ).copyWith(labelText: context.tr('Name')),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final now = DateTime.now();
                      final picked = await showDatePicker(
                        context: context,
                        initialDate:
                            selectedBirthDate ?? DateTime(now.year - 18),
                        firstDate: DateTime(now.year - 120),
                        lastDate: now,
                      );
                      if (picked != null) {
                        setDialogState(() => selectedBirthDate = picked);
                      }
                    },
                    icon: const Icon(Icons.cake_outlined),
                    label: Text(
                      selectedBirthDate == null
                          ? context.tr('Date of birth')
                          : _numericDate(selectedBirthDate!),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<AppGender>(
                    showSelectedIcon: true,
                    segments: [
                      ButtonSegment(
                        value: AppGender.male,
                        icon: const Icon(Icons.male_rounded),
                        label: Text(context.tr('Male')),
                      ),
                      ButtonSegment(
                        value: AppGender.female,
                        icon: const Icon(Icons.female_rounded),
                        label: Text(context.tr('Female')),
                      ),
                    ],
                    selected: {selectedGender},
                    onSelectionChanged: (selection) {
                      setDialogState(() => selectedGender = selection.first);
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(context.tr('Cancel')),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(
                  _ProfileEditResult(
                    name: draftName,
                    birthDate: selectedBirthDate,
                    gender: selectedGender,
                  ),
                );
              },
              child: Text(context.tr('Save')),
            ),
          ],
        ),
      ),
    );

    if (result == null) return;
    themeController.updateProfile(
      name: result.name,
      birthDate: result.birthDate,
      gender: result.gender,
    );
  }
}

class _AutoReveal extends StatefulWidget {
  const _AutoReveal({required this.enabled, required this.child});
  final bool enabled;
  final Widget child;

  @override
  State<_AutoReveal> createState() => _AutoRevealState();
}

class _AutoRevealState extends State<_AutoReveal> {
  @override
  void initState() {
    super.initState();
    if (widget.enabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOutCubic,
          alignment: .05,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _ProfileEditResult {
  const _ProfileEditResult({
    required this.name,
    required this.birthDate,
    required this.gender,
  });

  final String name;
  final DateTime? birthDate;
  final AppGender gender;
}

String _numericDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day/$month/${date.year}';
}

String _profilePlanText(BuildContext context, RewardsController controller) {
  final snapshot = controller.snapshot;
  if (snapshot == null || !snapshot.isPlus) return context.tr('Free');
  final expiresAt = snapshot.planExpiresAt;
  if (expiresAt == null) return context.tr('Plus');
  final date = MaterialLocalizations.of(context).formatShortDate(expiresAt);
  return '${context.tr('Plus')}\n$date';
}

class _ProfileFact extends StatelessWidget {
  const _ProfileFact({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: colors.onSurfaceVariant),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({required this.themeController, super.key});

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _GradientPageTitle(context.tr('Settings'))),
      body: AnimatedBuilder(
        animation: themeController,
        builder: (context, _) => ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 36),
          children: [
            _SettingsSectionTitle(context.tr('App appearance')),
            const SizedBox(height: 8),
            _SettingsGroupCard(
              children: [
                _CompactSettingRow(
                  icon: Icons.brightness_6_rounded,
                  title: context.tr('Theme'),
                  description: context.tr('Choose how the app looks.'),
                  trailing: PopupMenuButton<ThemeMode>(
                    key: const Key('themeSelector'),
                    tooltip: context.tr('Theme'),
                    initialValue: themeController.mode,
                    onSelected: themeController.setMode,
                    itemBuilder: (context) => [
                      _themeMenuItem(
                        context,
                        ThemeMode.light,
                        Icons.light_mode_rounded,
                        'Light',
                      ),
                      _themeMenuItem(
                        context,
                        ThemeMode.system,
                        Icons.brightness_auto_rounded,
                        'System',
                      ),
                      _themeMenuItem(
                        context,
                        ThemeMode.dark,
                        Icons.dark_mode_rounded,
                        'Dark',
                      ),
                    ],
                    child: _CompactPickerButton(
                      icon: _themeIcon(themeController.mode),
                      label: context.tr(_themeLabel(themeController.mode)),
                    ),
                  ),
                ),
                const _SettingsDivider(),
                _CompactSettingRow(
                  icon: Icons.palette_outlined,
                  title: context.tr('Color theme'),
                  description: context.tr('Used throughout the app.'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _AccentTextButton(
                        key: const Key('accentBlueButton'),
                        label: context.tr('Blue'),
                        color: const Color(0xFF526DFF),
                        selected: themeController.accent == AppAccent.blue,
                        onTap: () => themeController.setAccent(AppAccent.blue),
                      ),
                      const SizedBox(width: 6),
                      _AccentTextButton(
                        key: const Key('accentPinkButton'),
                        label: context.tr('Pink'),
                        color: const Color(0xFFE5478D),
                        selected: themeController.accent == AppAccent.pink,
                        onTap: () => themeController.setAccent(AppAccent.pink),
                      ),
                    ],
                  ),
                ),
                const _SettingsDivider(),
                _CompactSettingRow(
                  icon: Icons.language_rounded,
                  title: context.tr('Language'),
                  description: context.tr('Language used throughout the app.'),
                  trailing: SizedBox(
                    width: 132,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<AppLanguage>(
                        key: ValueKey(themeController.language),
                        isExpanded: true,
                        value: themeController.language,
                        borderRadius: BorderRadius.circular(16),
                        items: [
                          for (final language in AppLanguage.values)
                            DropdownMenuItem(
                              value: language,
                              child: Text(
                                language.displayLabel(context),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                        ],
                        onChanged: (language) {
                          if (language != null) {
                            themeController.setLanguage(language);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _SettingsSectionTitle(context.tr('Rewards and access')),
            const SizedBox(height: 8),
            _SettingsGroupCard(
              children: [
                _SettingsNote(
                  icon: Icons.toll_rounded,
                  title: context.tr('Tokens'),
                  body: context.tr(
                    'Token markers show the cost of optional changes or extended features. Choose tokens or a rewarded ad when offered.',
                  ),
                ),
                const _SettingsDivider(),
                _SettingsNote(
                  icon: Icons.workspace_premium_rounded,
                  title: context.tr('Badges'),
                  body: context.tr(
                    'Badges grow with profile, body, and calendar progress. Completing milestones can award tokens.',
                  ),
                ),
                const _SettingsDivider(),
                _SettingsNote(
                  icon: Icons.ondemand_video_rounded,
                  title: context.tr('Ads'),
                  body: context.tr(
                    'Rewarded ads are an optional alternative to tokens. Plus includes fewer on-board ads.',
                  ),
                ),
                const _SettingsDivider(),
                _SettingsNote(
                  icon: Icons.diamond_outlined,
                  title: context.tr('Free and Plus access'),
                  body: context.tr(
                    'Free includes limited core features. Plus makes core features unlimited, while premium extensions can still require the displayed token amount or an ad.',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _SettingsSectionTitle(context.tr('Privacy and policies')),
            const SizedBox(height: 8),
            _SettingsGroupCard(
              children: [
                _SettingsNote(
                  icon: Icons.fact_check_outlined,
                  title: context.tr('Track honestly and consistently'),
                  body: context.tr('agreement_honesty_note'),
                ),
                const _SettingsDivider(),
                _SettingsNote(
                  icon: Icons.health_and_safety_outlined,
                  title: context.tr('Understand symbolic progress'),
                  body: context.tr('agreement_symbolic_note'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _SettingsActionCard(
              icon: Icons.logout_rounded,
              title: context.tr('Log out'),
              description: context.tr(
                'Sign out of the account on this device. Local habit data stays on the phone.',
              ),
              destructive: true,
              onTap: () => _logOut(context),
            ),
            const SizedBox(height: 12),
            _SettingsActionCard(
              key: const Key('previewWelcomePagesButton'),
              icon: Icons.slideshow_rounded,
              title: context.tr('Welcome page preview'),
              description: context.tr(
                'Open the welcome pages without resetting your onboarding progress.',
              ),
              onTap: () => _openWelcomePreview(context),
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<ThemeMode> _themeMenuItem(
    BuildContext context,
    ThemeMode mode,
    IconData icon,
    String label,
  ) {
    return PopupMenuItem(
      value: mode,
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 10),
          Text(context.tr(label)),
        ],
      ),
    );
  }

  Future<void> _logOut(BuildContext context) async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(context.tr('Log out')),
            content: Text(
              context.tr('Log out of this account on this device?'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text(context.tr('Cancel')),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: Text(context.tr('Log out')),
              ),
            ],
          ),
        ) ??
        false;
    if (!confirmed || !context.mounted) return;

    final api = EmailAuthApi();
    final hadSession = await api.logout();
    api.close();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            context.tr(hadSession ? 'Logged out' : 'No signed-in account'),
          ),
        ),
      );
  }

  void _openWelcomePreview(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (previewContext) => WelcomeFlow(
          themeController: themeController,
          previewMode: true,
          onFinished: () async {
            if (previewContext.mounted) {
              Navigator.of(previewContext).pop();
            }
          },
        ),
      ),
    );
  }
}

class _SettingsSectionTitle extends StatelessWidget {
  const _SettingsSectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _SettingsGroupCard extends StatelessWidget {
  const _SettingsGroupCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF282C33)
            : Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.shadow.withValues(alpha: .09),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      indent: 56,
      color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: .5),
    );
  }
}

class _CompactSettingRow extends StatelessWidget {
  const _CompactSettingRow({
    required this.icon,
    required this.title,
    required this.description,
    required this.trailing,
  });

  final IconData icon;
  final String title;
  final String description;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 11, 10, 11),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.primaryContainer.withValues(alpha: .72),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, size: 19, color: colors.primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          trailing,
        ],
      ),
    );
  }
}

class _CompactPickerButton extends StatelessWidget {
  const _CompactPickerButton({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      constraints: const BoxConstraints(minWidth: 76),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: colors.primary),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _AccentTextButton extends StatelessWidget {
  const _AccentTextButton({
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String label;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = Colors.white;
    return InkWell(
      borderRadius: BorderRadius.circular(13),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: selected ? 1 : .46),
          borderRadius: BorderRadius.circular(13),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: .28),
                    blurRadius: 9,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: foreground,
            fontSize: 12,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _SettingsNote extends StatelessWidget {
  const _SettingsNote({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 13, 14, 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 21, color: colors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsActionCard extends StatelessWidget {
  const _SettingsActionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    this.destructive = false,
    super.key,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final foreground = destructive ? colors.error : colors.primary;
    return Material(
      color: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF282C33)
          : colors.surfaceContainerLow,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 13, 10, 13),
          child: Row(
            children: [
              Icon(icon, color: foreground),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: destructive ? foreground : null,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

IconData _themeIcon(ThemeMode mode) => switch (mode) {
  ThemeMode.light => Icons.light_mode_rounded,
  ThemeMode.system => Icons.brightness_auto_rounded,
  ThemeMode.dark => Icons.dark_mode_rounded,
};

String _themeLabel(ThemeMode mode) => switch (mode) {
  ThemeMode.light => 'Light',
  ThemeMode.system => 'System',
  ThemeMode.dark => 'Dark',
};
