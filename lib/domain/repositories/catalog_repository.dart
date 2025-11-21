import '../entities/product.dart';

abstract class CatalogRepository {
  Future<List<Product>> fetchProducts();
  Future<Product> fetchProduct(String id);
  Future<List<Product>> searchProducts(String query);
  Future<List<Product>> filterProductsByCategory(String category);
}

