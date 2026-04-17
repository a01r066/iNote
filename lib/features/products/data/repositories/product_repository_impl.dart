import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';

part 'product_repository_impl.g.dart';

@riverpod
ProductRepository productRepository(ProductRepositoryRef ref) {
  return ProductRepositoryImpl(FirebaseFirestore.instance);
}

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference get _collection =>
      _firestore.collection(ApiConstants.productsCollection);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    String? categoryId,
    ProductStatus? status,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      Query query = _collection.orderBy('name').limit(limit);

      if (categoryId != null) {
        query = query.where('categoryId', isEqualTo: categoryId);
      }
      if (status != null) {
        query = query.where('status', isEqualTo: status.name);
      }

      final snapshot = await query.get();
      var products = snapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc).toEntity())
          .toList();

      if (searchQuery != null && searchQuery.isNotEmpty) {
        final q = searchQuery.toLowerCase();
        products = products
            .where((p) =>
                p.name.toLowerCase().contains(q) ||
                p.sku.toLowerCase().contains(q))
            .toList();
      }

      return Right(products);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String id) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) {
        return const Left(Failure.notFound(message: 'Product not found'));
      }
      return Right(ProductModel.fromFirestore(doc).toEntity());
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> createProduct(
    ProductEntity product,
  ) async {
    try {
      final model = ProductModel.fromEntity(
        product.copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now()),
      );
      final ref = await _collection.add(model.toFirestore());
      return Right(product.copyWith(id: ref.id));
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(
    ProductEntity product,
  ) async {
    try {
      final model = ProductModel.fromEntity(
        product.copyWith(updatedAt: DateTime.now()),
      );
      await _collection.doc(product.id).update(model.toFirestore());
      return Right(product);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    try {
      await _collection.doc(id).delete();
      return const Right(unit);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Stream<List<ProductEntity>> watchProducts() {
    return _collection
        .where('status', isEqualTo: 'active')
        .orderBy('name')
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => ProductModel.fromFirestore(doc).toEntity())
            .toList());
  }
}
