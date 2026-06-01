import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/task.dart';
import '../../repositories/task_repository.dart';

class SearchTasksUseCase {
  final TaskRepository _repository;

  const SearchTasksUseCase(this._repository);

  Future<Either<Failure, List<TaskEntity>>> call(String query) {
    if (query.trim().isEmpty) {
      return _repository.getAllTasks();
    }
    return _repository.searchTasks(query.trim());
  }
}
