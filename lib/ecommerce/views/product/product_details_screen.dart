import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../config/app_text_styles.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/wishlist_controller.dart';
import '../../data/sample_data.dart';
import '../../models/product.dart';
import '../../utils/currency.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/primary_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? _selectedSize;
  String? _selectedColor;

  @override
  Widget build(BuildContext context) {
    final ProductModel product =
        (Get.arguments as ProductModel?) ?? SampleData.products.first;
    final wishlist = Get.find<WishlistController>();
    final cart = Get.find<CartController>();

    final colors =
        product.colors.isEmpty ? const ['Brown'] : product.colors;
    final sizes =
        product.sizes.isEmpty ? const ['S', 'M', 'L'] : product.sizes;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1.05,
                        child: CachedNetworkImage(
                          imageUrl: product.image,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) =>
                              Container(color: AppColors.surface),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        left: 16,
                        right: 16,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const AppBackButton(bgColor: Colors.white),
                            Obx(() {
                              final isFav =
                                  wishlist.isFavorite(product.id);
                              return GestureDetector(
                                onTap: () => wishlist.toggle(product),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.category,
                            style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Text(product.name,
                                  style: AppTextStyles.h3.copyWith(
                                      fontWeight: FontWeight.w700)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: AppColors.star, size: 14),
                                  const SizedBox(width: 4),
                                  Text(product.rating.toStringAsFixed(1),
                                      style: AppTextStyles.caption.copyWith(
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        _sellerCard(product),
                        const SizedBox(height: 20),
                        Text('Product Details',
                            style: AppTextStyles.subtitle
                                .copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Text(
                          product.description.isEmpty
                              ? 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                              : product.description,
                          style: AppTextStyles.body
                              .copyWith(color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 4),
                        Text('Read more',
                            style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 20),
                        if (sizes.isNotEmpty) ...[
                          Text('Select Size',
                              style: AppTextStyles.subtitle
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 10,
                            children: sizes
                                .map((s) => GestureDetector(
                                      onTap: () => setState(
                                          () => _selectedSize = s),
                                      child: Container(
                                        width: 44,
                                        height: 44,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: _selectedSize == s
                                              ? AppColors.primary
                                              : AppColors.surface,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          s,
                                          style: AppTextStyles.subtitle
                                              .copyWith(
                                            color: _selectedSize == s
                                                ? Colors.white
                                                : AppColors.textPrimary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(height: 20),
                        ],
                        Text('Select Color : ${_selectedColor ?? colors.first}',
                            style: AppTextStyles.subtitle
                                .copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          children: colors
                              .map((c) => GestureDetector(
                                    onTap: () => setState(
                                        () => _selectedColor = c),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 8),
                                      decoration: BoxDecoration(
                                        color:
                                            (_selectedColor ?? colors.first) ==
                                                    c
                                                ? AppColors.primary
                                                : AppColors.surface,
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        c,
                                        style: AppTextStyles.bodySmall
                                            .copyWith(
                                          color: (_selectedColor ??
                                                      colors.first) ==
                                                  c
                                              ? Colors.white
                                              : AppColors.textPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () => Get.toNamed<void>(Routes.reviews,
                              arguments: product),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.reviews_outlined,
                                    color: AppColors.primary),
                                const SizedBox(width: 12),
                                Expanded(
                                    child: Text('Reviews (${product.reviewCount})',
                                        style: AppTextStyles.subtitle)),
                                const Icon(Icons.arrow_forward_ios,
                                    color: AppColors.textSecondary,
                                    size: 16),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _bottomBar(product, cart),
          ],
        ),
      ),
    );
  }

  Widget _sellerCard(ProductModel product) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: product.sellerAvatar.isNotEmpty
              ? CachedNetworkImageProvider(product.sellerAvatar)
              : null,
          backgroundColor: AppColors.surface,
          child: product.sellerAvatar.isEmpty
              ? const Icon(Icons.person, color: AppColors.textSecondary)
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  product.sellerName.isEmpty
                      ? 'Jenny Doe'
                      : product.sellerName,
                  style: AppTextStyles.subtitle
                      .copyWith(fontWeight: FontWeight.w600)),
              Text(
                  product.sellerRole.isEmpty
                      ? 'Seller'
                      : product.sellerRole,
                  style: AppTextStyles.caption
                      .copyWith(color: AppColors.textSecondary)),
            ],
          ),
        ),
        _circleAction(Icons.chat_bubble_outline,
            () => Get.toNamed<void>(Routes.chat, arguments: product)),
        const SizedBox(width: 8),
        _circleAction(Icons.call_outlined, () {}),
      ],
    );
  }

  Widget _circleAction(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
            color: AppColors.primary, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _bottomBar(ProductModel product, CartController cart) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          )
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Price',
                  style: AppTextStyles.caption
                      .copyWith(color: AppColors.textSecondary)),
              Text(Currency.format(product.price),
                  style: AppTextStyles.h3
                      .copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: PrimaryButton(
              icon: Icons.shopping_bag_outlined,
              label: 'Add to Cart',
              onPressed: () {
                cart.addToCart(product,
                    size: _selectedSize, color: _selectedColor);
                Get.snackbar(
                  'Added to Cart',
                  '${product.name} added to your cart',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.primary,
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(16),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
