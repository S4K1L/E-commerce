import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../config/app_text_styles.dart';
import '../../controllers/cart_controller.dart';
import '../../data/sample_data.dart';
import '../../models/cart_item.dart';
import '../../utils/currency.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/quantity_selector.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _promo = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cart = Get.find<CartController>();
    if (cart.items.isEmpty) {
      cart.addToCart(SampleData.products[0]);
      cart.addToCart(SampleData.products[1]);
      cart.addToCart(SampleData.products[2]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Cart', style: AppTextStyles.title),
        centerTitle: true,
      ),
      body: Obx(() {
        if (cart.items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_bag_outlined,
                    size: 64, color: AppColors.textHint),
                const SizedBox(height: 12),
                Text('Your cart is empty',
                    style: AppTextStyles.body
                        .copyWith(color: AppColors.textSecondary)),
              ],
            ),
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                itemCount: cart.items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  return Dismissible(
                    key: ValueKey(cart.items[i].product.id +
                        (cart.items[i].selectedSize ?? '') +
                        i.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 24),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.delete_outline,
                          color: AppColors.primary),
                    ),
                    confirmDismiss: (_) async {
                      return await _confirmRemove(cart.items[i]) ?? false;
                    },
                    onDismissed: (_) => cart.remove(i),
                    child: _cartItem(cart, i),
                  );
                },
              ),
            ),
            _summary(cart),
          ],
        );
      }),
    );
  }

  Widget _cartItem(CartController cart, int i) {
    final CartItem item = cart.items[i];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 64,
              height: 64,
              child: CachedNetworkImage(
                imageUrl: item.product.image,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    Container(color: AppColors.surface),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name,
                    style: AppTextStyles.subtitle
                        .copyWith(fontWeight: FontWeight.w600)),
                Text(item.product.category,
                    style: AppTextStyles.caption
                        .copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                Text(Currency.format(item.product.price),
                    style: AppTextStyles.subtitle.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          QuantitySelector(
            quantity: item.quantity,
            onIncrement: () => cart.increment(i),
            onDecrement: () => cart.decrement(i),
          ),
        ],
      ),
    );
  }

  Future<bool?> _confirmRemove(CartItem item) {
    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 16),
            Text('Remove from Cart?',
                style: AppTextStyles.h3
                    .copyWith(fontWeight: FontWeight.w700)),
            const Divider(height: 28, color: AppColors.divider),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: CachedNetworkImage(
                        imageUrl: item.product.image,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) =>
                            Container(color: AppColors.surface),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.product.name,
                            style: AppTextStyles.subtitle.copyWith(
                                fontWeight: FontWeight.w600)),
                        Text(item.product.category,
                            style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary)),
                        Text(
                            Currency.format(item.product.price),
                            style: AppTextStyles.subtitle.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlineActionButton(
                    label: 'Cancel',
                    onPressed: () => Get.back<bool>(result: false),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                    label: 'Yes, Remove',
                    onPressed: () => Get.back<bool>(result: true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _summary(CartController cart) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, -2),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _promo,
                  decoration: const InputDecoration(
                    hintText: 'Promo Code',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  onPressed: () => cart.applyPromo(_promo.text.trim()),
                  child: const Text('Apply',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _row('Sub-Total', Currency.format(cart.subTotal)),
          _row('Delivery Fee', Currency.format(cart.deliveryFee.value)),
          _row('Discount',
              '- ${Currency.format(cart.discount.value)}',
              color: AppColors.primary),
          const Divider(),
          _row('Total Cost', Currency.format(cart.total), bold: true),
          const SizedBox(height: 12),
          PrimaryButton(
            label: 'Proceed to Checkout',
            onPressed: () =>
                Get.toNamed<void>(Routes.shippingAddress),
          ),
        ],
      ),
    );
  }

  Widget _row(String l, String r,
      {bool bold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(l,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: bold ? FontWeight.w600 : FontWeight.w500,
                )),
          ),
          Text(r,
              style: AppTextStyles.subtitle.copyWith(
                color: color ?? AppColors.textPrimary,
                fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
              )),
        ],
      ),
    );
  }
}
