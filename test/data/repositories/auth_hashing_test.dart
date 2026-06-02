import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Password hashing with salt', () {
    String generateSalt() {
      final random = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
          17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32];
      return random.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    }

    String hashPassword(String password, String salt) {
      final bytes = utf8.encode(salt + password);
      final digest = sha256.convert(bytes);
      return '$salt:${digest.toString()}';
    }

    bool verifyPassword(String password, String storedHash) {
      if (storedHash.contains(':')) {
        final colonIndex = storedHash.indexOf(':');
        final salt = storedHash.substring(0, colonIndex);
        final hash = storedHash.substring(colonIndex + 1);
        final computedHash =
            sha256.convert(utf8.encode(salt + password)).toString();
        return hash == computedHash;
      } else {
        final hash = sha256.convert(utf8.encode(password)).toString();
        return storedHash == hash;
      }
    }

    test('should generate different hashes for same password with different salts',
        () {
      const password = 'mySecret123';
      const salt1 = '0102030405060708090a0b0c0d0e0f10111213141516171819101a1b1c1d1e1f20';
      const salt2 = 'aabbccddeeff00112233445566778899aabbccddeeff00112233445566778899';

      final hash1 = hashPassword(password, salt1);
      final hash2 = hashPassword(password, salt2);

      expect(hash1, isNot(equals(hash2)));
    });

    test('should verify password correctly with salted hash', () {
      const password = 'mySecret123';
      const salt =
          '0102030405060708090a0b0c0d0e0f10111213141516171819101a1b1c1d1e1f20';
      final hash = hashPassword(password, salt);

      expect(verifyPassword(password, hash), true);
      expect(verifyPassword('wrongPassword', hash), false);
    });

    test('should verify legacy passwords without salt', () {
      const password = 'mySecret123';
      final legacyHash = sha256.convert(utf8.encode(password)).toString();

      expect(verifyPassword(password, legacyHash), true);
      expect(verifyPassword('wrongPassword', legacyHash), false);
    });

    test('should distinguish between salted and unsalted formats', () {
      const password = 'test123';
      const salt =
          '0102030405060708090a0b0c0d0e0f10111213141516171819101a1b1c1d1e1f20';
      final saltedHash = hashPassword(password, salt);
      final unsaltedHash = sha256.convert(utf8.encode(password)).toString();

      expect(saltedHash.contains(':'), true);
      expect(unsaltedHash.contains(':'), false);
    });

    test('should produce consistent results', () {
      const password = 'consistentTest';
      const salt =
          '0102030405060708090a0b0c0d0e0f10111213141516171819101a1b1c1d1e1f20';

      final hash1 = hashPassword(password, salt);
      final hash2 = hashPassword(password, salt);

      expect(hash1, equals(hash2));
    });
  });
}