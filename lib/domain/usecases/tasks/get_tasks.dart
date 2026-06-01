import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/task.dart';
import '../../repositories/task_repository.dart';

class GetAllTasksUseCase {
  final TaskRepository _repository;

  const GetAllTasksUseCase(this._repository);

  Future<Either<Failure, List<TaskEntity>>> call() => _repository.getAllTasks();
}
