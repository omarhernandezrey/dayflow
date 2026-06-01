import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/local_database.dart';
import '../models/task_model.dart';
import 'notification_repository_impl.dart';

class TaskRepositoryImpl implements TaskRepository {
  final LocalDatabase _db;
  final NotificationRepositoryImpl _notifications;

  TaskRepositoryImpl(this._db, this._notifications);

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTasks() async {
    try {
      final rows = await _db.queryTasks();
      return Right(rows.map((r) => TaskModel.fromMap(r).toEntity()).toList());
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasksByCategory(TaskCategory category) async {
    try {
      final catStr = category.value;
      final rows = await _db.queryTasks(where: 'category = ?', whereArgs: [catStr]);
      return Right(rows.map((r) => TaskModel.fromMap(r).toEntity()).toList());
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasksByDate(String date) async {
    try {
      final rows = await _db.queryTasks(where: 'date = ?', whereArgs: [date]);
      return Right(rows.map((r) => TaskModel.fromMap(r).toEntity()).toList());
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> searchTasks(String query) async {
    try {
      final rows = await _db.searchTasks(query);
      return Right(rows.map((r) => TaskModel.fromMap(r).toEntity()).toList());
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> getTaskById(int id) async {
    try {
      final rows = await _db.queryTasks(where: 'id = ?', whereArgs: [id]);
      if (rows.isEmpty) return const Left(NotFoundFailure('Tarea no encontrada'));
      return Right(TaskModel.fromMap(rows.first).toEntity());
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> createTask(TaskEntity task) async {
    try {
      final model = TaskModel.fromEntity(task);
      final id = await _db.insertTask(model.toMap()..remove('id'));
      final saved = model.copyWith(id: id);
      await _notifications.scheduleTaskReminder(saved.toEntity());
      return Right(saved.toEntity());
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> updateTask(TaskEntity task) async {
    try {
      if (task.id == null) {
        return const Left(ValidationFailure('La tarea no tiene ID'));
      }
      final model = TaskModel.fromEntity(task);
      await _db.updateTask(model.toMap(), task.id!);
      await _notifications.cancelReminder(task.id!);
      if (!task.completed) {
        await _notifications.scheduleTaskReminder(task);
      }
      return Right(task);
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(int id) async {
    try {
      await _db.deleteTask(id);
      await _notifications.cancelReminder(id);
      return const Right(null);
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, void>> toggleTaskCompletion(int id, bool completed) async {
    try {
      await _db.updateTask({'completed': completed ? 1 : 0}, id);
      if (completed) await _notifications.cancelReminder(id);
      return const Right(null);
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

}
