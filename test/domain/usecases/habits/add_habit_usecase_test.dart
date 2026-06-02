import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:dayflow/core/errors/failures.dart';
import 'package:dayflow/domain/entities/habit.dart';
import 'package:dayflow/domain/repositories/habit_repository.dart';
import 'package:dayflow/domain/usecases/habits/add_habit.dart';

import '../../../helpers/mocks.dart';

class MockHabitRepository extends Mock implements HabitRepository {}

void main() {
  late MockHabitRepository mockRepo;
  late AddHabitUseCase useCase;

  setUp(() {
    mockRepo = MockHabitRepository();
    useCase = AddHabitUseCase(mockRepo);
  });

  group('AddHabitUseCase', () {
    test('should return ValidationFailure when title is empty', () async {
      final habit = HabitEntity(title: '   ');

      final result = await useCase(habit);

      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, contains('hábito'));
        },
        (_) => fail('Should return failure'),
      );
    });

    test('should return ValidationFailure when goal is zero', () async {
      final habit = HabitEntity(title: 'Beber agua', goal: 0);

      final result = await useCase(habit);

      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, contains('meta'));
        },
        (_) => fail('Should return failure'),
      );
    });

    test('should return ValidationFailure when goal is negative', () async {
      final habit = HabitEntity(title: 'Ejercicio', goal: -5);

      final result = await useCase(habit);

      expect(result.isLeft(), true);
    });

    test('should call repository on valid habit', () async {
      final habit = HabitEntity(title: 'Beber agua', goal: 8);
      when(() => mockRepo.createHabit(habit))
          .thenAnswer((_) async => Right(habit));

      final result = await useCase(habit);

      expect(result.isRight(), true);
      verify(() => mockRepo.createHabit(habit)).called(1);
    });
  });
}