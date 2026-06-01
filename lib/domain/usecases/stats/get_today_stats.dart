import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/daily_summary.dart';
import '../../repositories/stats_repository.dart';

class GetTodayStatsUseCase {
  final StatsRepository _repository;

  const GetTodayStatsUseCase(this._repository);

  Future<Either<Failure, DailySummaryEntity>> call() => _repository.getTodayStats();
}
