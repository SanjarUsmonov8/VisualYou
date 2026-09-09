import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class HabitDefinitions extends Table {
  TextColumn get id => text()();
  TextColumn get nameKey => text()();
  TextColumn get category => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get numericalTrackingEnabled =>
      boolean().withDefault(const Constant(false))();
  IntColumn get numericalTarget => integer().nullable()();
  TextColumn get numericalUnit => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('NumericalHabitEntryRow')
class NumericalHabitEntries extends Table {
  TextColumn get id => text()();
  TextColumn get habitId => text().references(HabitDefinitions, #id)();
  DateTimeColumn get localDay => dateTime()();
  IntColumn get value => integer().nullable()();
  RealColumn get outcomeFactor => real()();
  BoolColumn get actualDidHabit => boolean()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('NumericalBodyContributionRow')
class NumericalBodyContributions extends Table {
  TextColumn get entryId => text().references(NumericalHabitEntries, #id)();
  TextColumn get partKey => text()();
  RealColumn get points => real()();

  @override
  Set<Column<Object>> get primaryKey => {entryId, partKey};
}

class HabitLogEntries extends Table {
  TextColumn get id => text()();
  TextColumn get habitId => text().references(HabitDefinitions, #id)();
  DateTimeColumn get loggedAt => dateTime()();
  DateTimeColumn get localDay => dateTime()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class BodyPartStates extends Table {
  TextColumn get partKey => text()();
  IntColumn get level => integer().withDefault(const Constant(0))();
  RealColumn get score => real().nullable()();
  IntColumn get colorValue => integer().nullable()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {partKey};
}

class GraphHistoryEntries extends Table {
  TextColumn get id => text()();
  TextColumn get metricKey => text()();
  TextColumn get habitId =>
      text().nullable().references(HabitDefinitions, #id)();
  DateTimeColumn get localDay => dateTime()();
  RealColumn get value => real()();
  DateTimeColumn get recordedAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('CustomGraphRuleRow')
class CustomGraphRules extends Table {
  IntColumn get slot => integer()();
  TextColumn get habitId => text().references(HabitDefinitions, #id)();
  IntColumn get completedPoints => integer()();
  IntColumn get missedPoints => integer()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {slot};
}

@DataClassName('SpecialHabitGraphRow')
class SpecialHabitGraphs extends Table {
  IntColumn get slot => integer()();
  TextColumn get habitId => text().references(HabitDefinitions, #id)();
  IntColumn get completedValue => integer().withDefault(const Constant(1))();
  IntColumn get missedValue => integer().withDefault(const Constant(-1))();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {slot};
}

@DataClassName('NamedCustomGraphRow')
class NamedCustomGraphs extends Table {
  IntColumn get slot => integer()();
  TextColumn get name => text()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {slot};
}

@DataClassName('NamedCustomGraphRuleRow')
class NamedCustomGraphRules extends Table {
  IntColumn get graphSlot => integer().references(NamedCustomGraphs, #slot)();
  IntColumn get ruleSlot => integer()();
  TextColumn get habitId => text().references(HabitDefinitions, #id)();
  IntColumn get completedPoints => integer()();
  IntColumn get missedPoints => integer()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {graphSlot, ruleSlot};
}

@DataClassName('ReductionPlanRow')
class ReductionPlans extends Table {
  TextColumn get id => text()();
  TextColumn get habitId => text().references(HabitDefinitions, #id)();
  TextColumn get mode => text()();
  DateTimeColumn get startedOn => dateTime()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('GrowthPlanRow')
class GrowthPlans extends Table {
  TextColumn get id => text()();
  TextColumn get habitId => text().references(HabitDefinitions, #id)();
  TextColumn get mode => text()();
  DateTimeColumn get startedOn => dateTime()();
  IntColumn get targetDaysPerWeek => integer()();
  IntColumn get targetRepetitionsPerDay => integer()();
  TextColumn get offWeekdays => text().withDefault(const Constant(''))();
  TextColumn get weekdayRepetitions => text().withDefault(const Constant(''))();
  TextColumn get measurementUnit =>
      text().withDefault(const Constant('times'))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('GrowthPlanEntryRow')
class GrowthPlanEntries extends Table {
  TextColumn get planId => text().references(GrowthPlans, #id)();
  DateTimeColumn get localDay => dateTime()();
  IntColumn get completedCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {planId, localDay};
}

@DataClassName('HabitStreakRow')
class HabitStreaks extends Table {
  TextColumn get habitId => text().references(HabitDefinitions, #id)();
  IntColumn get colorValue => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {habitId};
}

class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

@DataClassName('RewardStateRow')
class RewardStates extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get plan => text().withDefault(const Constant('free'))();
  DateTimeColumn get planExpiresAt => dateTime().nullable()();
  IntColumn get tokenBalance => integer().withDefault(const Constant(140))();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get profileProgress => integer().withDefault(const Constant(140))();
  IntColumn get bodyProgress => integer().withDefault(const Constant(0))();
  IntColumn get calendarProgress => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastEvaluatedWeek => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('RewardEventRow')
class RewardEvents extends Table {
  TextColumn get id => text()();
  TextColumn get badgeKey => text().nullable()();
  IntColumn get amount => integer()();
  DateTimeColumn get occurredOn => dateTime()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('FeatureUnlockRow')
class FeatureUnlocks extends Table {
  TextColumn get featureKey => text()();
  DateTimeColumn get unlockedUntil => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {featureKey};
}

@DataClassName('CustomHabitOrganEffectRow')
class CustomHabitOrganEffects extends Table {
  TextColumn get habitId => text().references(HabitDefinitions, #id)();
  TextColumn get partKey => text()();
  RealColumn get thumbUpPoints => real().withDefault(const Constant(0))();
  RealColumn get thumbDownPoints => real().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {habitId, partKey};
}

@DataClassName('StandardHabitOrganEffectRow')
class StandardHabitOrganEffects extends Table {
  TextColumn get habitId => text().references(HabitDefinitions, #id)();
  TextColumn get partKey => text()();
  RealColumn get thumbUpPoints => real().withDefault(const Constant(0))();
  RealColumn get thumbDownPoints => real().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {habitId, partKey};
}

@DriftDatabase(
  tables: [
    HabitDefinitions,
    HabitLogEntries,
    BodyPartStates,
    GraphHistoryEntries,
    CustomGraphRules,
    SpecialHabitGraphs,
    NamedCustomGraphs,
    NamedCustomGraphRules,
    ReductionPlans,
    GrowthPlans,
    GrowthPlanEntries,
    HabitStreaks,
    AppSettings,
    RewardStates,
    RewardEvents,
    FeatureUnlocks,
    CustomHabitOrganEffects,
    StandardHabitOrganEffects,
    NumericalHabitEntries,
    NumericalBodyContributions,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  AppDatabase.defaults()
    : super(
        driftDatabase(
          name: 'visualyou',
          web: DriftWebOptions(
            sqlite3Wasm: Uri.parse('sqlite3.wasm'),
            driftWorker: Uri.parse('drift_worker.js'),
          ),
        ),
      );

  @override
  int get schemaVersion => 20;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(customGraphRules);
      }
      if (from < 3) {
        await migrator.createTable(specialHabitGraphs);
      }
      if (from < 4) {
        await migrator.createTable(reductionPlans);
      }
      if (from < 5) {
        await migrator.addColumn(habitDefinitions, habitDefinitions.isFavorite);
        await customStatement(
          "UPDATE habit_definitions SET is_favorite = 1 "
          "WHERE id IN ('water', 'healthy_eating', 'workout_arms', "
          "'workout_abs', 'alcohol')",
        );
      }
      if (from < 6) {
        await migrator.createTable(appSettings);
      }
      if (from < 7) {
        await migrator.addColumn(bodyPartStates, bodyPartStates.score);
        await customStatement(
          'UPDATE body_part_states SET score = CAST(level AS REAL) '
          'WHERE score IS NULL',
        );
      }
      if (from < 8) {
        await migrator.createTable(rewardStates);
        await migrator.createTable(rewardEvents);
        await migrator.createTable(featureUnlocks);
      }
      if (from < 9) {
        await migrator.addColumn(rewardStates, rewardStates.planExpiresAt);
      }
      if (from < 10) {
        await migrator.createTable(customHabitOrganEffects);
      }
      if (from < 11) {
        await migrator.createTable(standardHabitOrganEffects);
      }
      if (from < 12) {
        await migrator.addColumn(
          habitDefinitions,
          habitDefinitions.numericalTrackingEnabled,
        );
        await migrator.addColumn(
          habitDefinitions,
          habitDefinitions.numericalTarget,
        );
        await migrator.createTable(numericalHabitEntries);
        await migrator.createTable(numericalBodyContributions);
      }
      if (from < 13) {
        await migrator.createTable(namedCustomGraphs);
        await migrator.createTable(namedCustomGraphRules);
      }
      if (from >= 3 && from < 14) {
        await migrator.addColumn(
          specialHabitGraphs,
          specialHabitGraphs.completedValue,
        );
        await migrator.addColumn(
          specialHabitGraphs,
          specialHabitGraphs.missedValue,
        );
      }
      if (from < 15) {
        await migrator.createTable(growthPlans);
        await migrator.createTable(growthPlanEntries);
      }
      if (from >= 15 && from < 16) {
        await migrator.addColumn(growthPlans, growthPlans.weekdayRepetitions);
      }
      if (from < 17) {
        await migrator.addColumn(
          habitDefinitions,
          habitDefinitions.numericalUnit,
        );
        await migrator.addColumn(growthPlans, growthPlans.measurementUnit);
      }
      if (from < 18) {
        await migrator.createTable(habitStreaks);
      }
      if (from < 19) {
        await customStatement(_createNumericalHeatmapsSql);
      }
      if (from >= 19 && from < 20) {
        await customStatement(
          'ALTER TABLE numerical_habit_heatmaps '
          'ADD COLUMN higher_is_better INTEGER NOT NULL DEFAULT 1',
        );
        await customStatement(
          'ALTER TABLE numerical_habit_heatmaps '
          'ADD COLUMN orange_threshold INTEGER NOT NULL DEFAULT 1',
        );
        await customStatement(
          'ALTER TABLE numerical_habit_heatmaps '
          'ADD COLUMN yellow_threshold INTEGER NOT NULL DEFAULT 2',
        );
        await customStatement(
          'ALTER TABLE numerical_habit_heatmaps '
          'ADD COLUMN green_threshold INTEGER NOT NULL DEFAULT 3',
        );
        await customStatement(
          'ALTER TABLE numerical_habit_heatmaps '
          'ADD COLUMN blue_threshold INTEGER NOT NULL DEFAULT 4',
        );
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await customStatement(_createNumericalHeatmapsSql);
    },
  );

  static const _createNumericalHeatmapsSql = '''
    CREATE TABLE IF NOT EXISTS numerical_habit_heatmaps (
      slot INTEGER NOT NULL PRIMARY KEY,
      habit_id TEXT NOT NULL REFERENCES habit_definitions(id),
      higher_is_better INTEGER NOT NULL DEFAULT 1,
      orange_threshold INTEGER NOT NULL DEFAULT 1,
      yellow_threshold INTEGER NOT NULL DEFAULT 2,
      green_threshold INTEGER NOT NULL DEFAULT 3,
      blue_threshold INTEGER NOT NULL DEFAULT 4,
      created_at INTEGER NOT NULL,
      updated_at INTEGER NOT NULL
    )
  ''';
}
