import 'package:bdm/models/product_model.dart';
import 'package:bdm/views/base/product_card.dart';
import 'package:flutter/material.dart';

class ShowProductCards extends StatelessWidget {
  const ShowProductCards({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 cards per row
        crossAxisSpacing: 12, // horizontal spacing
        mainAxisSpacing: 12, // vertical spacing
        childAspectRatio: 181 / 240, // adjust height vs width
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
