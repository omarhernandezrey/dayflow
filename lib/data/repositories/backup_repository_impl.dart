import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' show getDatabasesPath;

import '../../core/errors/failures.dart';
import '../../domain/repositories/backup_repository.dart';
import '../datasources/local_database.dart';
import '../datasources/file_datasource.dart';
import '../helpers/repository_helper.dart';

class BackupRepositoryImpl implements BackupRepository {
  final LocalDatabase _db;
  final FileDatasource _fileDs;

  BackupRepositoryImpl(this._db, this._fileDs);

  @override
  Future<Either<Failure, String>> exportToCsv() => executeOrFailure(
        () async {
          final tasks = await _db.queryTasks();
          final habits = await _db.queryHabits();
          final progress = await _db.queryHabitProgress();
          return _fileDs.exportToCsv(
            tasks: tasks,
            habits: habits,
            progress: progress,
          );
        },
        onAppException: ExportFailure.new,
      );

  @override
  Future<Either<Failure, String>> exportToPdf() => executeOrFailure(
        () async {
          final tasks = await _db.queryTasks();
          final habits = await _db.queryHabits();
          final progress = await _db.queryHabitProgress();
          return _fileDs.exportToPdf(
            tasks: tasks,
            habits: habits,
            progress: progress,
          );
        },
        onAppException: ExportFailure.new,
      );

  @override
  Future<Either<Failure, String>> createBackup() => executeOrFailure(
        () async {
          final dbDir = await getDatabasesPath();
          final dbPath = join(dbDir, _db.databaseName);
          final dbFile = File(dbPath);

          if (!await dbFile.exists()) {
            throw Exception('Base de datos no encontrada');
          }

          final timestamp = DateTime.now().millisecondsSinceEpoch;
          return _fileDs.createBackupZip(
            dbFilePath: dbPath,
            timestamp: timestamp,
          );
        },
        onAppException: ExportFailure.new,
      );

  @override
  Future<Either<Failure, void>> restoreBackup(String filePath) => executeOrFailure(
        () async {
          final dbDir = await getDatabasesPath();
          final dbPath = join(dbDir, _db.databaseName);
          await _fileDs.restoreBackupZip(
            backupFilePath: filePath,
            targetDbPath: dbPath,
          );
        },
        onAppException: ImportFailure.new,
      );
}