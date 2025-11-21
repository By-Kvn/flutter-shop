import 'cart_item.dart';

class Order {
  final String id;
  final DateTime createdAt;
  final List<CartItem> items;
  final double total;
  final String shippingAddress;
  final String status;

  Order({
    required this.id,
    required this.createdAt,
    required this.items,
    required this.total,
    required this.shippingAddress,
    this.status = 'pending',
  });
}

