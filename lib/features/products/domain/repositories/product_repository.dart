import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    String? categoryId,
    ProductStatus? status,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  });

  Future<Either<Failure, ProductEntity>> getProductById(String id);

  Future<Either<Failure, ProductEntity>> createProduct(ProductEntity product);

  Future<Either<Failure, ProductEntity>> updateProduct(ProductEntity product);

  Future<Either<Failure, Unit>> deleteProduct(String id);

  Stream<List<ProductEntity>> watchProducts();
}
