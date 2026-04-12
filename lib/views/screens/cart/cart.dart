import 'package:bdm/controllers/product_controller.dart';
import 'package:bdm/controllers/service_controller.dart';
import 'package:bdm/services/api_service.dart';
import 'package:bdm/views/base/custom_button.dart';
import 'package:bdm/views/base/custom_networked_image.dart';
import 'package:bdm/views/screens/cart/order_confimation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final prod = Get.find<ProductController>();

  void placeOrder() async {
    final message = await prod.placeOrder();

    if (message.contains("success")) {
      Get.to(() => OrderConfimation(id: message.split(" ").last));
    } else {
      Get.snackbar("error_occurred".tr, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Obx(
                  () => Text(
                    "${prod.cart.length} ${"cart_items".tr}",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Obx(
                  () => Column(
                    spacing: 25,
                    children: [
                      if (prod.cart.isEmpty)
                        Text("cart_empty".tr, style: TextStyle()),
                      for (var i in prod.cart.keys)
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).dividerColor,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(99),
                                child: Center(
                                  child: CustomNetworkedImage(
                                    url: ApiService.getImage(i.productImage),
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    i.productName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    i.companyName,
                                    style: TextStyle(
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodySmall?.color,
                                      fontSize: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                prod.decreaseQuantity(i);
                              },
                              child: Container(
                                height: 28,
                                width: 28,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).dividerColor,
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
                            Obx(
                              () => Container(
                                constraints: BoxConstraints(
                                  minWidth: 24,
                                  maxHeight: 24,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  color:
                                      prod.cart[i] == null
                                          ? Color(0xffF4686E)
                                          : Color(0xff62C086),
                                  borderRadius: BorderRadius.circular(99),
                                ),
                                child: Center(
                                  child: Text(
                                    "${prod.cart[i] ?? "0"}",
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
                                prod.addToCart(i);
                              },
                              child: Container(
                                height: 28,
                                width: 28,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).dividerColor,
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
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 2,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "৳${i.sellingPrice.toInt()}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(8),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  spacing: 12,

                  children: [
                    Row(
                      children: [
                        Text(
                          "subtotal".tr,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                        Spacer(),
                        Obx(
                          () => Text(
                            "৳${prod.getSubTotal().toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  Theme.of(context).textTheme.bodySmall?.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "delivery".tr,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                        Spacer(),
                        Obx(
                          () => Text(
                            "৳${(Get.find<ServiceController>().serviceInfo.value?.deliveryCharge ?? 100).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  Theme.of(context).textTheme.bodySmall?.color,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Row(
                    //   children: [
                    //     Text(
                    //       "discount".tr,
                    //       style: TextStyle(
                    //         fontSize: 14,
                    //         color: Theme.of(context).textTheme.bodySmall?.color,
                    //       ),
                    //     ),
                    //     Spacer(),
                    //     Obx(
                    //       () => Text(
                    //         "- ৳${prod.getTotalDiscount().toStringAsFixed(2)}",
                    //         style: TextStyle(
                    //           fontSize: 14,
                    //           color:
                    //               Theme.of(context).textTheme.bodySmall?.color,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      children: [
                        Text(
                          "total".tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        Spacer(),
                        Obx(
                          () => Text(
                            "৳${(prod.getTotal() + (Get.find<ServiceController>().serviceInfo.value?.deliveryCharge ?? 100)).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Obx(() {
                  if (prod.cartCondition.isEmpty) {
                    return const Text("No data found"); // debug indicator
                  }

                  return Column(
                    spacing: 6,
                    children:
                        prod.cartCondition.map((text) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 4.0,
                                  right: 16,
                                ),
                                child: Container(
                                  height: 12,
                                  width: 12,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffF4686E),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  text,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodySmall?.color,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                  );
                }),
              ),
              const SizedBox(height: 50),
              if (prod.cart.isNotEmpty) ...[
                Obx(
                  () => CustomButton(
                    text: "place_order".tr,
                    isLoading: prod.isPlacingOrder.value,
                    isDisabled: prod.cart.isEmpty,
                    onTap: () => placeOrder(),
                  ),
                ),
              ],

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
