import 'package:bdm/models/product_model.dart';
import 'package:bdm/views/base/product_card.dart';
import 'package:flutter/material.dart';

class ShowProductCards extends StatelessWidget {
  const ShowProductCards({
    super.key,
    required this.products,
    this.crossAxisCount = 2,
  });

  final List<ProductModel> products;

  /// Number of product cards per row (e.g. 6 on web, 2 on typical mobile).
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 181 / 240,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return FittedBox(
          fit: BoxFit.scaleDown,
          child: ProductCard(product: products[index]),
        );
      },
    );
  }
}
