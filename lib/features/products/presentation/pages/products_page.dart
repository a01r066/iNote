import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/helpers/currency_formatter.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../domain/entities/product_entity.dart';
import '../providers/products_provider.dart';

class ProductsPage extends HookConsumerWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchQuery = ref.watch(productsSearchNotifierProvider);
    final productsAsync = ref.watch(
      productsProvider(searchQuery: searchQuery.isEmpty ? null : searchQuery),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_outlined),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: Column(
        children: [
          // Search
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppTextField(
              controller: searchController,
              label: '',
              hint: 'Search products, SKU...',
              prefixIcon: Icons.search,
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        ref
                            .read(productsSearchNotifierProvider.notifier)
                            .clear();
                      },
                    )
                  : null,
              onChanged: (value) => ref
                  .read(productsSearchNotifierProvider.notifier)
                  .search(value),
            ),
          ),

          // Products List
          Expanded(
            child: productsAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(16),
                child: ShimmerList(itemCount: 6, itemHeight: 88),
              ),
              error: (error, _) => ErrorStateWidget(
                message: error.toString(),
                onRetry: () => ref.invalidate(productsProvider),
              ),
              data: (products) => products.isEmpty
                  ? EmptyStateWidget(
                      title: 'No products found',
                      subtitle: searchQuery.isNotEmpty
                          ? 'Try a different search term'
                          : 'Add your first product to get started',
                      icon: Icons.inventory_2_outlined,
                      action: searchQuery.isEmpty ? () {} : null,
                      actionLabel: 'Add Product',
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                      itemCount: products.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, i) => _ProductCard(product: products[i]),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final ProductEntity product;

  Color get _statusColor {
    if (product.isOutOfStock) return AppColors.error;
    if (product.isLowStock) return AppColors.warning;
    return AppColors.success;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.grey100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: product.imageUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(product.imageUrl!, fit: BoxFit.cover),
                )
              : const Icon(Icons.inventory_2_outlined, color: AppColors.grey400),
        ),
        title: Text(
          product.name,
          style: Theme.of(context).textTheme.titleSmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              product.sku.isNotEmpty ? 'SKU: ${product.sku}' : 'No SKU',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '${product.stock} in stock',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: _statusColor),
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              CurrencyFormatter.format(product.price),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 4),
            const Icon(Icons.chevron_right, color: AppColors.grey300, size: 20),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
