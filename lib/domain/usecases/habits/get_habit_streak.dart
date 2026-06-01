import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../repositories/habit_repository.dart';

class GetHabitStreakUseCase {
  final HabitRepository _repository;

  const GetHabitStreakUseCase(this._repository);

  Future<Either<Failure, int>> call(int habitId) => _repository.getHabitStreak(habitId);
}

class GetGlobalStreakUseCase {
  final HabitRepository _repository;

  const GetGlobalStreakUseCase(this._repository);

  Future<Either<Failure, int>> call() => _repository.getGlobalStreak();
}
