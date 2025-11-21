import '../../domain/entities/product.dart';
import '../../domain/repositories/catalog_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../models/product_model.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  final ProductLocalDataSource localDataSource;
  List<ProductModel>? _cachedProducts;
  DateTime? _cacheTimestamp;
  static const _cacheDuration = Duration(minutes: 5);

  CatalogRepositoryImpl(this.localDataSource);

  @override
  Future<List<Product>> fetchProducts() async {
    if (_cachedProducts != null &&
        _cacheTimestamp != null &&
        DateTime.now().difference(_cacheTimestamp!) < _cacheDuration) {
      return _cachedProducts!;
    }

    final products = await localDataSource.getProducts();
    _cachedProducts = products;
    _cacheTimestamp = DateTime.now();
    return products;
  }

  @override
  Future<Product> fetchProduct(String id) async {
    if (_cachedProducts != null) {
      try {
        return _cachedProducts!.firstWhere((p) => p.id == id);
      } catch (_) {}
    }
    return await localDataSource.getProductById(id);
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    final products = await fetchProducts();
    final lowerQuery = query.toLowerCase();
    return products.where((product) {
      return product.title.toLowerCase().contains(lowerQuery) ||
          product.description.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  Future<List<Product>> filterProductsByCategory(String category) async {
    final products = await fetchProducts();
    return products.where((product) => product.category == category).toList();
  }
}

