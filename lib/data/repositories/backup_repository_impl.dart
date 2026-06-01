import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' show getDatabasesPath;

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/repositories/backup_repository.dart';
import '../datasources/local_database.dart';
import '../datasources/file_datasource.dart';

class BackupRepositoryImpl implements BackupRepository {
  final LocalDatabase _db;
  final FileDatasource _fileDs;

  BackupRepositoryImpl(this._db, this._fileDs);

  @override
  Future<Either<Failure, String>> exportToCsv() async {
    try {
      final tasks = await _db.queryTasks();
      final habits = await _db.queryHabits();
      final progress = await _db.queryHabitProgress();

      final path = await _fileDs.exportToCsv(
        tasks: tasks,
        habits: habits,
        progress: progress,
      );
      return Right(path);
    } on AppException catch (e) {
      return Left(ExportFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, String>> exportToPdf() async {
    try {
      final tasks = await _db.queryTasks();
      final habits = await _db.queryHabits();
      final progress = await _db.queryHabitProgress();

      final path = await _fileDs.exportToPdf(
        tasks: tasks,
        habits: habits,
        progress: progress,
      );
      return Right(path);
    } on AppException catch (e) {
      return Left(ExportFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, String>> createBackup() async {
    try {
      final dbDir = await getDatabasesPath();
      final dbPath = join(dbDir, 'dayflow_v2.db');
      final dbFile = File(dbPath);

      if (!await dbFile.exists()) {
        return const Left(ExportFailure('Base de datos no encontrada'));
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final backupPath = await _fileDs.createBackupZip(
        dbFilePath: dbPath,
        timestamp: timestamp,
      );
      return Right(backupPath);
    } on AppException catch (e) {
      return Left(ExportFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, void>> restoreBackup(String filePath) async {
    try {
      final dbDir = await getDatabasesPath();
      final dbPath = join(dbDir, 'dayflow_v2.db');

      await _fileDs.restoreBackupZip(
        backupFilePath: filePath,
        targetDbPath: dbPath,
      );
      return const Right(null);
    } on AppException catch (e) {
      return Left(ImportFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }
}
