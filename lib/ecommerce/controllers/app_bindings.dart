import 'package:get/get.dart';

import 'cart_controller.dart';
import 'nav_controller.dart';
import 'wishlist_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NavController(), permanent: true);
    Get.put(CartController(), permanent: true);
    Get.put(WishlistController(), permanent: true);
  }
}
