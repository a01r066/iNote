import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    @Default('') String fullName,
    @Default('salesRep') String role,
    String? photoUrl,
    String? phone,
    @Default(true) bool isActive,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
    DateTime? createdAt,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
    DateTime? lastLoginAt,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel.fromJson({'id': doc.id, ...data});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  UserEntity toEntity() => UserEntity(
        id: id,
        email: email,
        fullName: fullName,
        role: _parseRole(role),
        photoUrl: photoUrl,
        phone: phone,
        isActive: isActive,
        createdAt: createdAt,
        lastLoginAt: lastLoginAt,
      );

  static UserRole _parseRole(String role) {
    switch (role) {
      case 'admin':
        return UserRole.admin;
      case 'manager':
        return UserRole.manager;
      default:
        return UserRole.salesRep;
    }
  }
}

DateTime? _timestampFromJson(dynamic value) {
  if (value is Timestamp) return value.toDate();
  if (value is String) return DateTime.tryParse(value);
  return null;
}

dynamic _timestampToJson(DateTime? date) {
  if (date == null) return null;
  return Timestamp.fromDate(date);
}
