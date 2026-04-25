import 'product.dart';

class CartItem {
  final ProductModel product;
  int quantity;
  final String? selectedSize;
  final String? selectedColor;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedSize,
    this.selectedColor,
  });

  double get total => product.price * quantity;
}
