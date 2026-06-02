import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';

typedef RepositoryAction<T> = Future<T> Function();

Future<Either<Failure, T>> executeOrFailure<T>(
  RepositoryAction<T> action, {
  Failure Function(String message)? onAppException,
}) async {
  try {
    final result = await action();
    return Right(result);
  } on AppException catch (e) {
    return Left((onAppException ?? DatabaseFailure.new)(e.message));
  } catch (e, st) {
    return Left(UnexpectedFailure(e.toString(), stackTrace: st));
  }
}