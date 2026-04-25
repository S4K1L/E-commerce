import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../config/app_text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <Map<String, dynamic>>[
      {
        'icon': Icons.person_outline,
        'label': 'Your profile',
        'route': Routes.editProfile
      },
      {
        'icon': Icons.location_on_outlined,
        'label': 'Manage Address',
        'route': Routes.manageAddresses
      },
      {
        'icon': Icons.credit_card_outlined,
        'label': 'Payment Methods',
        'route': Routes.paymentMethodsProfile
      },
      {
        'icon': Icons.shopping_bag_outlined,
        'label': 'My Orders',
        'route': Routes.myOrders
      },
      {
        'icon': Icons.local_offer_outlined,
        'label': 'My Coupons',
        'route': Routes.myCoupons
      },
      {
        'icon': Icons.account_balance_wallet_outlined,
        'label': 'My Wallet',
        'route': Routes.myWallet
      },
      {
        'icon': Icons.settings_outlined,
        'label': 'Settings',
        'route': Routes.settings
      },
      {
        'icon': Icons.help_outline,
        'label': 'Help Center',
        'route': Routes.helpCenter
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile', style: AppTextStyles.title),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 8),
          Center(
            child: Stack(
              children: [
                Container(
                  width: 86,
                  height: 86,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: AppColors.primary, width: 2),
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://images.unsplash.com/photo-1607746882042-944635dfe10e?w=200&q=80',
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) =>
                          Container(color: AppColors.surface),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle),
                    child: const Icon(Icons.edit,
                        color: Colors.white, size: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text('Esther Howard',
                style: AppTextStyles.h3
                    .copyWith(fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 24),
          ...items.map((it) => _row(it['icon'] as IconData,
              it['label'] as String, it['route'] as String)),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _row(IconData icon, String label, String route) {
    return InkWell(
      onTap: () => Get.toNamed<void>(route),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
                child: Text(label,
                    style: AppTextStyles.subtitle
                        .copyWith(fontWeight: FontWeight.w500))),
            const Icon(Icons.arrow_forward_ios,
                size: 14, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
