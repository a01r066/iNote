import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/helpers/currency_formatter.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../domain/entities/customer_entity.dart';

class CustomersPage extends HookConsumerWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Customers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort_outlined),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.person_add_outlined),
        label: const Text('Add Customer'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppTextField(
              controller: searchController,
              label: '',
              hint: 'Search customers...',
              prefixIcon: Icons.search,
              onChanged: (_) {},
            ),
          ),
          const Expanded(
            child: EmptyStateWidget(
              title: 'No customers yet',
              subtitle: 'Add your first customer to start tracking relationships',
              icon: Icons.people_outline,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomerAvatar extends StatelessWidget {
  const CustomerAvatar({
    super.key,
    required this.customer,
    this.radius = 24,
  });

  final CustomerEntity customer;
  final double radius;

  @override
  Widget build(BuildContext context) {
    if (customer.photoUrl != null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(customer.photoUrl!),
      );
    }
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primary.withOpacity(0.15),
      child: Text(
        customer.initials,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: radius * 0.65,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
