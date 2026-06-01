import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';

abstract class BackupRepository {
  Future<Either<Failure, String>> exportToCsv();
  Future<Either<Failure, String>> exportToPdf();
  Future<Either<Failure, String>> createBackup();
  Future<Either<Failure, void>> restoreBackup(String filePath);
}
