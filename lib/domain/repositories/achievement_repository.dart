import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/achievement.dart';

abstract class AchievementRepository {
  Future<Either<Failure, List<AchievementEntity>>> getAllAchievements();
  Future<Either<Failure, List<AchievementEntity>>> getUnlockedAchievements();
  Future<Either<Failure, List<AchievementEntity>>> checkAndUnlockAchievements();
  Future<Either<Failure, void>> seedAchievements();
}
