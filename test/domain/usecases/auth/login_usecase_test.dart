import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:dayflow/core/errors/failures.dart';
import 'package:dayflow/domain/entities/user.dart';
import 'package:dayflow/domain/repositories/auth_repository.dart';
import 'package:dayflow/domain/usecases/auth/login.dart';

import '../../../helpers/mocks.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepo;
  late LoginUseCase useCase;

  setUp(() {
    mockRepo = MockAuthRepository();
    useCase = LoginUseCase(mockRepo);
  });

  group('LoginUseCase', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';

    test('should return UserEntity on successful login', () async {
      final user = UserEntity(
        id: 1,
        name: 'Test User',
        email: testEmail,
      );
      when(() => mockRepo.login(email: testEmail, password: testPassword))
          .thenAnswer((_) async => Right(user));

      final result = await useCase(email: testEmail, password: testPassword);

      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Should not return failure'),
        (returnedUser) => expect(returnedUser.email, testEmail),
      );
    });

    test('should return ValidationFailure on wrong credentials', () async {
      when(() => mockRepo.login(email: testEmail, password: testPassword))
          .thenAnswer(
              (_) async => const Left(ValidationFailure('Correo o contraseña incorrectos')));

      final result = await useCase(email: testEmail, password: testPassword);

      expect(result.isLeft(), true);
    });

    test('should return DatabaseFailure on database error', () async {
      when(() => mockRepo.login(email: testEmail, password: testPassword))
          .thenAnswer(
              (_) async => const Left(DatabaseFailure('Database error')));

      final result = await useCase(email: testEmail, password: testPassword);

      expect(result.isLeft(), true);
    });
  });
}