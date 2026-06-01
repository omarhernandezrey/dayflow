import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../datasources/biometric_datasource.dart';

class BiometricRepository {
  final BiometricDatasource _datasource;

  BiometricRepository(this._datasource);

  Future<Either<Failure, bool>> isAvailable() async {
    try {
      final supported = await _datasource.isDeviceSupported();
      if (!supported) return const Right(false);
      final enrolled = await _datasource.areBiometricsEnrolled();
      return Right(enrolled);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  Future<Either<Failure, bool>> authenticate() async {
    try {
      final result = await _datasource.authenticate();
      return Right(result);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
