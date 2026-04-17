// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String? ?? '',
      role: json['role'] as String? ?? 'salesRep',
      photoUrl: json['photo_url'] as String?,
      phone: json['phone'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: _timestampFromJson(json['created_at']),
      lastLoginAt: _timestampFromJson(json['last_login_at']),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'full_name': instance.fullName,
      'role': instance.role,
      'photo_url': instance.photoUrl,
      'phone': instance.phone,
      'is_active': instance.isActive,
      'created_at': _timestampToJson(instance.createdAt),
      'last_login_at': _timestampToJson(instance.lastLoginAt),
    };
