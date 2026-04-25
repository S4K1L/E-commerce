import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../config/app_text_styles.dart';
import '../../controllers/cart_controller.dart';
import '../../utils/currency.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/primary_button.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: AppBackButton(),
        ),
        title: Text('Checkout', style: AppTextStyles.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text('Shipping Address',
                      style: AppTextStyles.subtitle
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  _editableTile(
                    icon: Icons.location_on_outlined,
                    title: 'Home',
                    subtitle:
                        'House 12, Road 7, Dhanmondi, Dhaka 1209',
                    actionLabel: 'CHANGE',
                    onAction: () =>
                        Get.toNamed<void>(Routes.shippingAddress),
                  ),
                  const SizedBox(height: 20),
                  Text('Choose Shipping Type',
                      style: AppTextStyles.subtitle
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  _editableTile(
                    icon: Icons.local_shipping_outlined,
                    title: 'Economy',
                    subtitle: 'Estimated Arrival 25 September 2026',
                    actionLabel: 'CHANGE',
                    onAction: () =>
                        Get.toNamed<void>(Routes.chooseShipping),
                  ),
                  const SizedBox(height: 20),
                  Text('Order List',
                      style: AppTextStyles.subtitle
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Obx(() => Column(
                        children: cart.items.map((item) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(10),
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CachedNetworkImage(
                                      imageUrl: item.product.image,
                                      fit: BoxFit.cover,
                                      errorWidget: (_, __, ___) =>
                                          Container(
                                              color:
                                                  AppColors.surface),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(item.product.name,
                                          style: AppTextStyles
                                              .subtitle
                                              .copyWith(
                                                  fontWeight:
                                                      FontWeight.w600)),
                                      Text(item.product.category,
                                          style: AppTextStyles.caption
                                              .copyWith(
                                                  color: AppColors
                                                      .textSecondary)),
                                      Text(
                                          Currency.format(
                                              item.product.price),
                                          style: AppTextStyles
                                              .subtitle
                                              .copyWith(
                                                  color: AppColors
                                                      .primary,
                                                  fontWeight:
                                                      FontWeight.w700)),
                                    ],
                                  ),
                                ),
                                Text('x${item.quantity}',
                                    style: AppTextStyles.subtitle
                                        .copyWith(
                                            color: AppColors
                                                .textSecondary)),
                              ],
                            ),
                          );
                        }).toList(),
                      )),
                ],
              ),
            ),
            PrimaryButton(
              label: 'Continue to Payment',
              onPressed: () =>
                  Get.toNamed<void>(Routes.paymentMethods),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _editableTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionLabel,
    required VoidCallback onAction,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppTextStyles.subtitle
                        .copyWith(fontWeight: FontWeight.w600)),
                Text(subtitle,
                    style: AppTextStyles.caption
                        .copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
          TextButton(
            onPressed: onAction,
            child: Text(actionLabel,
                style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
