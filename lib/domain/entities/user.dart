import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final String name;
  final String email;
  final String passwordHash;
  final String? createdAt;

  const UserEntity({
    this.id,
    required this.name,
    required this.email,
    required this.passwordHash,
    this.createdAt,
  });

  UserEntity copyWith({
    int? id,
    String? name,
    String? email,
    String? passwordHash,
    String? createdAt,
  }) =>
      UserEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        passwordHash: passwordHash ?? this.passwordHash,
        createdAt: createdAt ?? this.createdAt,
      );

  String get initials {
    final parts = name.trim().split(' ').where((s) => s.isNotEmpty).toList();
    if (parts.isEmpty) return 'U';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  @override
  List<Object?> get props => [id, name, email, passwordHash, createdAt];
}
