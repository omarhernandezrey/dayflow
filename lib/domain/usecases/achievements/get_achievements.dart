import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/achievement.dart';
import '../../repositories/achievement_repository.dart';

class GetAchievementsUseCase {
  final AchievementRepository _repository;

  const GetAchievementsUseCase(this._repository);

  Future<Either<Failure, List<AchievementEntity>>> call() => _repository.getAllAchievements();
}

class CheckAchievementsUseCase {
  final AchievementRepository _repository;

  const CheckAchievementsUseCase(this._repository);

  Future<Either<Failure, List<AchievementEntity>>> call() =>
      _repository.checkAndUnlockAchievements();
}
