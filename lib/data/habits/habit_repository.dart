abstract final class BodyPartKey {
  static const brain = 'organ.brain';
  static const heart = 'organ.heart';
  static const gut = 'organ.gut';
  static const stomach = 'organ.stomach';
  static const liver = 'organ.liver';
  static const lungs = 'organ.lungs';
  static const kidneys = 'organ.kidneys';
  static const arms = 'muscle.arms';
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
  });

  final String id;
  final String nameKey;
  final String category;
  final bool isActive;
  final bool isFavorite;
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

  Future<String> createCustomHabit({
    required String name,
    required bool isUnwanted,
  });

  Stream<List<DailyProgressPoint>> watchGraphHistory({
    String metricKey = 'total_actions',
    String? habitId,
  });
}
