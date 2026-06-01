import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../repositories/auth_repository.dart';

class IsAuthenticatedUseCase {
  final AuthRepository _repository;

  const IsAuthenticatedUseCase(this._repository);

  Future<Either<Failure, bool>> call() => _repository.isAuthenticated();
}
