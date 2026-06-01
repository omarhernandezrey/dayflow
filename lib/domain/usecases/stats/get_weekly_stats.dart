import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/weekly_stats.dart';
import '../../repositories/stats_repository.dart';

class GetWeeklyStatsUseCase {
  final StatsRepository _repository;

  const GetWeeklyStatsUseCase(this._repository);

  Future<Either<Failure, WeeklyStatsEntity>> call() => _repository.getWeeklyStats();
}
