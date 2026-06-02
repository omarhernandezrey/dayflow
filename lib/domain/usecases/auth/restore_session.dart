import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../repositories/auth_repository.dart';

class RestoreSessionUseCase {
  final AuthRepository _repository;

  const RestoreSessionUseCase(this._repository);

  Future<Either<Failure, void>> call(int userId) =>
      _repository.restoreSession(userId);
}