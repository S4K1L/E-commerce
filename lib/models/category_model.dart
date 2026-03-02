import 'package:bdm/models/product_model.dart';

class CategoryModel{
  final int categoryId;
  final String categoryName;
  final String? description;
  final DateTime? createdOn;
  final DateTime? updatedOn;
  final List<ProductModel>? products;

  const CategoryModel({
    required this.categoryId,
    required this.categoryName,
    this.description,
    this.createdOn,
    this.updatedOn,
    this.products,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      description: json['description'],
      createdOn: json['created_on'] != null ? DateTime.parse(json['created_on']) : null,
      updatedOn: json['updated_on'] != null ? DateTime.parse(json['updated_on']) : null,
      products: json['products'] != null
          ? List<ProductModel>.from(
              json['products'].map((item) => ProductModel.fromJson(item)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'category_name': categoryName,
      'description': description,
      'created_on': createdOn?.toIso8601String(),
      'updated_on': updatedOn?.toIso8601String(),
      'products': products?.map((e) => e.toJson()).toList(),
    };
  }

  CategoryModel copyWith({
    int? categoryId,
    String? categoryName,
    String? description,
    DateTime? createdOn,
    DateTime? updatedOn,
    List<ProductModel>? products,
  }) {
    return CategoryModel(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      description: description ?? this.description,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
      products: products ?? this.products,
    );
  }
}
