class ProductModel {
  final int productId;
  final String productName;
  final String genericName;
  final String productDescription;
  final String productImage;
  final String sku;
  final int companyId;
  final String companyName;
  final List<int> categoryId;
  final List<String> categoryName;
  final int stockQuantity;
  final int quantityPerBox;
  final num discountPercent;
  final num costPrice;
  final num mrp;
  final bool outOfStock;
  final bool isActive;
  final DateTime createdOn;
  final DateTime updatedOn;
  final num sellingPrice;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.genericName,
    required this.productDescription,
    required this.productImage,
    required this.sku,
    required this.companyId,
    required this.companyName,
    required this.categoryId,
    required this.categoryName,
    required this.stockQuantity,
    required this.quantityPerBox,
    required this.discountPercent,
    required this.costPrice,
    required this.mrp,
    required this.outOfStock,
    required this.isActive,
    required this.createdOn,
    required this.updatedOn,
    required this.sellingPrice,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductModel && other.productId == productId;
  }

  @override
  int get hashCode => productId.hashCode;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['product_id'],
      productName: json['product_name'],
      genericName: json['generic_name']?.toString() ?? '',
      productDescription: json['product_description'],
      productImage: json['product_image'],
      sku: json['sku'],
      companyId: json['company_id'],
      companyName: json['company_name'],
      categoryId: List<int>.from(json['category_id']),
      categoryName: List<String>.from(json['category_name']),
      stockQuantity: json['stock_quantity'],
      quantityPerBox: json['quantity_per_box'],
      discountPercent: json['discount_percent'],
      costPrice:
          json['cost_price'] is String
              ? num.tryParse(json['cost_price']) ?? 0
              : (json['cost_price'] as num? ?? 0),
      mrp: 
          json['mrp'] is String
              ? num.tryParse(json['mrp']) ?? 0
              : (json['mrp'] as num? ?? 0),
      outOfStock: json['out_of_stock'],
      isActive: json['is_active'],
      createdOn: DateTime.parse(json['created_on']),
      updatedOn: DateTime.parse(json['updated_on']),
      sellingPrice:
          json['selling_price'] is String
              ? num.tryParse(json['selling_price']) ?? 0
              : (json['selling_price'] as num? ?? 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'generic_name': genericName,
      'product_description': productDescription,
      'product_image': productImage,
      'sku': sku,
      'company_id': companyId,
      'company_name': companyName,
      'category_id': categoryId,
      'category_name': categoryName,
      'stock_quantity': stockQuantity,
      'quantity_per_box': quantityPerBox,
      'discount_percent': discountPercent,
      'cost_price': costPrice.toStringAsFixed(2),
      'mrp': mrp.toStringAsFixed(2),
      'out_of_stock': outOfStock,
      'is_active': isActive,
      'created_on': createdOn.toIso8601String(),
      'updated_on': updatedOn.toIso8601String(),
      'selling_price': sellingPrice,
    };
  }
}
