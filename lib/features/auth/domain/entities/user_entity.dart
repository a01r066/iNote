import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

enum UserRole { admin, manager, salesRep }

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String email,
    required String fullName,
    required UserRole role,
    String? photoUrl,
    String? phone,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) = _UserEntity;

  const UserEntity._();

  bool get isAdmin => role == UserRole.admin;
  bool get isManager => role == UserRole.manager || role == UserRole.admin;

  String get displayName => fullName.isNotEmpty ? fullName : email;

  String get roleLabel {
    switch (role) {
      case UserRole.admin:
        return 'Administrator';
      case UserRole.manager:
        return 'Sales Manager';
      case UserRole.salesRep:
        return 'Sales Representative';
    }
  }
}
