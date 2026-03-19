class OrderModel {
  final int orderId;
  final String invoiceNumber;
  final int userId;
  final double totalAmount;
  final double deliveryCharge;
  final double specialBonus;
  final double specialBonusPercentage;
  final double finalAmount;
  final double totalReturnAmount;
  final String shippingAddress;
  final String orderStatus;
  final DateTime orderDate;
  final List<OrderItem> items;
  final List<OrderItem> returnItems;

  OrderModel({
    required this.orderId,
    required this.invoiceNumber,
    required this.userId,
    required this.totalAmount,
    required this.deliveryCharge,
    required this.specialBonus,
    required this.specialBonusPercentage,
    required this.finalAmount,
    required this.totalReturnAmount,
    required this.shippingAddress,
    required this.orderStatus,
    required this.orderDate,
    required this.items,
    required this.returnItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['order_id'],
      invoiceNumber: json['invoice_number'],
      userId: json['user_id'],
      totalAmount: (json['total_amount'] as num).toDouble(),
      deliveryCharge: (json['delivery_charge'] as num).toDouble(),
      specialBonus: (json['special_bonus'] as num).toDouble(),
      specialBonusPercentage:
          (json['special_bonus_percentage'] as num).toDouble(),
      finalAmount: (json['final_amount'] as num).toDouble(),
      totalReturnAmount: (json['total_return_amount'] as num).toDouble(),
      shippingAddress: json['shipping_address'],
      orderStatus: json['order_status'],
      orderDate: DateTime.parse(json['order_date']),
      items: (json['items'] as List).map((e) => OrderItem.fromJson(e)).toList(),
      returnItems:
          (json['return_items'] as List)
              .map((e) => OrderItem.fromJson(e))
              .toList(),
    );
  }
}

class OrderItem {
  final int id;
  final int product;
  final String productName;
  final String? productImage; // nullable
  final String? companyName; // newly added, nullable
  final int quantity;
  final double mrp;
  final double sellingPrice;
  final double discountPercent;
  final double? discount; // nullable in return item
  final double? itemsTotal; // nullable in return item
  final String? reason; // only in return item
  final DateTime createdOn;
  final DateTime updatedOn;
  final double? totalReturn; // only in return item

  OrderItem({
    required this.id,
    required this.product,
    required this.productName,
    this.productImage,
    this.companyName,
    required this.quantity,
    required this.mrp,
    required this.sellingPrice,
    required this.discountPercent,
    this.discount,
    this.itemsTotal,
    this.reason,
    required this.createdOn,
    required this.updatedOn,
    this.totalReturn,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      product: json['product'],
      productName: json['product_name'],
      productImage: json['product_image'],
      companyName: json['company_name'],
      quantity: json['quantity'],
      mrp: (json['mrp'] as num).toDouble(),
      sellingPrice: (json['selling_price'] as num).toDouble(),
      discountPercent: (json['discount_percent'] as num).toDouble(),
      discount:
          (json['discount'] != null)
              ? (json['discount'] as num).toDouble()
              : null,
      itemsTotal:
          (json['items_total'] != null)
              ? (json['items_total'] as num).toDouble()
              : null,
      reason: json['reason'],
      createdOn: DateTime.parse(json['created_on']),
      updatedOn: DateTime.parse(json['updated_on']),
      totalReturn:
          (json['total_return'] != null)
              ? (json['total_return'] as num).toDouble()
              : null,
    );
  }
}
