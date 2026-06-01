import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/task.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskEntity>>> getAllTasks();
  Future<Either<Failure, List<TaskEntity>>> getTasksByCategory(TaskCategory category);
  Future<Either<Failure, List<TaskEntity>>> getTasksByDate(String date);
  Future<Either<Failure, List<TaskEntity>>> searchTasks(String query);
  Future<Either<Failure, TaskEntity>> getTaskById(int id);
  Future<Either<Failure, TaskEntity>> createTask(TaskEntity task);
  Future<Either<Failure, TaskEntity>> updateTask(TaskEntity task);
  Future<Either<Failure, void>> deleteTask(int id);
  Future<Either<Failure, void>> toggleTaskCompletion(int id, bool completed);
}
