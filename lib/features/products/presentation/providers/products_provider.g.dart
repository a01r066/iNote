// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsHash() => r'5b32e3f1b48b09194ca2349b222163184e9c7bc6';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [products].
@ProviderFor(products)
const productsProvider = ProductsFamily();

/// See also [products].
class ProductsFamily extends Family<AsyncValue<List<ProductEntity>>> {
  /// See also [products].
  const ProductsFamily();

  /// See also [products].
  ProductsProvider call({
    String? categoryId,
    String? searchQuery,
  }) {
    return ProductsProvider(
      categoryId: categoryId,
      searchQuery: searchQuery,
    );
  }

  @override
  ProductsProvider getProviderOverride(
    covariant ProductsProvider provider,
  ) {
    return call(
      categoryId: provider.categoryId,
      searchQuery: provider.searchQuery,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productsProvider';
}

/// See also [products].
class ProductsProvider extends AutoDisposeFutureProvider<List<ProductEntity>> {
  /// See also [products].
  ProductsProvider({
    String? categoryId,
    String? searchQuery,
  }) : this._internal(
          (ref) => products(
            ref as ProductsRef,
            categoryId: categoryId,
            searchQuery: searchQuery,
          ),
          from: productsProvider,
          name: r'productsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productsHash,
          dependencies: ProductsFamily._dependencies,
          allTransitiveDependencies: ProductsFamily._allTransitiveDependencies,
          categoryId: categoryId,
          searchQuery: searchQuery,
        );

  ProductsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
    required this.searchQuery,
  }) : super.internal();

  final String? categoryId;
  final String? searchQuery;

  @override
  Override overrideWith(
    FutureOr<List<ProductEntity>> Function(ProductsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductsProvider._internal(
        (ref) => create(ref as ProductsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
        searchQuery: searchQuery,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ProductEntity>> createElement() {
    return _ProductsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsProvider &&
        other.categoryId == categoryId &&
        other.searchQuery == searchQuery;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);
    hash = _SystemHash.combine(hash, searchQuery.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductsRef on AutoDisposeFutureProviderRef<List<ProductEntity>> {
  /// The parameter `categoryId` of this provider.
  String? get categoryId;

  /// The parameter `searchQuery` of this provider.
  String? get searchQuery;
}

class _ProductsProviderElement
    extends AutoDisposeFutureProviderElement<List<ProductEntity>>
    with ProductsRef {
  _ProductsProviderElement(super.provider);

  @override
  String? get categoryId => (origin as ProductsProvider).categoryId;
  @override
  String? get searchQuery => (origin as ProductsProvider).searchQuery;
}

String _$productsSearchNotifierHash() =>
    r'9767dd17f200e5c8e85f31efc2c20614d14651fe';

/// See also [ProductsSearchNotifier].
@ProviderFor(ProductsSearchNotifier)
final productsSearchNotifierProvider =
    AutoDisposeNotifierProvider<ProductsSearchNotifier, String>.internal(
  ProductsSearchNotifier.new,
  name: r'productsSearchNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsSearchNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProductsSearchNotifier = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
