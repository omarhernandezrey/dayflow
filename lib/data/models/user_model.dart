import '../../domain/entities/user.dart';

class UserModel {
  final int? id;
  final String name;
  final String email;
  final String passwordHash;
  final String? createdAt;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.passwordHash,
    this.createdAt,
  });

  UserEntity toEntity() => UserEntity(
        id: id,
        name: name,
        email: email,
        createdAt: createdAt,
      );

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        'name': name,
        'email': email,
        'password_hash': passwordHash,
        if (createdAt != null) 'created_at': createdAt,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['id'] as int?,
        name: map['name'] as String,
        email: map['email'] as String,
        passwordHash: map['password_hash'] as String,
        createdAt: map['created_at'] as String?,
      );

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? passwordHash,
    String? createdAt,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        passwordHash: passwordHash ?? this.passwordHash,
        createdAt: createdAt ?? this.createdAt,
      );
}