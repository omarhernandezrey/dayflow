import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:dayflow/core/errors/failures.dart';
import 'package:dayflow/domain/entities/task.dart';
import 'package:dayflow/domain/repositories/task_repository.dart';
import 'package:dayflow/domain/usecases/tasks/add_task.dart';

import '../../../helpers/mocks.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockRepo;
  late AddTaskUseCase useCase;

  setUp(() {
    mockRepo = MockTaskRepository();
    useCase = AddTaskUseCase(mockRepo);
  });

  group('AddTaskUseCase', () {
    test('should return ValidationFailure when title is empty', () async {
      final task = TaskEntity(
        title: '   ',
        category: TaskCategory.personal,
        date: '2024-01-01',
        time: '10:00',
      );

      final result = await useCase(task);

      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, contains('título'));
        },
        (_) => fail('Should return failure'),
      );
    });

    test('should return ValidationFailure when date is empty', () async {
      final task = TaskEntity(
        title: 'Valid title',
        category: TaskCategory.personal,
        date: '',
        time: '10:00',
      );

      final result = await useCase(task);

      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
        },
        (_) => fail('Should return failure'),
      );
    });

    test('should return ValidationFailure when time is empty', () async {
      final task = TaskEntity(
        title: 'Valid title',
        category: TaskCategory.personal,
        date: '2024-01-01',
        time: '',
      );

      final result = await useCase(task);

      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
        },
        (_) => fail('Should return failure'),
      );
    });

    test('should call repository on valid task', () async {
      final task = TaskEntity(
        title: 'Comprar leche',
        category: TaskCategory.personal,
        date: '2024-01-01',
        time: '10:00',
      );
      when(() => mockRepo.createTask(task))
          .thenAnswer((_) async => Right(task));

      final result = await useCase(task);

      expect(result.isRight(), true);
      verify(() => mockRepo.createTask(task)).called(1);
    });
  });
}