import 'package:bdm/controllers/product_controller.dart';
import 'package:bdm/models/product_model.dart';
import 'package:bdm/services/api_service.dart';
import 'package:bdm/views/screens/home/item_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ItemDetails(product: product));
      },
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(12),
        child: SizedBox(
          height: 240,
          child: Stack(
            children: [
              Container(
                width: 181,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6, bottom: 0),
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(4),
                        child: CachedNetworkImage(
                          imageUrl:
                              ApiService.getImage(product.productImage) ?? "",
                          height: 74,
                          width: 74,
                          placeholder: (context, url) {
                            return Shimmer.fromColors(
                              baseColor: Colors.white.withValues(alpha: 0.16),
                              highlightColor: Color(0xff44B46E),
                              period: Duration(milliseconds: 800),
                              child: Container(
                                height: 74,
                                width: 74,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Container(
                              width: 74,
                              height: 74,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Color(0xff44B46E)),
                              ),
                              child: Icon(
                                Icons.error,
                                color: Color(0xff44B46E),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 0.5,
                      color: Theme.of(context).dividerColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                        child: Column(
                          spacing: 4,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.productName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.color,
                              ),
                            ),
                            Text(
                              product.genericName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 10,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color,
                              ),
                            ),
                            Text(
                              product.companyName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 10,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    "৳${product.mrp}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodySmall?.color,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ),
                                Text(
                                  "৳${product.sellingPrice}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(0xffF4686E),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (product.discountPercent != 0)
                Container(
                  height: 22,
                  width: 65,
                  decoration: BoxDecoration(
                    color: Color(0xffF4686E),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text("${product.discountPercent}% ${"off".tr}"),
                      ),
                    ),
                  ),
                ),
              Obx(() {
                final prod = Get.find<ProductController>();

                bool stockOut = product.outOfStock;
                bool stockQuantity = product.stockQuantity < 1;
                bool inCart = prod.cartContains(product) != 0;

                return Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      if (stockOut) return;
                      if (!inCart) {
                        prod.addToCart(product);
                      }
                    },
                    child:
                        inCart
                            ? Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      prod.decreaseQuantity(product);
                                    },
                                    child: Container(
                                      height: 28,
                                      width: 28,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(
                                          (8 * 2.55).toInt(),
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          bottomLeft: Radius.circular(24),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "-",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  GestureDetector(
                                    child: Container(
                                      constraints: BoxConstraints(
                                        minWidth: 24,
                                        maxHeight: 24,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xff44B46E),
                                        borderRadius: BorderRadius.circular(99),
                                      ),
                                      child: Center(
                                        child: Text(
                                          prod.cartContains(product).toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  GestureDetector(
                                    onTap: () {
                                      prod.addToCart(product);
                                    },
                                    child: Container(
                                      height: 28,
                                      width: 28,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(
                                          (8 * 2.55).toInt(),
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(24),
                                          bottomRight: Radius.circular(24),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "+",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    stockOut
                                        ? Colors.red
                                        : stockQuantity
                                        ? Colors.yellow
                                        : inCart
                                        ? Colors.white.withValues(alpha: 0.24)
                                        : Color(0xff44B46E),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  stockOut
                                      ? "out_of_stock".tr
                                      : inCart
                                      ? "go_to_cart".tr
                                      : "add_to_cart".tr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        stockOut
                                            ? Colors.white
                                            : stockQuantity
                                            ? Colors.black
                                            : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                  ),
                );
              }),

              Positioned(
                top: 53,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "${product.quantityPerBox} pcs",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
