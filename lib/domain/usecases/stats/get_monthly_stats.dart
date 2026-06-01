import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/monthly_stats.dart';
import '../../repositories/stats_repository.dart';

class GetMonthlyStatsUseCase {
  final StatsRepository _repository;

  const GetMonthlyStatsUseCase(this._repository);

  Future<Either<Failure, MonthlyStatsEntity>> call(int year, int month) =>
      _repository.getMonthlyStats(year, month);
}
