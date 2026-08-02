import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class HabitDefinitions extends Table {
  TextColumn get id => text()();
  TextColumn get nameKey => text()();
  TextColumn get category => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
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
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get remoteId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {slot};
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

@DriftDatabase(
  tables: [
    HabitDefinitions,
    HabitLogEntries,
    BodyPartStates,
    GraphHistoryEntries,
    CustomGraphRules,
    SpecialHabitGraphs,
    ReductionPlans,
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
  int get schemaVersion => 5;

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
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
