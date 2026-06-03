import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/auth/get_current_user.dart';
import '../../domain/usecases/auth/get_most_recent_user.dart';
import '../../domain/usecases/auth/is_authenticated.dart';
import '../../domain/usecases/auth/login.dart';
import '../../domain/usecases/auth/logout.dart';
import '../../domain/usecases/auth/register.dart';
import '../../domain/usecases/auth/restore_session.dart';
import 'repository_providers.dart';

final loginUseCaseProvider = Provider((ref) => LoginUseCase(ref.watch(authRepositoryProvider)));
final registerUseCaseProvider = Provider((ref) => RegisterUseCase(ref.watch(authRepositoryProvider)));
final logoutUseCaseProvider = Provider((ref) => LogoutUseCase(ref.watch(authRepositoryProvider)));
final getCurrentUserUseCaseProvider = Provider((ref) => GetCurrentUserUseCase(ref.watch(authRepositoryProvider)));
final getMostRecentUserUseCaseProvider = Provider((ref) => GetMostRecentUserUseCase(ref.watch(authRepositoryProvider)));
final isAuthenticatedUseCaseProvider = Provider((ref) => IsAuthenticatedUseCase(ref.watch(authRepositoryProvider)));
final restoreSessionUseCaseProvider = Provider((ref) => RestoreSessionUseCase(ref.watch(authRepositoryProvider)));