import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/stats/get_monthly_stats.dart';
import '../../domain/usecases/stats/get_today_stats.dart';
import '../../domain/usecases/stats/get_weekly_stats.dart';
import 'repository_providers.dart';

final getTodayStatsUseCaseProvider = Provider((ref) => GetTodayStatsUseCase(ref.watch(statsRepositoryProvider)));
final getWeeklyStatsUseCaseProvider = Provider((ref) => GetWeeklyStatsUseCase(ref.watch(statsRepositoryProvider)));
final getMonthlyStatsUseCaseProvider = Provider((ref) => GetMonthlyStatsUseCase(ref.watch(statsRepositoryProvider)));