import 'package:dartz/dartz.dart';
import 'package:googleapis/drive/v3.dart' as drive;

import '../../core/errors/failures.dart';
import '../datasources/google_drive_datasource.dart';

class GoogleDriveRepository {
  final GoogleDriveDatasource _datasource;

  GoogleDriveRepository(this._datasource);

  Future<Either<Failure, bool>> isSignedIn() async {
    try {
      final result = await _datasource.isSignedIn();
      return Right(result);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> signIn() async {
    try {
      await _datasource.signIn();
      return const Right(null);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> signOut() async {
    try {
      await _datasource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> uploadBackup(String filePath) async {
    try {
      final id = await _datasource.uploadBackup(filePath);
      return Right(id);
    } catch (e) {
      return Left(ExportFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> downloadBackup(String fileId, String destinationPath) async {
    try {
      final path = await _datasource.downloadBackup(fileId, destinationPath);
      return Right(path);
    } catch (e) {
      return Left(ImportFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<drive.File>>> listBackups() async {
    try {
      final files = await _datasource.listBackups();
      return Right(files);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
