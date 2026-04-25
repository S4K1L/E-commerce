class ProductModel {
  final String id;
  final String name;
  final String category;
  final String image;
  final List<String> gallery;
  final double price;
  final double? oldPrice;
  final double rating;
  final int reviewCount;
  final String description;
  final List<String> sizes;
  final List<String> colors;
  final String sellerName;
  final String sellerRole;
  final String sellerAvatar;
  final bool isPopular;
  final bool isFeatured;

  const ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    this.gallery = const [],
    required this.price,
    this.oldPrice,
    this.rating = 4.5,
    this.reviewCount = 0,
    this.description = '',
    this.sizes = const [],
    this.colors = const [],
    this.sellerName = '',
    this.sellerRole = '',
    this.sellerAvatar = '',
    this.isPopular = false,
    this.isFeatured = false,
  });
}
