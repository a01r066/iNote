// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      categoryId: json['category_id'] as String? ?? '',
      description: json['description'] as String? ?? '',
      sku: json['sku'] as String? ?? '',
      imageUrl: json['image_url'] as String?,
      status: json['status'] as String? ?? 'active',
      createdAt: _timestampFromJson(json['created_at']),
      updatedAt: _timestampFromJson(json['updated_at']),
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'stock': instance.stock,
      'category_id': instance.categoryId,
      'description': instance.description,
      'sku': instance.sku,
      'image_url': instance.imageUrl,
      'status': instance.status,
      'created_at': _timestampToJson(instance.createdAt),
      'updated_at': _timestampToJson(instance.updatedAt),
    };
