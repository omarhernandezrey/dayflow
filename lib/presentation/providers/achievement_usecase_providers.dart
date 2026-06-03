import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/achievements/get_achievements.dart';
import '../../domain/usecases/achievements/check_achievements.dart';
import 'repository_providers.dart';

final getAchievementsUseCaseProvider = Provider((ref) => GetAchievementsUseCase(ref.watch(achievementRepositoryProvider)));
final checkAchievementsUseCaseProvider = Provider((ref) => CheckAchievementsUseCase(ref.watch(achievementRepositoryProvider)));