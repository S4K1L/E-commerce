import 'package:get/get.dart';

import '../models/product.dart';

class WishlistController extends GetxController {
  final RxList<ProductModel> items = <ProductModel>[].obs;

  bool isFavorite(String id) => items.any((p) => p.id == id);

  void toggle(ProductModel product) {
    if (isFavorite(product.id)) {
      items.removeWhere((p) => p.id == product.id);
    } else {
      items.add(product);
    }
  }

  List<ProductModel> byCategory(String category) {
    if (category.toLowerCase() == 'all') return items.toList();
    return items
        .where((p) => p.category.toLowerCase() == category.toLowerCase())
        .toList();
  }
}
