import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/habit.dart';
import '../../repositories/habit_repository.dart';

class GetAllHabitsUseCase {
  final HabitRepository _repository;

  const GetAllHabitsUseCase(this._repository);

  Future<Either<Failure, List<HabitEntity>>> call() => _repository.getAllHabits();
}
