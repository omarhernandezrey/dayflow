import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';

class GetMostRecentUserUseCase {
  final AuthRepository _repository;

  const GetMostRecentUserUseCase(this._repository);

  Future<Either<Failure, UserEntity?>> call() => _repository.getMostRecentUser();
}
