import 'cart_item.dart';

enum OrderStatus { placed, inProgress, shipped, delivered, cancelled }

class OrderTimelineEntry {
  final OrderStatus status;
  final String label;
  final String date;
  final bool isActive;

  const OrderTimelineEntry({
    required this.status,
    required this.label,
    required this.date,
    this.isActive = false,
  });
}

class OrderModel {
  final String id;
  final List<CartItem> items;
  final double subTotal;
  final double deliveryFee;
  final double discount;
  final double total;
  final String estimatedDelivery;
  final OrderStatus currentStatus;
  final List<OrderTimelineEntry> timeline;
  final String sellerName;
  final String sellerAvatar;
  final String sellerRole;

  const OrderModel({
    required this.id,
    required this.items,
    required this.subTotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
    required this.estimatedDelivery,
    required this.currentStatus,
    required this.timeline,
    this.sellerName = '',
    this.sellerAvatar = '',
    this.sellerRole = '',
  });
}
