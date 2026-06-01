import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/task.dart';
import '../../repositories/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository _repository;

  const UpdateTaskUseCase(this._repository);

  Future<Either<Failure, TaskEntity>> call(TaskEntity task) {
    if (task.id == null) {
      return Future.value(const Left(ValidationFailure('La tarea no tiene ID')));
    }
    if (task.title.trim().isEmpty) {
      return Future.value(const Left(ValidationFailure('El título es obligatorio')));
    }
    return _repository.updateTask(task);
  }
}
