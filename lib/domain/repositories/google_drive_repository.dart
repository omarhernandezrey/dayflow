import 'package:dartz/dartz.dart';
import 'package:googleapis/drive/v3.dart' as drive;

import '../../core/errors/failures.dart';

abstract class GoogleDriveRepository {
  Future<Either<Failure, bool>> isSignedIn();
  Future<Either<Failure, void>> signIn();
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, String>> uploadBackup(String filePath);
  Future<Either<Failure, String>> downloadBackup(String fileId, String destinationPath);
  Future<Either<Failure, List<drive.File>>> listBackups();
}