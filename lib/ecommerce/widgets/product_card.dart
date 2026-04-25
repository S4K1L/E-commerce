import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';
import '../config/app_routes.dart';
import '../config/app_text_styles.dart';
import '../controllers/wishlist_controller.dart';
import '../models/product.dart';
import '../utils/currency.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final double? width;
  final bool showFavorite;

  const ProductCard({
    super.key,
    required this.product,
    this.width,
    this.showFavorite = true,
  });

  @override
  Widget build(BuildContext context) {
    final wishlist = Get.find<WishlistController>();

    return GestureDetector(
      onTap: () => Get.toNamed<void>(Routes.productDetails, arguments: product),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16)),
                  child: AspectRatio(
                    aspectRatio: 1.05,
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        color: AppColors.surface,
                      ),
                      errorWidget: (_, __, ___) => Container(
                        color: AppColors.surface,
                        alignment: Alignment.center,
                        child: const Icon(Icons.image_outlined,
                            color: AppColors.textHint),
                      ),
                    ),
                  ),
                ),
                if (showFavorite)
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Obx(() {
                      final isFav = wishlist.isFavorite(product.id);
                      return GestureDetector(
                        onTap: () => wishlist.toggle(product),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 6,
                              )
                            ],
                          ),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: AppColors.primary,
                            size: 18,
                          ),
                        ),
                      );
                    }),
                  ),
                if (product.rating > 0)
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star,
                              color: AppColors.star, size: 12),
                          const SizedBox(width: 4),
                          Text(product.rating.toStringAsFixed(1),
                              style: AppTextStyles.caption.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.subtitle
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    Currency.format(product.price),
                    style: AppTextStyles.price
                        .copyWith(color: AppColors.primary, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
