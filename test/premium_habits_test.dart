import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/habits/habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';

void main() {
  late AppDatabase database;
  late DriftHabitRepository repository;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    repository = DriftHabitRepository(database);
    await repository.initialize();
  });

  tearDown(() => database.close());

  test(
    'studying and breathing apply only their requested organ points',
    () async {
      var body = await repository.recordHabit('Studying');
      expect(body.parts[BodyPartKey.brain]?.score, 4);
      expect(body.parts[BodyPartKey.lungs]?.score, 3);

      body = await repository.recordHabit('Studying', didHabit: false);
      expect(body.parts[BodyPartKey.brain]?.score, 3.5);

      body = await repository.applyBreathingReward();
      expect(body.parts[BodyPartKey.brain]?.score, 5);
      expect(body.parts[BodyPartKey.lungs]?.score, 4.5);
    },
  );

  test('two custom habits persist without changing body progress', () async {
    final before = await repository.loadBodyState();
    final goodId = await repository.createCustomHabit(
      name: 'Read a chapter',
      isUnwanted: false,
    );
    final badId = await repository.createCustomHabit(
      name: 'Late scrolling',
      isUnwanted: true,
    );
    await repository.recordHabit(goodId);
    await repository.recordHabit(badId);
    final after = await repository.loadBodyState();
    expect(
      after.parts[BodyPartKey.brain]?.score,
      before.parts[BodyPartKey.brain]?.score,
    );

    final preferences = await repository.watchHabitPreferences().first;
    expect(
      preferences.singleWhere((habit) => habit.id == goodId).category,
      'custom_good',
    );
    expect(
      preferences.singleWhere((habit) => habit.id == badId).category,
      'custom_bad',
    );
    await expectLater(
      repository.createCustomHabit(name: 'Third habit', isUnwanted: false),
      throwsA(isA<StateError>()),
    );
  });
}
