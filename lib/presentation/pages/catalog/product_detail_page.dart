import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/utils/dependency_injection.dart';
import '../../../domain/repositories/catalog_repository.dart';
import '../../viewmodels/cart_viewmodel.dart';
import '../../widgets/product_image_carousel.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _isLoading = true;
  dynamic _product;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    try {
      final repository = getIt<CatalogRepository>();
      final product = await repository.fetchProduct(widget.productId);
      setState(() {
        _product = product;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _addToCart() {
    if (_product != null) {
      context.read<CartViewModel>().addProduct(_product);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produit ajouté au panier')),
      );
    }
  }

  Future<void> _shareProduct() async {
    if (_product == null) return;
    if (kIsWeb || defaultTargetPlatform == TargetPlatform.android) {
      await Share.share(
        'Découvrez ${_product.title} pour ${_product.price}€ sur ShopFlutter!',
      );
    }
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Erreur: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadProduct,
              child: const Text('Réessayer'),
            ),
          ],
        ),
      );
    }

    if (_product == null) return const SizedBox();

    // iOS specific: Use CupertinoPageScaffold
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(_product.title),
          leading: CupertinoNavigationBarBackButton(
            onPressed: () => context.pop(),
          ),
        ),
        child: SafeArea(
          child: _buildProductContent(),
        ),
      );
    }

    // Android/Web: Use Material Scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text(_product.title),
        actions: [
          if (kIsWeb || defaultTargetPlatform == TargetPlatform.android)
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: _shareProduct,
            ),
        ],
      ),
      body: _buildProductContent(),
    );
  }

  Widget _buildProductContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImageCarousel(images: _product.images),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _product.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_product.price.toStringAsFixed(2)} €',
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Chip(
                  label: Text(_product.category),
                  backgroundColor: Colors.blue.shade100,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _product.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _addToCart,
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Ajouter au panier'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }
}

