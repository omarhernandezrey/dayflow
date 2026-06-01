import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/biometric_datasource.dart';
import '../../data/repositories/biometric_repository.dart';

final biometricDatasourceProvider = Provider((ref) => BiometricDatasource());

final biometricRepositoryProvider = Provider(
  (ref) => BiometricRepository(ref.watch(biometricDatasourceProvider)),
);

final biometricsAvailableProvider = FutureProvider<bool>((ref) async {
  final repo = ref.watch(biometricRepositoryProvider);
  final result = await repo.isAvailable();
  return result.getOrElse(() => false);
});
