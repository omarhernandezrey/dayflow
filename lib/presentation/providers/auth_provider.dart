import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user.dart';
import 'dependency_providers.dart';

final authStateProvider = AsyncNotifierProvider<AuthNotifier, UserEntity?>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<UserEntity?> {
  @override
  Future<UserEntity?> build() async {
    final useCase = ref.read(isAuthenticatedUseCaseProvider);
    final result = await useCase.call();
    final isAuth = result.getOrElse(() => false);
    if (!isAuth) return null;

    final userCase = ref.read(getCurrentUserUseCaseProvider);
    final userResult = await userCase.call();
    return userResult.getOrElse(() => null);
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    final useCase = ref.read(loginUseCaseProvider);
    final result = await useCase.call(email: email, password: password);
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (user) => AsyncValue.data(user),
    );
  }

  Future<void> register(String name, String email, String password) async {
    state = const AsyncValue.loading();
    final useCase = ref.read(registerUseCaseProvider);
    final result = await useCase.call(name: name, email: email, password: password);
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (user) => AsyncValue.data(user),
    );
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    final useCase = ref.read(logoutUseCaseProvider);
    final result = await useCase.call();
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => state = const AsyncValue.data(null),
    );
  }
}

final isAuthenticatedProvider = Provider<AsyncValue<bool>>((ref) {
  final authAsync = ref.watch(authStateProvider);
  return authAsync.when(
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
    data: (user) => AsyncValue.data(user != null),
  );
});
