// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrderItemEntity {
  String get productId => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  double get unitPrice => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String? get productImageUrl => throw _privateConstructorUsedError;
  double get discount => throw _privateConstructorUsedError;

  /// Create a copy of OrderItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderItemEntityCopyWith<OrderItemEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemEntityCopyWith<$Res> {
  factory $OrderItemEntityCopyWith(
          OrderItemEntity value, $Res Function(OrderItemEntity) then) =
      _$OrderItemEntityCopyWithImpl<$Res, OrderItemEntity>;
  @useResult
  $Res call(
      {String productId,
      String productName,
      double unitPrice,
      int quantity,
      String? productImageUrl,
      double discount});
}

/// @nodoc
class _$OrderItemEntityCopyWithImpl<$Res, $Val extends OrderItemEntity>
    implements $OrderItemEntityCopyWith<$Res> {
  _$OrderItemEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? productName = null,
    Object? unitPrice = null,
    Object? quantity = null,
    Object? productImageUrl = freezed,
    Object? discount = null,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      productImageUrl: freezed == productImageUrl
          ? _value.productImageUrl
          : productImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderItemEntityImplCopyWith<$Res>
    implements $OrderItemEntityCopyWith<$Res> {
  factory _$$OrderItemEntityImplCopyWith(_$OrderItemEntityImpl value,
          $Res Function(_$OrderItemEntityImpl) then) =
      __$$OrderItemEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String productId,
      String productName,
      double unitPrice,
      int quantity,
      String? productImageUrl,
      double discount});
}

/// @nodoc
class __$$OrderItemEntityImplCopyWithImpl<$Res>
    extends _$OrderItemEntityCopyWithImpl<$Res, _$OrderItemEntityImpl>
    implements _$$OrderItemEntityImplCopyWith<$Res> {
  __$$OrderItemEntityImplCopyWithImpl(
      _$OrderItemEntityImpl _value, $Res Function(_$OrderItemEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? productName = null,
    Object? unitPrice = null,
    Object? quantity = null,
    Object? productImageUrl = freezed,
    Object? discount = null,
  }) {
    return _then(_$OrderItemEntityImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      productImageUrl: freezed == productImageUrl
          ? _value.productImageUrl
          : productImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$OrderItemEntityImpl extends _OrderItemEntity {
  const _$OrderItemEntityImpl(
      {required this.productId,
      required this.productName,
      required this.unitPrice,
      required this.quantity,
      this.productImageUrl,
      this.discount = 0})
      : super._();

  @override
  final String productId;
  @override
  final String productName;
  @override
  final double unitPrice;
  @override
  final int quantity;
  @override
  final String? productImageUrl;
  @override
  @JsonKey()
  final double discount;

  @override
  String toString() {
    return 'OrderItemEntity(productId: $productId, productName: $productName, unitPrice: $unitPrice, quantity: $quantity, productImageUrl: $productImageUrl, discount: $discount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemEntityImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.productImageUrl, productImageUrl) ||
                other.productImageUrl == productImageUrl) &&
            (identical(other.discount, discount) ||
                other.discount == discount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, productId, productName,
      unitPrice, quantity, productImageUrl, discount);

  /// Create a copy of OrderItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemEntityImplCopyWith<_$OrderItemEntityImpl> get copyWith =>
      __$$OrderItemEntityImplCopyWithImpl<_$OrderItemEntityImpl>(
          this, _$identity);
}

abstract class _OrderItemEntity extends OrderItemEntity {
  const factory _OrderItemEntity(
      {required final String productId,
      required final String productName,
      required final double unitPrice,
      required final int quantity,
      final String? productImageUrl,
      final double discount}) = _$OrderItemEntityImpl;
  const _OrderItemEntity._() : super._();

  @override
  String get productId;
  @override
  String get productName;
  @override
  double get unitPrice;
  @override
  int get quantity;
  @override
  String? get productImageUrl;
  @override
  double get discount;

  /// Create a copy of OrderItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderItemEntityImplCopyWith<_$OrderItemEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OrderEntity {
  String get id => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  String get customerName => throw _privateConstructorUsedError;
  List<OrderItemEntity> get items => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  OrderStatus get status => throw _privateConstructorUsedError;
  PaymentStatus get paymentStatus => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get createdById => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get deliveredAt => throw _privateConstructorUsedError;

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderEntityCopyWith<OrderEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderEntityCopyWith<$Res> {
  factory $OrderEntityCopyWith(
          OrderEntity value, $Res Function(OrderEntity) then) =
      _$OrderEntityCopyWithImpl<$Res, OrderEntity>;
  @useResult
  $Res call(
      {String id,
      String customerId,
      String customerName,
      List<OrderItemEntity> items,
      double totalAmount,
      OrderStatus status,
      PaymentStatus paymentStatus,
      String? notes,
      String? createdById,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? deliveredAt});
}

/// @nodoc
class _$OrderEntityCopyWithImpl<$Res, $Val extends OrderEntity>
    implements $OrderEntityCopyWith<$Res> {
  _$OrderEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? items = null,
    Object? totalAmount = null,
    Object? status = null,
    Object? paymentStatus = null,
    Object? notes = freezed,
    Object? createdById = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deliveredAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderItemEntity>,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdById: freezed == createdById
          ? _value.createdById
          : createdById // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderEntityImplCopyWith<$Res>
    implements $OrderEntityCopyWith<$Res> {
  factory _$$OrderEntityImplCopyWith(
          _$OrderEntityImpl value, $Res Function(_$OrderEntityImpl) then) =
      __$$OrderEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String customerId,
      String customerName,
      List<OrderItemEntity> items,
      double totalAmount,
      OrderStatus status,
      PaymentStatus paymentStatus,
      String? notes,
      String? createdById,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? deliveredAt});
}

/// @nodoc
class __$$OrderEntityImplCopyWithImpl<$Res>
    extends _$OrderEntityCopyWithImpl<$Res, _$OrderEntityImpl>
    implements _$$OrderEntityImplCopyWith<$Res> {
  __$$OrderEntityImplCopyWithImpl(
      _$OrderEntityImpl _value, $Res Function(_$OrderEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? items = null,
    Object? totalAmount = null,
    Object? status = null,
    Object? paymentStatus = null,
    Object? notes = freezed,
    Object? createdById = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deliveredAt = freezed,
  }) {
    return _then(_$OrderEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderItemEntity>,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdById: freezed == createdById
          ? _value.createdById
          : createdById // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$OrderEntityImpl extends _OrderEntity {
  const _$OrderEntityImpl(
      {required this.id,
      required this.customerId,
      required this.customerName,
      required final List<OrderItemEntity> items,
      required this.totalAmount,
      this.status = OrderStatus.pending,
      this.paymentStatus = PaymentStatus.unpaid,
      this.notes,
      this.createdById,
      this.createdAt,
      this.updatedAt,
      this.deliveredAt})
      : _items = items,
        super._();

  @override
  final String id;
  @override
  final String customerId;
  @override
  final String customerName;
  final List<OrderItemEntity> _items;
  @override
  List<OrderItemEntity> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final double totalAmount;
  @override
  @JsonKey()
  final OrderStatus status;
  @override
  @JsonKey()
  final PaymentStatus paymentStatus;
  @override
  final String? notes;
  @override
  final String? createdById;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? deliveredAt;

  @override
  String toString() {
    return 'OrderEntity(id: $id, customerId: $customerId, customerName: $customerName, items: $items, totalAmount: $totalAmount, status: $status, paymentStatus: $paymentStatus, notes: $notes, createdById: $createdById, createdAt: $createdAt, updatedAt: $updatedAt, deliveredAt: $deliveredAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdById, createdById) ||
                other.createdById == createdById) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      customerId,
      customerName,
      const DeepCollectionEquality().hash(_items),
      totalAmount,
      status,
      paymentStatus,
      notes,
      createdById,
      createdAt,
      updatedAt,
      deliveredAt);

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderEntityImplCopyWith<_$OrderEntityImpl> get copyWith =>
      __$$OrderEntityImplCopyWithImpl<_$OrderEntityImpl>(this, _$identity);
}

abstract class _OrderEntity extends OrderEntity {
  const factory _OrderEntity(
      {required final String id,
      required final String customerId,
      required final String customerName,
      required final List<OrderItemEntity> items,
      required final double totalAmount,
      final OrderStatus status,
      final PaymentStatus paymentStatus,
      final String? notes,
      final String? createdById,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final DateTime? deliveredAt}) = _$OrderEntityImpl;
  const _OrderEntity._() : super._();

  @override
  String get id;
  @override
  String get customerId;
  @override
  String get customerName;
  @override
  List<OrderItemEntity> get items;
  @override
  double get totalAmount;
  @override
  OrderStatus get status;
  @override
  PaymentStatus get paymentStatus;
  @override
  String? get notes;
  @override
  String? get createdById;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get deliveredAt;

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderEntityImplCopyWith<_$OrderEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
