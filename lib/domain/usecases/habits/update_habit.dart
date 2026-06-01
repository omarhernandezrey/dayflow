import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/habit.dart';
import '../../repositories/habit_repository.dart';

class UpdateHabitUseCase {
  final HabitRepository _repository;

  const UpdateHabitUseCase(this._repository);

  Future<Either<Failure, HabitEntity>> call(HabitEntity habit) {
    if (habit.id == null) {
      return Future.value(const Left(ValidationFailure('El hábito no tiene ID')));
    }
    if (habit.title.trim().isEmpty) {
      return Future.value(const Left(ValidationFailure('El nombre del hábito es obligatorio')));
    }
    return _repository.updateHabit(habit);
  }
}
