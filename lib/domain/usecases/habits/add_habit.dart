import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/habit.dart';
import '../../repositories/habit_repository.dart';

class AddHabitUseCase {
  final HabitRepository _repository;

  const AddHabitUseCase(this._repository);

  Future<Either<Failure, HabitEntity>> call(HabitEntity habit) {
    if (habit.title.trim().isEmpty) {
      return Future.value(const Left(ValidationFailure('El nombre del hábito es obligatorio')));
    }
    if (habit.goal <= 0) {
      return Future.value(const Left(ValidationFailure('La meta debe ser mayor a 0')));
    }
    return _repository.createHabit(habit);
  }
}
