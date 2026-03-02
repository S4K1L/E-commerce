import 'package:bdm/controllers/product_controller.dart';
import 'package:bdm/models/product_model.dart';
import 'package:bdm/services/api_service.dart';
import 'package:bdm/views/base/custom_app_bar.dart';
import 'package:bdm/views/base/custom_button.dart';
import 'package:bdm/views/base/custom_networked_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetails extends StatefulWidget {
  final ProductModel product;
  const ItemDetails({super.key, required this.product});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  final prod = Get.find<ProductController>();
  int count = 0;

  @override
  void initState() {
    super.initState();
    count = prod.cart[widget.product] ?? 0;
  }

  void addToCart() {
    if (count == 0) {
      setState(() {
        count = 1;
      });
    }
    prod.addToCart(widget.product, count: count);
    Get.snackbar(
      "product_added".tr,
      "products_added_cart".trParams({"count": count.toString()}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.product.companyName, hasActions: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12),
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
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 182,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Spacer(flex: 8),
                            CustomNetworkedImage(
                              url: ApiService.getImage(
                                widget.product.productImage,
                              ),
                              height: 130,
                            ),
                            Spacer(flex: 5),
                          ],
                        ),
                      ),
                      Container(
                        height: 24,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Color(0xffF4686E),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${widget.product.discountPercent}% ${"off".tr}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(0.5),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.product.productName,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 54),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).dividerColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "${widget.product.quantityPerBox} ${"pcs".tr}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.product.genericName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                        Text(
                          widget.product.companyName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                        Text(
                          widget.product.productDescription,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).textTheme.bodySmall?.color
                                ?.withValues(alpha: 0.7),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child:
                  (!widget.product.outOfStock)
                      ? Row(
                        children: [
                          count == 0
                              ? CustomButton(
                                text: "add_to_cart".tr,
                                padding: 10,
                                width: MediaQuery.of(context).size.width / 3,
                                height: 40,
                                isSecondary: true,
                                onTap: addToCart,
                              )
                              : Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        count -= 1;
                                      });
                                      prod.addToCart(
                                        widget.product,
                                        newCount: count,
                                      );
                                    },
                                    child: Container(
                                      height: 36,
                                      width: 36,
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
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Container(
                                    constraints: BoxConstraints(
                                      minWidth: 32,
                                      maxHeight: 32,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xff62C086),
                                      borderRadius: BorderRadius.circular(99),
                                    ),
                                    child: Center(
                                      child: Text(
                                        count.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        count += 1;
                                      });
                                      prod.addToCart(
                                        widget.product,
                                        newCount: count,
                                      );
                                    },
                                    child: Container(
                                      height: 36,
                                      width: 36,
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
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          Spacer(),
                          Container(
                            height: 38,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).dividerColor,
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Center(
                              child: Text(
                                "৳${widget.product.sellingPrice.toInt()}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Color(0xff62C086),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      : Center(
                        child: Text(
                          "out_of_stock".tr,
                          style: TextStyle(
                            color: Color(0xffF4686E),
                            fontSize: 16,
                          ),
                        ),
                      ),
            ),
            const SizedBox(height: 60),
            // if (!widget.product.outOfStock)
            //   CustomButton(
            //     text: "add_to_cart".tr,
            //     padding: 0,
            //     isSecondary: true,
            //     onTap: addToCart,
            //   ),
          ],
        ),
      ),
    );
  }
}
