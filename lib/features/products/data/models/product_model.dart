import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/product_entity.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String id,
    required String name,
    required double price,
    @Default(0) int stock,
    @Default('') String categoryId,
    @Default('') String description,
    @Default('') String sku,
    String? imageUrl,
    @Default('active') String status,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
    DateTime? createdAt,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
    DateTime? updatedAt,
  }) = _ProductModel;

  const ProductModel._();

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel.fromJson({'id': doc.id, ...data});
  }

  factory ProductModel.fromEntity(ProductEntity entity) => ProductModel(
        id: entity.id,
        name: entity.name,
        price: entity.price,
        stock: entity.stock,
        categoryId: entity.categoryId,
        description: entity.description,
        sku: entity.sku,
        imageUrl: entity.imageUrl,
        status: entity.status.name,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  ProductEntity toEntity() => ProductEntity(
        id: id,
        name: name,
        price: price,
        stock: stock,
        categoryId: categoryId,
        description: description,
        sku: sku,
        imageUrl: imageUrl,
        status: ProductStatus.values.firstWhere(
          (e) => e.name == status,
          orElse: () => ProductStatus.active,
        ),
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
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
