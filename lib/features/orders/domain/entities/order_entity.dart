import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_entity.freezed.dart';

enum OrderStatus { pending, confirmed, processing, shipped, delivered, cancelled }

enum PaymentStatus { unpaid, partial, paid, refunded }

@freezed
class OrderItemEntity with _$OrderItemEntity {
  const factory OrderItemEntity({
    required String productId,
    required String productName,
    required double unitPrice,
    required int quantity,
    String? productImageUrl,
    @Default(0) double discount,
  }) = _OrderItemEntity;

  const OrderItemEntity._();

  double get subtotal => (unitPrice * quantity) - discount;
}

@freezed
class OrderEntity with _$OrderEntity {
  const factory OrderEntity({
    required String id,
    required String customerId,
    required String customerName,
    required List<OrderItemEntity> items,
    required double totalAmount,
    @Default(OrderStatus.pending) OrderStatus status,
    @Default(PaymentStatus.unpaid) PaymentStatus paymentStatus,
    String? notes,
    String? createdById,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deliveredAt,
  }) = _OrderEntity;

  const OrderEntity._();

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => items.fold(0, (sum, item) => sum + item.subtotal);

  bool get isPaid => paymentStatus == PaymentStatus.paid;
  bool get isCancelled => status == OrderStatus.cancelled;
  bool get isDelivered => status == OrderStatus.delivered;

  String get statusLabel {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}
