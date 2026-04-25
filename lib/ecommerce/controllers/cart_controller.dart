import 'package:get/get.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

class CartController extends GetxController {
  final RxList<CartItem> items = <CartItem>[].obs;
  final RxString promoCode = ''.obs;
  final RxDouble discount = 350.0.obs;
  final RxDouble deliveryFee = 100.0.obs;

  double get subTotal =>
      items.fold(0.0, (sum, item) => sum + item.product.price * item.quantity);

  double get total => (subTotal + deliveryFee.value - discount.value)
      .clamp(0, double.infinity);

  int get itemCount => items.fold(0, (sum, i) => sum + i.quantity);

  void addToCart(ProductModel product,
      {String? size, String? color, int qty = 1}) {
    final existing = items.indexWhere((i) =>
        i.product.id == product.id &&
        i.selectedSize == size &&
        i.selectedColor == color);
    if (existing >= 0) {
      items[existing].quantity += qty;
      items.refresh();
    } else {
      items.add(CartItem(
        product: product,
        quantity: qty,
        selectedSize: size,
        selectedColor: color,
      ));
    }
  }

  void increment(int index) {
    items[index].quantity += 1;
    items.refresh();
  }

  void decrement(int index) {
    if (items[index].quantity > 1) {
      items[index].quantity -= 1;
      items.refresh();
    }
  }

  void remove(int index) {
    items.removeAt(index);
  }

  void applyPromo(String code) {
    promoCode.value = code;
    if (code.toUpperCase() == 'SAVE10') {
      discount.value = subTotal * 0.10;
    } else if (code.toUpperCase() == 'WELCOME') {
      discount.value = 350.0;
    }
  }

  void clear() {
    items.clear();
    promoCode.value = '';
  }
}
