import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/order.dart' as domain;
import '../../domain/entities/product.dart';
import '../../data/models/product_model.dart';

class OrderViewModel extends ChangeNotifier {
  final firestore.FirebaseFirestore _firestore = firestore.FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<domain.Order> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<domain.Order> get orders => List.unmodifiable(_orders);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadOrders() async {
    final user = _auth.currentUser;
    if (user == null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final snapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: user.uid)
          .orderBy('createdAt', descending: true)
          .get();

      _orders = snapshot.docs.map((doc) {
        final data = doc.data();
        return domain.Order(
          id: doc.id,
          createdAt: (data['createdAt'] as firestore.Timestamp).toDate(),
          items: (data['items'] as List)
              .map((item) => CartItem(
                    product: _productFromMap(item['product']),
                    quantity: item['quantity'] as int,
                  ))
              .toList(),
          total: (data['total'] as num).toDouble(),
          shippingAddress: data['shippingAddress'] as String,
          status: data['status'] as String? ?? 'pending',
        );
      }).toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erreur lors du chargement des commandes: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> createOrder(
    List<CartItem> items,
    double total,
    String shippingAddress,
  ) async {
    final user = _auth.currentUser;
    if (user == null) return null;

    _isLoading = true;
    notifyListeners();

    try {
      final orderData = {
        'userId': user.uid,
        'createdAt': firestore.FieldValue.serverTimestamp(),
        'items': items.map((item) => {
              'product': _productToMap(item.product),
              'quantity': item.quantity,
            }).toList(),
        'total': total,
        'shippingAddress': shippingAddress,
        'status': 'pending',
      };

      final docRef = await _firestore.collection('orders').add(orderData);
      await loadOrders();
      return docRef.id;
    } catch (e) {
      _errorMessage = 'Erreur lors de la création de la commande: $e';
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  dynamic _productToMap(dynamic product) {
    return {
      'id': product.id,
      'title': product.title,
      'price': product.price,
      'thumbnail': product.thumbnail,
      'images': product.images,
      'description': product.description,
      'category': product.category,
    };
  }

  Product _productFromMap(Map<String, dynamic> map) {
    // Create ProductModel from map for orders
    return ProductModel(
      id: map['id'] as String,
      title: map['title'] as String,
      price: (map['price'] as num).toDouble(),
      thumbnail: map['thumbnail'] as String,
      images: List<String>.from(map['images'] as List),
      description: map['description'] as String,
      category: map['category'] as String,
    );
  }
}

