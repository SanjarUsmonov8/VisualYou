abstract final class BodyPartKey {
  static const brain = 'organ.brain';
  static const heart = 'organ.heart';
  static const gut = 'organ.gut';
  static const stomach = 'organ.stomach';
  static const liver = 'organ.liver';
  static const lungs = 'organ.lungs';
  static const kidneys = 'organ.kidneys';
  static const arms = 'muscle.arms';
  static const shoulders = 'muscle.shoulders';
  static const back = 'muscle.back';
  // Kept so progress from versions with one combined workout can be migrated.
  static const shouldersBack = 'muscle.shouldersBack';
  static const chest = 'muscle.chest';
  static const abs = 'muscle.abs';
  static const legs = 'muscle.legs';
}

class PersistedBodyPart {
  const PersistedBodyPart({
    required this.level,
    required this.colorValue,
    required this.score,
  });

  final int level;
  final int? colorValue;
  final double score;
}

class PersistedBodyState {
  const PersistedBodyState(this.parts);

  final Map<String, PersistedBodyPart> parts;
}

class DailyProgressPoint {
  const DailyProgressPoint({
    required this.day,
    required this.value,
    required this.metricKey,
    this.habitId,
  });

  final DateTime day;
  final double value;
  final String metricKey;
  final String? habitId;
}

class HabitPreference {
  const HabitPreference({
    required this.id,
    required this.nameKey,
    required this.category,
    required this.isActive,
    required this.isFavorite,
    required this.numericalTrackingEnabled,
    required this.numericalTarget,
    required this.updatedAt,
    this.numericalUnit,
  });

  final String id;
  final String nameKey;
  final String category;
  final bool isActive;
  final bool isFavorite;
  final bool numericalTrackingEnabled;
  final int? numericalTarget;
  final String? numericalUnit;
  final DateTime updatedAt;
}

class DailyNumericalHabitValue {
  const DailyNumericalHabitValue({
    required this.habitId,
    required this.value,
    required this.outcomeFactor,
  });

  final String habitId;
  final int? value;
  final double outcomeFactor;
}

class CustomHabitOrganEffect {
  const CustomHabitOrganEffect({
    required this.partKey,
    required this.thumbUpPoints,
    required this.thumbDownPoints,
  });

  final String partKey;
  final double thumbUpPoints;
  final double thumbDownPoints;

  bool get hasEffect => thumbUpPoints != 0 || thumbDownPoints != 0;
}

class StandardHabitOrganEffectSettings {
  const StandardHabitOrganEffectSettings({
    required this.effects,
    required this.isCustomized,
  });

  final List<CustomHabitOrganEffect> effects;
  final bool isCustomized;
}

class PersistedAppPreferences {
  const PersistedAppPreferences({
    this.themeMode = 'system',
    this.accent = 'blue',
    this.gender = 'male',
    this.language = 'english',
    this.profileName = '',
    this.birthDate,
    this.profileImageBase64 = '',
    this.profileImageAlignmentX = 0,
    this.profileImageAlignmentY = 0,
    this.profileImageScale = 1,
    this.termsAccepted = false,
  });

  final String themeMode;
  final String accent;
  final String gender;
  final String language;
  final String profileName;
  final DateTime? birthDate;
  final String profileImageBase64;
  final double profileImageAlignmentX;
  final double profileImageAlignmentY;
  final double profileImageScale;
  final bool termsAccepted;
}

abstract interface class HabitRepository {
  Future<void> initialize();

  Future<bool> isOnboardingComplete();

  Future<void> completeOnboarding();

  Future<PersistedAppPreferences> loadAppPreferences();

  Future<void> saveAppPreferences(PersistedAppPreferences preferences);

  Future<PersistedBodyState> applyDailyRecovery({DateTime? now});

  Future<PersistedBodyState> applyBreathingReward({DateTime? occurredAt});

  Future<PersistedBodyState> loadBodyState();

  Future<PersistedBodyState> recordHabit(
    String actionKey, {
    DateTime? occurredAt,
    bool didHabit = true,
  });

  Stream<List<HabitPreference>> watchHabitPreferences();

  Future<void> setHabitActive(String habitId, bool isActive);

  Future<void> setHabitFavorite(String habitId, bool isFavorite);

  Future<void> setHabitNumericalTracking(
    String habitId, {
    required bool enabled,
    required int target,
    String? unitKey,
  });

  Stream<List<DailyNumericalHabitValue>> watchNumericalHabitValues(
    DateTime day,
  );

  Future<PersistedBodyState> recordNumericalHabit(
    String habitId,
    int value, {
    DateTime? occurredAt,
  });

  Future<String> createCustomHabit({
    required String name,
    required bool isUnwanted,
    List<CustomHabitOrganEffect> organEffects = const [],
  });

  Future<void> updateCustomHabit({
    required String habitId,
    required String name,
    required bool isUnwanted,
    List<CustomHabitOrganEffect> organEffects = const [],
  });

  Future<List<CustomHabitOrganEffect>> loadCustomHabitOrganEffects(
    String habitId,
  );

  Future<int> countCustomHabitsWithOrganEffects();

  Future<StandardHabitOrganEffectSettings> loadStandardHabitOrganEffects(
    String habitId,
  );

  Future<void> saveStandardHabitOrganEffects(
    String habitId,
    List<CustomHabitOrganEffect> organEffects,
  );

  Future<int> countStandardHabitsWithOrganEffects();

  Future<void> deleteCustomHabit(String habitId);

  Stream<List<DailyProgressPoint>> watchGraphHistory({
    String metricKey = 'total_actions',
    String? habitId,
  });
}
