import 'package:inote_app/core/errors/failures.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/product_entity.dart';
import '../../data/repositories/product_repository_impl.dart';

part 'products_provider.g.dart';

@riverpod
Future<List<ProductEntity>> products(
  ProductsRef ref, {
  String? categoryId,
  String? searchQuery,
}) async {
  final repository = ref.watch(productRepositoryProvider);
  final result = await repository.getProducts(
    categoryId: categoryId,
    searchQuery: searchQuery,
  );
  return result.fold(
    (failure) => throw Exception(failure.userMessage),
    (products) => products,
  );
}

@riverpod
class ProductsSearchNotifier extends _$ProductsSearchNotifier {
  @override
  String build() => '';

  void search(String query) => state = query;
  void clear() => state = '';
}
