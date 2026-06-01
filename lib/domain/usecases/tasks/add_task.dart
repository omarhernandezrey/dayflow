import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/task.dart';
import '../../repositories/task_repository.dart';

class AddTaskUseCase {
  final TaskRepository _repository;

  const AddTaskUseCase(this._repository);

  Future<Either<Failure, TaskEntity>> call(TaskEntity task) {
    if (task.title.trim().isEmpty) {
      return Future.value(const Left(ValidationFailure('El título es obligatorio')));
    }
    if (task.date.isEmpty || task.time.isEmpty) {
      return Future.value(const Left(ValidationFailure('La fecha y hora son obligatorias')));
    }
    return _repository.createTask(task);
  }
}
