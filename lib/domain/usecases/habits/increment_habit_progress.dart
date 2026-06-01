import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/habit_progress.dart';
import '../../repositories/habit_repository.dart';

class IncrementHabitProgressUseCase {
  final HabitRepository _repository;

  const IncrementHabitProgressUseCase(this._repository);

  Future<Either<Failure, HabitProgressEntity>> call({
    required int habitId,
    required String date,
    required double amount,
  }) =>
      _repository.incrementProgress(habitId, date, amount);
}
