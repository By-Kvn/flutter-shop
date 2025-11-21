import 'package:flutter/foundation.dart';
import '../../../core/utils/dependency_injection.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/catalog_repository.dart';

class CatalogViewModel extends ChangeNotifier {
  final CatalogRepository _catalogRepository = getIt<CatalogRepository>();

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';
  String? _selectedCategory;

  List<Product> get products => _filteredProducts.isEmpty && _searchQuery.isEmpty && _selectedCategory == null
      ? _products
      : _filteredProducts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<String> get categories => _products.map((p) => p.category).toSet().toList();
  String? get selectedCategory => _selectedCategory;

  Future<void> loadProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await _catalogRepository.fetchProducts();
      _filteredProducts = _products;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erreur lors du chargement des produits: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchProducts(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void filterByCategory(String? category) {
    _selectedCategory = category;
    _applyFilters();
  }

  void _applyFilters() async {
    _isLoading = true;
    notifyListeners();

    try {
      List<Product> result = _products;

      if (_searchQuery.isNotEmpty) {
        result = await _catalogRepository.searchProducts(_searchQuery);
      }

      if (_selectedCategory != null) {
        result = result.where((p) => p.category == _selectedCategory).toList();
      }

      _filteredProducts = result;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erreur lors du filtrage: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = null;
    _filteredProducts = _products;
    notifyListeners();
  }
}

