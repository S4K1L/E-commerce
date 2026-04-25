import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../data/sample_data.dart';
import '../../models/product.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/product_card.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String categoryName =
        (Get.arguments as String?) ?? 'Furniture';
    final List<ProductModel> products = categoryName
                .toLowerCase()
                .contains('all')
        ? SampleData.products
        : SampleData.products
            .where((p) =>
                p.category.toLowerCase() == categoryName.toLowerCase())
            .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: AppBackButton(),
        ),
        title: Text(categoryName, style: AppTextStyles.title),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.tune, color: AppColors.textPrimary),
          ),
        ],
      ),
      body: products.isEmpty
          ? Center(
              child: Text('No products in $categoryName',
                  style: AppTextStyles.body
                      .copyWith(color: AppColors.textSecondary)),
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (_, i) => ProductCard(product: products[i]),
              ),
            ),
    );
  }
}
