import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(String id);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/products.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    final products = await getProducts();
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      throw Exception('Product not found: $e');
    }
  }
}

