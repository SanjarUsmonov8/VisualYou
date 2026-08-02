import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/habits/habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/body/body.dart';
import 'package:visualyou/features/breathing/breathing_card.dart';
import 'package:visualyou/features/calendar/calendar_repository.dart';
import 'package:visualyou/features/calendar/habit_calendar.dart';
import 'package:visualyou/features/custom_graph/custom_graph.dart';
import 'package:visualyou/features/custom_graph/custom_graph_repository.dart';
import 'package:visualyou/features/female_body/female_body.dart';
import 'package:visualyou/features/habit_info/habit_info_cards.dart';
import 'package:visualyou/features/reduction_calendar/reduction_calendar.dart';
import 'package:visualyou/features/reduction_calendar/reduction_calendar_repository.dart';
import 'package:visualyou/l10n/app_strings.dart';

void main() => runApp(const VisualYouApp());

class VisualYouApp extends StatefulWidget {
  const VisualYouApp({
    this.habitRepository,
    this.customGraphRepository,
    this.calendarRepository,
    this.reductionCalendarRepository,
    super.key,
  });

  final HabitRepository? habitRepository;
  final CustomGraphRepository? customGraphRepository;
  final CalendarRepository? calendarRepository;
  final ReductionCalendarRepository? reductionCalendarRepository;

  @override
  State<VisualYouApp> createState() => _VisualYouAppState();
}

class _VisualYouAppState extends State<VisualYouApp> {
  final ThemeController _themeController = ThemeController();
  AppDatabase? _ownedDatabase;
  late final HabitRepository _habitRepository;
  late final CustomGraphRepository _customGraphRepository;
  late final CalendarRepository _calendarRepository;
  late final ReductionCalendarRepository _reductionCalendarRepository;
  bool _storageReady = false;
  Object? _storageError;

  @override
  void initState() {
    super.initState();
    final injectedRepository = widget.habitRepository;
    if (injectedRepository != null) {
      _habitRepository = injectedRepository;
      _customGraphRepository =
          widget.customGraphRepository ??
          DriftCustomGraphRepository(
            (injectedRepository as DriftHabitRepository).database,
          );
      _calendarRepository =
          widget.calendarRepository ??
          DriftCalendarRepository(
            (injectedRepository as DriftHabitRepository).database,
          );
      _reductionCalendarRepository =
          widget.reductionCalendarRepository ??
          DriftReductionCalendarRepository(
            (injectedRepository as DriftHabitRepository).database,
          );
    } else {
      final database = AppDatabase.defaults();
      _ownedDatabase = database;
      _habitRepository = DriftHabitRepository(database);
      _customGraphRepository =
          widget.customGraphRepository ?? DriftCustomGraphRepository(database);
      _calendarRepository =
          widget.calendarRepository ?? DriftCalendarRepository(database);
      _reductionCalendarRepository =
          widget.reductionCalendarRepository ??
          DriftReductionCalendarRepository(database);
    }
    unawaited(_initializeStorage());
  }

  Future<void> _initializeStorage() async {
    try {
      await _habitRepository.initialize();
      BodyVisualState.restore(await _habitRepository.loadBodyState());
      if (!mounted) return;
      setState(() {
        _storageReady = true;
        _storageError = null;
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
    final database = _ownedDatabase;
    if (database != null) unawaited(database.close());
    _themeController.dispose();
    super.dispose();
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
            : HomePage(
                themeController: _themeController,
                habitRepository: _habitRepository,
                customGraphRepository: _customGraphRepository,
                calendarRepository: _calendarRepository,
                reductionCalendarRepository: _reductionCalendarRepository,
              ),
      ),
    );
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
}

class ThemeController extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;
  AppAccent _accent = AppAccent.blue;
  AppGender _gender = AppGender.male;
  AppLanguage _language = AppLanguage.english;
  String _profileName = '';
  int? _profileAge;

  ThemeMode get mode => _mode;
  AppAccent get accent => _accent;
  AppGender get gender => _gender;
  AppLanguage get language => _language;
  String get profileName => _profileName;
  int? get profileAge => _profileAge;
  Color get seedColor => switch (_accent) {
    AppAccent.blue => const Color(0xFF526DFF),
    AppAccent.pink => const Color(0xFFE5478D),
  };

  void setMode(ThemeMode value) {
    if (_mode == value) return;
    _mode = value;
    notifyListeners();
  }

  void setAccent(AppAccent value) {
    if (_accent == value) return;
    _accent = value;
    notifyListeners();
  }

  void setGender(AppGender value) {
    if (_gender == value) return;
    _gender = value;
    notifyListeners();
  }

  void setLanguage(AppLanguage value) {
    if (_language == value) return;
    _language = value;
    notifyListeners();
  }

  void updateProfile({
    required String name,
    required int? age,
    AppGender? gender,
  }) {
    final trimmedName = name.trim();
    _profileName = trimmedName;
    _profileAge = age;
    if (gender != null) _gender = gender;
    notifyListeners();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    required this.themeController,
    required this.habitRepository,
    required this.customGraphRepository,
    required this.calendarRepository,
    required this.reductionCalendarRepository,
    super.key,
  });

  final ThemeController themeController;
  final HabitRepository habitRepository;
  final CustomGraphRepository customGraphRepository;
  final CalendarRepository calendarRepository;
  final ReductionCalendarRepository reductionCalendarRepository;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final GlobalKey _addButtonKey = GlobalKey();

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
                  themeController: widget.themeController,
                  habitRepository: widget.habitRepository,
                  customGraphRepository: widget.customGraphRepository,
                ),
                _NavigationPage(
                  title: context.tr('Body statistics'),
                  icon: const AnatomyIcon(size: 72),
                  themeController: widget.themeController,
                  content: _GenderBodyFrame(
                    themeController: widget.themeController,
                    customGraphRepository: widget.customGraphRepository,
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
                  content: Column(
                    children: [
                      HabitCalendar(repository: widget.calendarRepository),
                      const SizedBox(height: 14),
                      ReductionCalendar(
                        repository: widget.reductionCalendarRepository,
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
        page: AddHabitPage(habitRepository: widget.habitRepository),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.themeController,
    required this.habitRepository,
    required this.customGraphRepository,
  });

  final ThemeController themeController;
  final HabitRepository habitRepository;
  final CustomGraphRepository customGraphRepository;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Semantics(
                    button: true,
                    label: context.tr('Open profile'),
                    child: InkWell(
                      key: const Key('profileButton'),
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) =>
                              ProfilePage(themeController: themeController),
                        ),
                      ),
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [colors.primaryContainer, colors.primary],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(
                            color: colors.outlineVariant,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.person_rounded,
                          color: colors.onPrimary,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  IconButton.filledTonal(
                    key: const Key('settingsButton'),
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
              const SizedBox(height: 5),
              Text(
                context.tr('Hi!'),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colors.onSurfaceVariant,
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
              const BreathingCard(),
              const SizedBox(height: 12),
              Container(
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
                                        habit.isActive && habit.isFavorite,
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
                                  isUnwanted: habit.category == 'reduction',
                                  onThumbUp: () => unawaited(
                                    _showQuickAdded(
                                      context,
                                      _quickAddLabelKey(habit),
                                      didHabit: habit.category != 'reduction',
                                    ),
                                  ),
                                  onThumbDown: () => unawaited(
                                    _showQuickAdded(
                                      context,
                                      _quickAddLabelKey(habit),
                                      didHabit: habit.category == 'reduction',
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
  });

  final ThemeController themeController;
  final CustomGraphRepository customGraphRepository;
  final bool showSpecialHabitGraphs;

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
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 320),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: Tween<double>(begin: .98, end: 1).animate(animation),
                    child: child,
                  ),
                );
              },
              child: body,
            ),
            const SizedBox(height: 12),
            CustomGraphCard(repository: customGraphRepository),
            if (showSpecialHabitGraphs) ...[
              const SizedBox(height: 10),
              SpecialHabitGraphsSection(repository: customGraphRepository),
            ],
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
    this.content,
    this.showIcon = true,
    this.topAligned = false,
    this.gradientTitle = false,
  });

  final String title;
  final Widget icon;
  final ThemeController themeController;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Semantics(
                    button: true,
                    label: context.tr('Open profile'),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) =>
                              ProfilePage(themeController: themeController),
                        ),
                      ),
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [colors.primaryContainer, colors.primary],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(
                            color: colors.outlineVariant,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.person_rounded,
                          color: colors.onPrimary,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  IconButton.filledTonal(
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
                        shaderCallback: (bounds) => const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF67D8F7),
                            Color(0xFF8B6FE8),
                            Color(0xFFF06F9B),
                            Color(0xFFF2A65A),
                          ],
                          stops: [0, .34, .68, 1],
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
  const AddHabitPage({required this.habitRepository, super.key});

  final HabitRepository habitRepository;

  @override
  State<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  static const _goodHabits = [
    _HabitOption('water', 'Drinking water', Icons.water_drop_rounded),
    _HabitOption('healthy_eating', 'Eating healthy', Icons.eco_rounded),
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
        title: Text(context.tr('Add a habit')),
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
              ],
              _buildSection(
                context,
                title: 'Good habits',
                options: _goodHabits,
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
                options: _badHabits,
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
    final visibleOptions = _editing
        ? options
        : options
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
              if (_editing)
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
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final bool isFavorite;
  final ValueChanged<bool> onActiveChanged;
  final ValueChanged<bool> onFavoriteChanged;

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
          IconButton(
            visualDensity: VisualDensity.compact,
            constraints: const BoxConstraints.tightFor(width: 32, height: 32),
            padding: EdgeInsets.zero,
            tooltip: context.tr(isActive ? 'Remove habit' : 'Restore habit'),
            onPressed: () => onActiveChanged(!isActive),
            icon: Icon(
              isActive ? Icons.remove_circle_outline : Icons.add_circle_outline,
              size: 20,
              color: isActive ? colors.error : colors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

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
  const ProfilePage({required this.themeController, super.key});

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: AnimatedBuilder(
        animation: themeController,
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton.filledTonal(
                        tooltip: context.tr('Back'),
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back_rounded),
                      ),
                      TextButton.icon(
                        onPressed: () => _showEditProfileDialog(context),
                        icon: const Icon(Icons.edit_rounded, size: 19),
                        label: Text(context.tr('Edit profile')),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 104,
                        height: 104,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [colors.primaryContainer, colors.primary],
                          ),
                          boxShadow: isDark
                              ? null
                              : [
                                  BoxShadow(
                                    color: colors.primary.withValues(alpha: .2),
                                    blurRadius: 24,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors.surfaceContainer,
                          ),
                          child: Icon(
                            Icons.person_rounded,
                            size: 58,
                            color: colors.primary,
                          ),
                        ),
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
                            const SizedBox(height: 18),
                            Row(
                              children: [
                                Expanded(
                                  child: _ProfileFact(
                                    label: context.tr('Gender'),
                                    value: switch (themeController.gender) {
                                      AppGender.male => context.tr('Male'),
                                      AppGender.female => context.tr('Female'),
                                    },
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: _ProfileFact(
                                    label: context.tr('Age'),
                                    value:
                                        themeController.profileAge
                                            ?.toString() ??
                                        context.tr('Not set'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showEditProfileDialog(BuildContext context) async {
    var draftName = themeController.profileName;
    var draftAge = themeController.profileAge?.toString() ?? '';
    var selectedGender = themeController.gender;
    String? ageError;

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
                TextFormField(
                  initialValue: draftAge,
                  onChanged: (value) => draftAge = value,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: context.tr('Age'),
                    errorText: ageError,
                    prefixIcon: const Icon(Icons.cake_outlined),
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
                final rawAge = draftAge.trim();
                final parsedAge = rawAge.isEmpty ? null : int.tryParse(rawAge);
                if (rawAge.isNotEmpty &&
                    (parsedAge == null || parsedAge < 1 || parsedAge > 120)) {
                  setDialogState(() {
                    ageError = context.tr('Enter an age from 1 to 120');
                  });
                  return;
                }
                Navigator.of(dialogContext).pop(
                  _ProfileEditResult(
                    name: draftName,
                    age: parsedAge,
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
      age: result.age,
      gender: result.gender,
    );
  }
}

class _ProfileEditResult {
  const _ProfileEditResult({
    required this.name,
    required this.age,
    required this.gender,
  });

  final String name;
  final int? age;
  final AppGender gender;
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
          maxLines: 1,
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
      appBar: AppBar(title: Text(context.tr('Settings'))),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        children: [
          Text(
            context.tr('Language'),
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            context.tr('Choose the language used throughout VisualYou.'),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          AnimatedBuilder(
            animation: themeController,
            builder: (context, _) => DropdownButtonFormField<AppLanguage>(
              key: ValueKey(themeController.language),
              initialValue: themeController.language,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.language_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              items: [
                for (final language in AppLanguage.values)
                  DropdownMenuItem(
                    value: language,
                    child: Text(context.tr(language.labelKey)),
                  ),
              ],
              onChanged: (language) {
                if (language != null) themeController.setLanguage(language);
              },
            ),
          ),
          const SizedBox(height: 32),
          Text(
            context.tr('Appearance'),
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            context.tr(
              'Choose how VisualYou looks. Your choice applies throughout the app.',
            ),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          AnimatedBuilder(
            animation: themeController,
            builder: (context, _) => SizedBox(
              width: double.infinity,
              child: SegmentedButton<ThemeMode>(
                key: const Key('themeSelector'),
                showSelectedIcon: true,
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
                selected: {themeController.mode},
                onSelectionChanged: (selection) {
                  themeController.setMode(selection.first);
                },
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            context.tr('Color theme'),
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            context.tr('This accent color is used across VisualYou.'),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          AnimatedBuilder(
            animation: themeController,
            builder: (context, _) => SegmentedButton<AppAccent>(
              key: const Key('accentSelector'),
              showSelectedIcon: true,
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
              selected: {themeController.accent},
              onSelectionChanged: (selection) {
                themeController.setAccent(selection.first);
              },
            ),
          ),
          const SizedBox(height: 32),
          Text(
            context.tr('Gender'),
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            context.tr(
              'Choose the body displayed on Home and Body Statistics.',
            ),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          AnimatedBuilder(
            animation: themeController,
            builder: (context, _) => SegmentedButton<AppGender>(
              key: const Key('genderSelector'),
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
              selected: {themeController.gender},
              onSelectionChanged: (selection) {
                themeController.setGender(selection.first);
              },
            ),
          ),
        ],
      ),
    );
  }
}
