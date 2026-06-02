import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:dayflow/core/errors/failures.dart';
import 'package:dayflow/domain/entities/user.dart';
import 'package:dayflow/domain/repositories/auth_repository.dart';
import 'package:dayflow/domain/usecases/auth/register.dart';

import '../../../helpers/mocks.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepo;
  late RegisterUseCase useCase;

  setUp(() {
    mockRepo = MockAuthRepository();
    useCase = RegisterUseCase(mockRepo);
  });

  group('RegisterUseCase', () {
    const testName = 'Test User';
    const testEmail = 'test@example.com';
    const testPassword = 'password123';

    test('should return UserEntity on successful registration', () async {
      final user = UserEntity(
        id: 1,
        name: testName,
        email: testEmail,
      );
      when(() => mockRepo.register(
            name: testName,
            email: testEmail,
            password: testPassword,
          )).thenAnswer((_) async => Right(user));

      final result = await useCase(
        name: testName,
        email: testEmail,
        password: testPassword,
      );

      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Should not return failure'),
        (returnedUser) => expect(returnedUser.email, testEmail),
      );
    });

    test('should return ValidationFailure on duplicate email', () async {
      when(() => mockRepo.register(
            name: testName,
            email: testEmail,
            password: testPassword,
          )).thenAnswer((_) async =>
              const Left(ValidationFailure('Ya existe una cuenta con este correo')));

      final result = await useCase(
        name: testName,
        email: testEmail,
        password: testPassword,
      );

      expect(result.isLeft(), true);
    });
  });
}