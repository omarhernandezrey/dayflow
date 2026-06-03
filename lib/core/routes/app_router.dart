import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/forgot_password_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/auth/splash_screen.dart';
import '../../features/habits/add_habit_screen.dart';
import '../../features/tasks/add_task_screen.dart';
import '../../features/tasks/task_detail_screen.dart';
import '../../l10n/app_localizations.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/screens/achievements/achievements_screen.dart';
import '../../presentation/screens/backup/backup_screen.dart';
import '../../presentation/screens/calendar/calendar_screen.dart';
import '../../presentation/screens/habits/habits_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/more/more_screen.dart';
import '../../presentation/screens/stats/stats_screen.dart';
import '../../presentation/screens/tasks/tasks_screen.dart';
import '../../domain/entities/habit.dart';
import '../../domain/entities/task.dart';
import '../../shared/widgets/df_nav_shell.dart';

GoRoute _simple(String path, Widget screen) =>
    GoRoute(path: path, builder: (context, state) => screen);

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final authAsync = ref.read(authStateProvider);
      final isAuth = authAsync.hasValue && authAsync.value != null;

      final path = state.matchedLocation;
      final isAuthRoute = path == '/splash' ||
          path == '/login' ||
          path == '/register' ||
          path == '/forgot-password';

      if (isAuth && isAuthRoute) {
        return '/home';
      }
      if (!isAuth && !isAuthRoute) {
        return '/splash';
      }
      return null;
    },
    refreshListenable: _AuthRefresh(ref),
    routes: [
      // ── Auth ──────────────────────────────────────────────────
      _simple('/splash', const SplashScreen()),
      _simple('/login', const LoginScreen()),
      _simple('/register', const RegisterScreen()),
      _simple('/forgot-password', const ForgotPasswordScreen()),

      // ── Main shell (5 tabs, preserva estado) ──────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => DFNavShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(routes: [_simple('/home', const HomeScreen())]),
          StatefulShellBranch(routes: [_simple('/tasks', const TasksScreen())]),
          StatefulShellBranch(routes: [_simple('/habits', const HabitsScreen())]),
          StatefulShellBranch(routes: [_simple('/stats', const StatsScreen())]),
          StatefulShellBranch(routes: [_simple('/more', const MoreScreen())]),
        ],
      ),

      // ── Pantallas de detalle ───────────────────────────────────
      GoRoute(
        path: '/add-task',
        builder: (_, state) => AddTaskScreen(task: state.extra as TaskEntity?),
      ),
      GoRoute(
        path: '/task-detail',
        builder: (_, state) {
          final task = state.extra;
          if (task is! TaskEntity) return const _ErrorScreen();
          return TaskDetailScreen(task: task);
        },
      ),
      GoRoute(
        path: '/add-habit',
        builder: (_, state) => AddHabitScreen(habit: state.extra as HabitEntity?),
      ),

      // ── Nuevas pantallas ──────────────────────────────────────
      _simple('/calendar', const CalendarScreen()),
      _simple('/achievements', const AchievementsScreen()),
      _simple('/backup', const BackupScreen()),
    ],
  );
});

class _AuthRefresh extends ChangeNotifier {
  _AuthRefresh(Ref ref) {
    ref.listen(authStateProvider, (previous, next) => notifyListeners());
  }
}

class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(child: Text(l10n.pageNotFound)),
    );
  }
}
