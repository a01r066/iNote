import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/helpers/currency_formatter.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../domain/entities/order_entity.dart';

class OrdersPage extends ConsumerWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Orders'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Pending'),
              Tab(text: 'Processing'),
              Tab(text: 'Delivered'),
              Tab(text: 'Cancelled'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('New Order'),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
        ),
        body: const TabBarView(
          children: [
            _OrdersList(status: null),
            _OrdersList(status: OrderStatus.pending),
            _OrdersList(status: OrderStatus.processing),
            _OrdersList(status: OrderStatus.delivered),
            _OrdersList(status: OrderStatus.cancelled),
          ],
        ),
      ),
    );
  }
}

class _OrdersList extends StatelessWidget {
  const _OrdersList({this.status});

  final OrderStatus? status;

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual provider
    return const EmptyStateWidget(
      title: 'No orders yet',
      subtitle: 'Create your first order to get started',
      icon: Icons.receipt_long_outlined,
    );
  }
}

class OrderStatusBadge extends StatelessWidget {
  const OrderStatusBadge({super.key, required this.status});

  final OrderStatus status;

  Color get _color {
    switch (status) {
      case OrderStatus.pending:
        return AppColors.warning;
      case OrderStatus.confirmed:
        return AppColors.info;
      case OrderStatus.processing:
        return AppColors.primary;
      case OrderStatus.shipped:
        return AppColors.secondary;
      case OrderStatus.delivered:
        return AppColors.success;
      case OrderStatus.cancelled:
        return AppColors.error;
    }
  }

  String get _label {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: _color),
      ),
    );
  }
}
