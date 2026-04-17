import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_entity.freezed.dart';

@freezed
class CustomerEntity with _$CustomerEntity {
  const factory CustomerEntity({
    required String id,
    required String fullName,
    required String email,
    String? phone,
    String? address,
    String? company,
    String? photoUrl,
    @Default(0) double totalPurchases,
    @Default(0) int orderCount,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? lastOrderAt,
  }) = _CustomerEntity;

  const CustomerEntity._();

  String get initials {
    final parts = fullName.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return fullName.isNotEmpty ? fullName[0].toUpperCase() : '?';
  }

  bool get isHighValue => totalPurchases >= 10000;
}
