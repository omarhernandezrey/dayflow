import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../repositories/backup_repository.dart';

class ExportToCsvUseCase {
  final BackupRepository _repository;

  const ExportToCsvUseCase(this._repository);

  Future<Either<Failure, String>> call() => _repository.exportToCsv();
}

class ExportToPdfUseCase {
  final BackupRepository _repository;

  const ExportToPdfUseCase(this._repository);

  Future<Either<Failure, String>> call() => _repository.exportToPdf();
}

class CreateBackupUseCase {
  final BackupRepository _repository;

  const CreateBackupUseCase(this._repository);

  Future<Either<Failure, String>> call() => _repository.createBackup();
}

class RestoreBackupUseCase {
  final BackupRepository _repository;

  const RestoreBackupUseCase(this._repository);

  Future<Either<Failure, void>> call(String filePath) => _repository.restoreBackup(filePath);
}
