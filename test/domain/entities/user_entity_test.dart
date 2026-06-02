import 'package:flutter_test/flutter_test.dart';
import 'package:dayflow/domain/entities/user.dart';

void main() {
  group('UserEntity', () {
    test('should create with required fields', () {
      final user = UserEntity(
        id: 1,
        name: 'Omar',
        email: 'omar@test.com',
        createdAt: '2024-01-01',
      );
      expect(user.id, 1);
      expect(user.name, 'Omar');
      expect(user.email, 'omar@test.com');
      expect(user.createdAt, '2024-01-01');
    });

    test('should generate initials from full name', () {
      final user = UserEntity(name: 'Omar Hernandez', email: 'omar@test.com');
      expect(user.initials, 'OH');
    });

    test('should generate initials from single name', () {
      final user = UserEntity(name: 'Omar', email: 'omar@test.com');
      expect(user.initials, 'O');
    });

    test('should return U for empty name', () {
      final user = UserEntity(name: '   ', email: 'omar@test.com');
      expect(user.initials, 'U');
    });

    test('should support equality by value', () {
      final user1 = UserEntity(id: 1, name: 'Omar', email: 'omar@test.com');
      final user2 = UserEntity(id: 1, name: 'Omar', email: 'omar@test.com');
      expect(user1, equals(user2));
    });

    test('should support copyWith', () {
      final user = UserEntity(id: 1, name: 'Omar', email: 'old@test.com');
      final updated = user.copyWith(email: 'new@test.com');
      expect(updated.email, 'new@test.com');
      expect(updated.name, 'Omar');
      expect(updated.id, 1);
    });

    test('should not have passwordHash field', () {
      final user = UserEntity(id: 1, name: 'Omar', email: 'omar@test.com');
      expect(user.id, 1);
      expect(user.name, 'Omar');
      expect(user.email, 'omar@test.com');
      expect(user.props.length, 4);
      expect(user.props, containsAll([1, 'Omar', 'omar@test.com']));
    });
  });
}