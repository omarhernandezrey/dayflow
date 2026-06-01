import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../repositories/task_repository.dart';

class ToggleTaskUseCase {
  final TaskRepository _repository;

  const ToggleTaskUseCase(this._repository);

  Future<Either<Failure, void>> call(int id, bool completed) =>
      _repository.toggleTaskCompletion(id, completed);
}
