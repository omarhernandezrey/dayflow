import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository _repository;

  const DeleteTaskUseCase(this._repository);

  Future<Either<Failure, void>> call(int id) => _repository.deleteTask(id);
}
