import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:visualyou/features/body/body.dart';

void main() => runApp(const VisualYouApp());

class VisualYouApp extends StatefulWidget {
  const VisualYouApp({super.key});

  @override
  State<VisualYouApp> createState() => _VisualYouAppState();
}

class _VisualYouAppState extends State<VisualYouApp> {
  final ThemeController _themeController = ThemeController();

  @override
  void dispose() {
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
        themeMode: _themeController.mode,
        theme: _buildTheme(_themeController.seedColor, Brightness.light),
        darkTheme: _buildTheme(_themeController.seedColor, Brightness.dark),
        home: HomePage(themeController: _themeController),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}

enum AppAccent { blue, pink }

class ThemeController extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;
  AppAccent _accent = AppAccent.blue;

  ThemeMode get mode => _mode;
  AppAccent get accent => _accent;
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
}

class HomePage extends StatefulWidget {
  const HomePage({required this.themeController, super.key});

  final ThemeController themeController;

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
                _HomeContent(themeController: widget.themeController),
                _NavigationPage(
                  title: 'Body statistics',
                  icon: const AnatomyIcon(size: 72),
                  themeController: widget.themeController,
                  content: const BodyFrame(),
                  showIcon: false,
                  topAligned: true,
                ),
                _NavigationPage(
                  title: 'Calendar',
                  icon: const Icon(Icons.calendar_month_rounded, size: 68),
                  themeController: widget.themeController,
                ),
                _NavigationPage(
                  title: 'AI coach',
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
        page: const AddHabitPage(),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.themeController});

  final ThemeController themeController;

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
                    label: 'Open profile',
                    child: InkWell(
                      key: const Key('profileButton'),
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const ProfilePage(),
                        ),
                      ),
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              colors.primaryContainer,
                              colors.primary,
                            ],
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
                    tooltip: 'Settings',
                    icon: const Icon(Icons.settings_rounded),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => SettingsPage(
                          themeController: themeController,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                'Hi!',
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
                  'Let\'s build a better you',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -.7,
                  ),
                ),
              ),
              const SizedBox(height: 18),
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
                      const Text(
                        'Quick add',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8), //
                      Wrap(
                        spacing: 7,
                        runSpacing: 7,
                        children: [
                          _QuickAddPill(
                            label: 'Water',
                            onTap: () => _showQuickAdded(context, 'Water'),
                          ),
                          _QuickAddPill(
                            label: 'Healthy meal',
                            onTap: () =>
                                _showQuickAdded(context, 'Healthy meal'),
                          ),
                          _QuickAddPill(
                            label: 'Arm workout',
                            onTap: () =>
                                _showQuickAdded(context, 'Arm workout'),
                          ),
                          _QuickAddPill(
                            label: 'Abs workout',
                            onTap: () =>
                                _showQuickAdded(context, 'Abs workout'),
                          ),
                          _QuickAddPill(
                            label: 'Smoke-free',
                            onTap: () =>
                                _showQuickAdded(context, 'Smoke-free'),
                          ),
                          _QuickAddPill(
                            label: 'Alcohol',
                            onTap: () =>
                                _showQuickAdded(context, 'Alcohol'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const BodyFrame(),
            ],
          ),
        ),
      ),
    );
  }

  void _showQuickAdded(BuildContext context, String habit) {
    if (habit == 'Alcohol') {
      BodyVisualState.addAlcoholHabit();
    }
    if (habit == 'Healthy meal') {
      BodyVisualState.addHealthyEatingHabit();
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$habit added'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

class _QuickAddPill extends StatelessWidget {
  const _QuickAddPill({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final pillColor = isDark ? colors.surfaceContainerHighest : Colors.white;
    final contentColor = isDark
    ? const Color.fromARGB(255, 85, 85, 85) // Dark-mode text and Plus color
    : colors.primary;         // Keep Light mode unchanged
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
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
              const SizedBox(width: 4),
              Icon(Icons.add_rounded, size: 16, color: contentColor),
            ],
          ),
        ),
      ),
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
  });

  final String title;
  final Widget icon;
  final ThemeController themeController;
  final Widget? content;
  final bool showIcon;
  final bool topAligned;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final pageContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: topAligned
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        if (showIcon) ...[
          IconTheme(
            data: IconThemeData(color: colors.primary),
            child: icon,
          ),
          const SizedBox(height: 16),
        ],
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        if (content != null) ...[
          SizedBox(height: topAligned ? 10 : 20),
          content!,
        ],
      ],
    );
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 85),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Semantics(
                  button: true,
                  label: 'Open profile',
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const ProfilePage(),
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
                  tooltip: 'Settings',
                  icon: const Icon(Icons.settings_rounded),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => SettingsPage(
                        themeController: themeController,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: topAligned
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 4),
                      child: pageContent,
                    )
                  : Center(child: pageContent),
            ),
          ],
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
                      tooltip: 'Home',
                      icon: const Icon(Icons.home_rounded),
                      selected: selectedIndex == 0,
                      onTap: () => onDestinationSelected(0),
                    ),
                    _NavButton(
                      tooltip: 'Body statistics',
                      icon: const AnatomyIcon(),
                      selected: selectedIndex == 1,
                      onTap: () => onDestinationSelected(1),
                    ),
                    _NavButton(
                      tooltip: 'Calendar',
                      icon: const Icon(Icons.calendar_month_rounded),
                      selected: selectedIndex == 2,
                      onTap: () => onDestinationSelected(2),
                    ),
                    _NavButton(
                      tooltip: 'AI coach',
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
              tooltip: 'Add habit',
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

class AddHabitPage extends StatelessWidget {
  const AddHabitPage({super.key});

  static const _badHabits = [
    ('Smoking', Icons.smoke_free_rounded),
    ('Vaping', Icons.air_rounded),
    ('Alcohol', Icons.local_bar_rounded),
    ('Unhealthy eating', Icons.fastfood_rounded),
    ('Adult videos', Icons.visibility_off_rounded),
    ('Masturbation', Icons.self_improvement_rounded),
  ];

  static const _exercises = [
    ('Arm', Icons.fitness_center_rounded),
    ('Shoulder / Back', Icons.accessibility_new_rounded),
    ('Chest', Icons.monitor_heart_outlined),
    ('Abs', Icons.grid_view_rounded),
    ('Legs', Icons.directions_run_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Close',
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded),
        ),
        title: const Text('Add a habit'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
        children: [
          Text(
            'Good habits ✨',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 3.2,
            children: [
              _HabitTile(
                label: 'Drinking water',
                icon: Icons.water_drop_rounded,
                onAdd: () => _showAdded(context, 'Drinking water'),
              ),
              _HabitTile(
                label: 'Eating healthy',
                icon: Icons.eco_rounded,
                onAdd: () => _showAdded(context, 'Eating healthy'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Exercises',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    childAspectRatio: 3.5,
                    children: [
                      for (final exercise in _exercises)
                        _ExerciseRow(
                          label: exercise.$1,
                          icon: exercise.$2,
                          onAdd: () => _showAdded(context, exercise.$1),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Bad habits ❌',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 3.2,
            children: [
              for (final habit in _badHabits)
                _HabitTile(
                  label: habit.$1,
                  icon: habit.$2,
                  onAdd: () => _showAdded(context, habit.$1),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAdded(BuildContext context, String habit) {
    if (habit == 'Alcohol') {
      BodyVisualState.addAlcoholHabit();
    }
    if (habit == 'Eating healthy') {
      BodyVisualState.addHealthyEatingHabit();
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$habit added'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

class _HabitTile extends StatelessWidget {
  const _HabitTile({
    required this.label,
    required this.icon,
    required this.onAdd,
  });

  final String label;
  final IconData icon;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 75,
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
            flex: 25,
            child: Tooltip(
              message: 'I did $label',
              child: InkWell(
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(24),
                ),
                onTap: onAdd,
                child: Center(
                  child: Icon(
                    Icons.add_rounded,
                    size: 19,
                    color: colors.primary,
                  ),
                ),
              ),
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
    required this.onAdd,
  });

  final String label;
  final IconData icon;
  final VoidCallback onAdd;

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
            flex: 75,
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
            flex: 25,
            child: Tooltip(
              message: 'I did $label exercise',
              child: InkWell(
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(18),
                ),
                onTap: onAdd,
                child: Center(
                  child: Icon(
                    Icons.add_rounded,
                    size: 18,
                    color: colors.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
  const _CircularRevealClipper({
    required this.origin,
    required this.progress,
  });

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
      ..cubicTo(12 * scale, 3 * scale, 9 * scale, 6 * scale, 9 * scale, 10 * scale)
      ..lineTo(6 * scale, 13 * scale)
      ..lineTo(9 * scale, 14 * scale)
      ..cubicTo(9 * scale, 18 * scale, 11 * scale, 19 * scale, 12 * scale, 19 * scale)
      ..lineTo(12 * scale, 22 * scale)
      ..cubicTo(9 * scale, 22.5 * scale, 5 * scale, 24 * scale, 3 * scale, 27 * scale)
      ..moveTo(17 * scale, 4 * scale)
      ..cubicTo(21 * scale, 6 * scale, 22 * scale, 11 * scale, 20 * scale, 15 * scale)
      ..cubicTo(19 * scale, 17 * scale, 17 * scale, 18.5 * scale, 16 * scale, 19 * scale)
      ..lineTo(16 * scale, 22 * scale)
      ..cubicTo(19 * scale, 22.5 * scale, 23 * scale, 24 * scale, 25 * scale, 27 * scale);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _AnatomyIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => const _DestinationPage(
    title: 'Profile',
    icon: Icons.person_rounded,
    description: 'Your identity, goals, and progress will live here.',
  );
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({required this.themeController, super.key});

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        children: [
          Text(
            'Appearance',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose how VisualYou looks. Your choice applies throughout the app.',
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
                segments: const [
                  ButtonSegment(
                    value: ThemeMode.light,
                    icon: Icon(Icons.light_mode_rounded),
                    label: Text('Light'),
                  ),
                  ButtonSegment(
                    value: ThemeMode.system,
                    icon: Icon(Icons.brightness_auto_rounded),
                    label: Text('System'),
                  ),
                  ButtonSegment(
                    value: ThemeMode.dark,
                    icon: Icon(Icons.dark_mode_rounded),
                    label: Text('Dark'),
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
            'Color theme',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This accent color is used across VisualYou.',
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
              segments: const [
                ButtonSegment(
                  value: AppAccent.blue,
                  icon: Icon(
                    Icons.water_drop_rounded,
                    color: Color(0xFF526DFF),
                  ),
                  label: Text('Blue'),
                ),
                ButtonSegment(
                  value: AppAccent.pink,
                  icon: Icon(Icons.favorite_rounded, color: Color(0xFFE5478D)),
                  label: Text('Pink'),
                ),
              ],
              selected: {themeController.accent},
              onSelectionChanged: (selection) {
                themeController.setAccent(selection.first);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DestinationPage extends StatelessWidget {
  const _DestinationPage({
    required this.title,
    required this.icon,
    required this.description,
  });

  final String title;
  final IconData icon;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 64, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 20),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
