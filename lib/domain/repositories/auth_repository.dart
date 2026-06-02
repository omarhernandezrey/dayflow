import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, UserEntity?>> getCurrentUser();

  Future<Either<Failure, bool>> isAuthenticated();

  Future<Either<Failure, UserEntity?>> getMostRecentUser();

  Future<Either<Failure, void>> restoreSession(int userId);
}
