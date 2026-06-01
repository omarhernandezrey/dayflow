import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/achievement.dart';
import 'dependency_providers.dart';

final achievementsProvider =
    AsyncNotifierProvider<AchievementsNotifier, List<AchievementEntity>>(
        AchievementsNotifier.new);

class AchievementsNotifier extends AsyncNotifier<List<AchievementEntity>> {
  @override
  Future<List<AchievementEntity>> build() async {
    final useCase = ref.read(getAchievementsUseCaseProvider);
    final result = await useCase.call();
    return result.getOrElse(() => []);
  }

  Future<List<AchievementEntity>> checkAndUnlock() async {
    final useCase = ref.read(checkAchievementsUseCaseProvider);
    final result = await useCase.call();
    return result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return <AchievementEntity>[];
      },
      (unlocked) {
        _refresh();
        return unlocked;
      },
    );
  }

  Future<void> _refresh() async {
    final useCase = ref.read(getAchievementsUseCaseProvider);
    final result = await useCase.call();
    state = AsyncValue.data(result.getOrElse(() => []));
  }
}

// Unlocked achievements count (for badges)
final unlockedAchievementsCountProvider = Provider<AsyncValue<int>>((ref) {
  final async = ref.watch(achievementsProvider);
  return async.when(
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
    data: (list) => AsyncValue.data(list.where((a) => a.isUnlocked).length),
  );
});
