import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_entity.freezed.dart';

enum ProductStatus { active, inactive, outOfStock }

@freezed
class ProductEntity with _$ProductEntity {
  const factory ProductEntity({
    required String id,
    required String name,
    required double price,
    required int stock,
    required String categoryId,
    @Default('') String description,
    @Default('') String sku,
    String? imageUrl,
    @Default(ProductStatus.active) ProductStatus status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProductEntity;

  const ProductEntity._();

  bool get isAvailable => status == ProductStatus.active && stock > 0;
  bool get isLowStock => stock > 0 && stock <= 10;
  bool get isOutOfStock => stock == 0;

  String get statusLabel {
    switch (status) {
      case ProductStatus.active:
        return 'Active';
      case ProductStatus.inactive:
        return 'Inactive';
      case ProductStatus.outOfStock:
        return 'Out of Stock';
    }
  }
}
