import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';

abstract class BiometricRepository {
  Future<Either<Failure, bool>> isAvailable();
  Future<Either<Failure, bool>> authenticate();
}