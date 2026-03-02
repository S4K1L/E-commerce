import 'package:bdm/controllers/product_controller.dart';
import 'package:bdm/utils/custom_svg.dart';
import 'package:bdm/utils/formatter.dart';
import 'package:bdm/views/base/custom_loading.dart';
import 'package:bdm/views/screens/history/order_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final product = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    product.fetchHistory().then((message) {
      if (message != "success") {
        Get.snackbar("error_occurred".tr, message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(
          () => Column(
            spacing: 12,
            children: [
              const SizedBox(height: 0),
              if (product.isLoading.value)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomLoading(),
                ),
              for (var i in product.history)
                GestureDetector(
                  onTap: () {
                    Get.to(() => OrderDetails(order: i));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).dividerColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              Formatter.timeFormatter(dateTime: i.orderDate),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                i.invoiceNumber,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              Formatter.dateFormatter(i.orderDate),
                              style: TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color,
                                fontSize: 10,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "৳ ${i.totalAmount.toInt()}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Spacer(flex: 2),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).dividerColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(999),
                            ),
                          ),
                          child: Text(
                            "${i.orderStatus.substring(0, 1).toUpperCase()}${i.orderStatus.substring(1)}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color:
                                  i.orderStatus == "pending"
                                      ? Color(0xFFFFA500) // Orange
                                      : i.orderStatus == "shipped"
                                      ? Color(0xFF1E90FF) // Dodger Blue
                                      : i.orderStatus == "delivered"
                                      ? Color(0xFF28A745) // Green
                                      : i.orderStatus == "cancelled"
                                      ? Color(0xFFDC3545) // Red
                                      : Colors.black,
                            ),
                          ),
                        ),
                        Spacer(),
                        CustomSvg(asset: "assets/icons/arrow_right.svg"),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
