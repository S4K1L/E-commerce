import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import '../controllers/cart_controller.dart';
import '../controllers/nav_controller.dart';
import 'cart/cart_screen.dart';
import 'chat/chat_screen.dart';
import 'home/home_screen.dart';
import 'profile/profile_screen.dart';
import 'wishlist/wishlist_screen.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Get.find<NavController>();
    final cart = Get.find<CartController>();

    final pages = const [
      HomeScreen(),
      WishlistScreen(),
      CartScreen(),
      ChatScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => IndexedStack(
            index: nav.currentIndex.value,
            children: pages,
          )),
      bottomNavigationBar: Obx(() {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, -2),
              )
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navItem(nav, 0, Icons.home_outlined, Icons.home, 'Home'),
                  _navItem(nav, 1, Icons.favorite_border, Icons.favorite,
                      'Wishlist'),
                  _navItem(nav, 2, Icons.shopping_bag_outlined,
                      Icons.shopping_bag, 'Cart',
                      badge: cart.itemCount),
                  _navItem(nav, 3, Icons.chat_bubble_outline,
                      Icons.chat_bubble, 'Chat'),
                  _navItem(nav, 4, Icons.person_outline, Icons.person,
                      'Profile'),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _navItem(NavController nav, int index, IconData icon,
      IconData filled, String label,
      {int? badge}) {
    final selected = nav.currentIndex.value == index;
    return Expanded(
      child: InkWell(
        onTap: () => nav.changePage(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(selected ? filled : icon,
                      color: selected
                          ? AppColors.primary
                          : AppColors.textSecondary),
                  if (badge != null && badge > 0)
                    Positioned(
                      right: -8,
                      top: -4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        constraints:
                            const BoxConstraints(minWidth: 16, minHeight: 16),
                        alignment: Alignment.center,
                        child: Text(
                          badge.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(label,
                  style: AppTextStyles.caption.copyWith(
                      color: selected
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      fontWeight:
                          selected ? FontWeight.w600 : FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
