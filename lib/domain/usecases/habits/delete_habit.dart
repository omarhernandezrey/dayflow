import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../repositories/habit_repository.dart';

class DeleteHabitUseCase {
  final HabitRepository _repository;

  const DeleteHabitUseCase(this._repository);

  Future<Either<Failure, void>> call(int id) => _repository.deleteHabit(id);
}
