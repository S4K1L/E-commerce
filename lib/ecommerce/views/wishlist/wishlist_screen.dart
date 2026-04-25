import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../controllers/wishlist_controller.dart';
import '../../data/sample_data.dart';
import '../../models/product.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/product_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  String selected = 'All';
  final tabs = const ['All', 'Shoes', 'Clothes', 'Electronics', 'Furniture'];

  @override
  void initState() {
    super.initState();
    final wishlist = Get.find<WishlistController>();
    if (wishlist.items.isEmpty) {
      wishlist.items.addAll([
        SampleData.products[1],
        SampleData.products[2],
        SampleData.products[3],
        SampleData.products[0],
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final wishlist = Get.find<WishlistController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Wishlist', style: AppTextStyles.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) => CategoryChip(
                  label: tabs[i],
                  selected: selected == tabs[i],
                  onTap: () => setState(() => selected = tabs[i]),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              final List<ProductModel> items =
                  wishlist.byCategory(selected);
              if (items.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.favorite_border,
                          color: AppColors.primary, size: 48),
                      const SizedBox(height: 12),
                      Text('No items in wishlist',
                          style: AppTextStyles.body
                              .copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  itemCount: items.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (_, i) => ProductCard(product: items[i]),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
